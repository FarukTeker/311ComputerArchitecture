module control(
    in, f,
    regdest, alusrc, memtoreg, regwrite,
    memread, memwrite, branch,
    aluop1, aluop2,
    jal, jump, jr
);

input  [5:0] in;   // opcode[5:0]
input  [3:0] f;    // funct[3:0] (R-type alt bitler)

output regdest, alusrc, memtoreg, regwrite;
output memread, memwrite, branch;
output aluop1, aluop2;
output jal, jump, jr;

// -------------------------
// OPCODE TANIMLARI (CUSTOM)
// -------------------------
// R-type   : 111 -> 0b1101111 -> alt 6 bit: 101111
// lw       : 112 -> 0b01110000 -> alt 6 bit: 110000
// sw       : 113 -> 0b01110001 -> alt 6 bit: 110001
// beq      : 114 -> 0b01110010 -> alt 6 bit: 110010
// blt      : 115 -> 0b01110011 -> alt 6 bit: 110011
// subi     : 116 -> 0b01110100 -> alt 6 bit: 110100
// addi     : 117 -> 0b01110101 -> alt 6 bit: 110101
// beqi     : 118 -> 0b01110110 -> alt 6 bit: 110110
// j        : 119 -> 0b01110111 -> alt 6 bit: 110111

wire rformat, lw, sw, beq, blt, addi, subi, beqi, j, jall, jump_reg;

// R-type
assign rformat = (in == 6'b101111);

// Load / Store
assign lw   = (in == 6'b110000);
assign sw   = (in == 6'b110001);

// Branch
assign beq  = (in == 6'b110010);
assign blt  = (in == 6'b110011);
assign beqi = (in == 6'b110110);

// Immediate aritmetik
assign subi = (in == 6'b110100);
assign addi = (in == 6'b110101);

// Jump
assign j    = (in == 6'b110111);
assign jall = 1'b0;        // Part 1'de JAL yok (istersen ekleriz)
assign jump_reg = 1'b0;    // JR şimdilik kapalı

// -------------------------
// CONTROL SİNYALLERİ
// -------------------------

assign regdest  = rformat;
assign alusrc   = lw | sw | addi | subi;
assign memtoreg = lw;
assign regwrite = rformat | lw | addi | subi;
assign memread  = lw;
assign memwrite = sw;

// Branch: beq, blt, beqi
assign branch   = beq | blt | beqi;

// ALUOp mantığı (lab tarzı korunuyor)
assign aluop1   = rformat | blt;
assign aluop2   = beq | subi;

// Jump sinyalleri
assign jal  = jall;
assign jump = j;
assign jr   = jump_reg;

endmodule

