module alu32(
    output reg [31:0] alu_out,
    input [31:0] a,
    input [31:0] b,
    input [5:0] shamt,
    output reg zout,
    input [2:0] alu_control
);

reg [31:0] less;

always @(*) begin
    case (alu_control)
        3'b000: alu_out = a & b;              // AND
        3'b001: alu_out = a | b;              // OR
        3'b010: alu_out = a + b;              // ADD
        3'b011: alu_out = a ^ b;              // XOR
        3'b100: alu_out = ~(a & b);            // NAND  ⭐
        3'b101: alu_out = b << shamt;          // SLL   ⭐
        3'b110: alu_out = a + 1 + (~b);        // SUB
        3'b111: begin                          // SLT
            less = a + 1 + (~b);
            alu_out = less[31] ? 32'd1 : 32'd0;
        end
        default: alu_out = 32'b0;
    endcase

    zout = ~(|alu_out);
end

endmodule

