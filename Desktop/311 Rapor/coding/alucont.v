module alucont(
    input aluop1,
    input aluop0,
    input [5:0] funct,
    output reg [2:0] gout
);

always @(*) begin
    if (!aluop1 && !aluop0)
        gout = 3'b010; // add (lw, sw, addi)

    else if (aluop0)
        gout = 3'b110; // sub (beq, subi)

    else if (aluop1) begin
        case (funct)
            6'b000001: gout = 3'b101; // sll
            6'b000010: gout = 3'b010; // move (ADD + b=0)
            6'b000011: gout = 3'b100; // nand
            6'b000100: gout = 3'b001; // or
            6'b000101: gout = 3'b010; // add
            default:   gout = 3'b010;
        endcase
    end
end

endmodule

