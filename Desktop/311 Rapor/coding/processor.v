module processor;

//////////////////// CLOCK & PC ////////////////////
reg clk;
reg [31:0] pc;

//////////////////// MEMORIES ////////////////////
reg [7:0] datmem[0:63], mem[0:31];

//////////////////// WIRES ////////////////////
wire [31:0] dataa, datab;
wire [31:0] out2, out3, out4, out5, out6;
wire [31:0] sum, extad, adder1out, adder2out, shiftextad, jump_address;
wire [31:0] instruc, dpack;

wire [25:0] inst25_0;
wire [5:0]  inst31_26;
wire [4:0]  inst25_21, inst20_16, inst15_11, out1;
wire [15:0] inst15_0;
wire [27:0] jump_ext;
wire [5:0]  shamt;

//////////////////// STACK REGISTERS ////////////////////
wire [31:0] sp, spba, spl;
wire [31:0] stack_low;
wire overflow, underflow;
wire stack_access;

//////////////////// CONTROL ////////////////////
wire zout, pcsrc;
wire regdest, alusrc, memtoreg, regwrite, memread, memwrite;
wire branch, aluop1, aluop0, jal, jump, jr;
wire [2:0] gout;

// masked (safe) control signals
wire safe_regwrite, safe_memwrite, safe_memread;

//////////////////// REGISTER FILE ////////////////////
reg [31:0] registerfile [0:31];

integer i;

//////////////////// DATA MEMORY ////////////////////
always @(posedge clk) begin
    if (safe_memwrite) begin
        datmem[sum[5:0] + 3] <= datab[7:0];
        datmem[sum[5:0] + 2] <= datab[15:8];
        datmem[sum[5:0] + 1] <= datab[23:16];
        datmem[sum[5:0]]     <= datab[31:24];
    end
end

//////////////////// INSTRUCTION MEMORY ////////////////////
assign instruc = {
    mem[pc[4:0]],
    mem[pc[4:0] + 1],
    mem[pc[4:0] + 2],
    mem[pc[4:0] + 3]
};

assign inst31_26 = instruc[31:26];
assign inst25_21 = instruc[25:21];
assign inst20_16 = instruc[20:16];
assign inst15_11 = instruc[15:11];
assign inst15_0  = instruc[15:0];
assign inst25_0  = instruc[25:0];

//////////////////// REGISTER READ ////////////////////
assign dataa = registerfile[inst25_21];
assign datab = registerfile[inst20_16];

//////////////////// STACK REGISTERS ////////////////////
assign sp   = registerfile[14]; // stack pointer
assign spba = registerfile[12]; // stack base address
assign spl  = registerfile[13]; // stack limit (words)

assign stack_low = spba - (spl << 2);

// stack boundary checks
assign overflow  = (sp > spba);
assign underflow = (sp < stack_low);

// stack address usage detection
assign stack_access = (sum >= stack_low) && (sum <= spba);

//////////////////// SAFE CONTROL (PART 2 CORE) ////////////////////
assign safe_regwrite = regwrite & ~(stack_access & (overflow | underflow));
assign safe_memwrite = memwrite & ~(stack_access & (overflow | underflow));
assign safe_memread  = memread  & ~(stack_access & (overflow | underflow));

//////////////////// DATA PACK ////////////////////
assign dpack = {
    datmem[sum[5:0]],
    datmem[sum[5:0] + 1],
    datmem[sum[5:0] + 2],
    datmem[sum[5:0] + 3]
};

//////////////////// JUMP ADDRESS ////////////////////
shifter shifter1(jump_ext, inst25_0);
assign jump_address = {adder1out[31:28], jump_ext};

//////////////////// MULTIPLEXERS ////////////////////
mult2_to_1_5  mult1(out1, inst20_16, inst15_11, regdest);
mult2_to_1_32 mult2(out2, datab, extad, alusrc);
mult2_to_1_32 mult3(out3, sum, dpack, memtoreg);
mult2_to_1_32 mult4(out4, adder1out, adder2out, pcsrc);
mult2_to_1_32 mult6(out5, out4, jump_address, jump);
mult2_to_1_32 mult7(out6, out5, registerfile[5'b11111], jr);

//////////////////// SHAMT ////////////////////
assign shamt = instruc[11:6];

//////////////////// WRITE BACK ////////////////////
always @(posedge clk) begin
    if (safe_regwrite)
        registerfile[out1] <= out3;

    if (jal)
        registerfile[5'b11111] <= adder1out;
end

//////////////////// PC UPDATE ////////////////////
always @(posedge clk)
    pc <= out6;

//////////////////// ALU & CONTROL ////////////////////
alu32 alu1(sum, dataa, out2, shamt, zout, gout);

adder add1(pc, 32'h4, adder1out);
adder add2(adder1out, shiftextad, adder2out);

control cont(
    inst31_26,
    instruc[3:0],
    regdest, alusrc, memtoreg, regwrite,
    memread, memwrite, branch,
    aluop1, aluop0,
    jal, jump, jr
);

signext signextender(inst15_0, extad);
alucont acont(aluop1, aluop0, instruc[5:0], gout);
shift shift2(shiftextad, extad);

assign pcsrc = branch && zout;

//////////////////// INITIALIZATION ////////////////////
initial begin
    $readmemh("/home/omer/Desktop/Odev1/coding/initDM.dat", datmem);
    $readmemh("/home/omer/Desktop/Odev1/coding/initIM.dat", mem);
    $readmemh("/home/omer/Desktop/Odev1/coding/initReg.dat", registerfile);

    for (i = 0; i < 31; i = i + 1)
        $display("IM[%0d]=%h DM[%0d]=%h REG[%0d]=%h",
                 i, mem[i], i, datmem[i], i, registerfile[i]);
end

//////////////////// CLOCK ////////////////////
initial begin
    pc = 0;
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    #400 $finish;
end

//////////////////// MONITOR ////////////////////
initial begin
    $monitor($time,
        " PC=%h SP=%h LOW=%h OVF=%b UNF=%b MEMW=%b REGW=%b",
        pc, sp, stack_low, overflow, underflow,
        safe_memwrite, safe_regwrite
    );
end

endmodule

