`timescale 1ns / 1ps




module ALU_Control(
input [1:0] ALUOp, 
input [4:0] Funct, //{funct7[0],funct7[5], funct3}
output reg [3:0] ALU_cmd,
output IsMul
    );
    
localparam BASIC_OPERATIONS = 2'b10;
localparam MEMORY_OPERATIONS = 2'b00;
localparam BRANCH_OPERATIONS = 2'b01;

localparam BEQ = 3'h0;
localparam BNE = 3'h1;
localparam BLT = 3'h4;
localparam BGE = 3'h5;
localparam BLTU = 3'h6;
localparam BGEU = 3'h7;
localparam NO_BRANCH = 3'hf;

localparam MUL = 3'h0;
localparam MULH = 3'h1;
localparam MULSU = 3'h2;
localparam MULU = 3'h3;
localparam DIV = 3'h4;
localparam DIVU = 3'h5;
localparam REM = 3'h6;
localparam REMU = 3'h7;


`include "riscv_ctrl_para.v"

assign IsMul = Funct[4] & (ALUOp == BASIC_OPERATIONS);
wire [2:0] Funct3 = Funct[2:0];

always @(*) begin

    casez(ALUOp)
        BASIC_OPERATIONS: 
            if(IsMul == 'd0) begin
                case(Funct[3:0]) 
                    4'b0000: ALU_cmd = `ALU_OPERATION_ADD;
                    4'b1000: ALU_cmd = `ALU_OPERATION_SUB; 
                    4'b0100: ALU_cmd = `ALU_OPERATION_XOR; 
                    4'b0110: ALU_cmd = `ALU_OPERATION_OR;
                    4'b0111: ALU_cmd = `ALU_OPERATION_AND; 
                    4'b0001: ALU_cmd = `ALU_OPERATION_SLL;            
                    4'b0101: ALU_cmd = `ALU_OPERATION_SRL; 
                    4'b1101: ALU_cmd = `ALU_OPERATION_SRA; 
                    4'b0010: ALU_cmd = `ALU_OPERATION_SLT; 
                    4'b0011: ALU_cmd = `ALU_OPERATION_SLTU;                 
                    default: ALU_cmd = `ALU_OPERATION_DEFAULT;
                endcase
            end
            else begin
                case(Funct3) 
                    MUL: ALU_cmd = `ALU_OPERATION_MUL;
                    MULH: ALU_cmd = `ALU_OPERATION_MULH; 
                    MULSU: ALU_cmd = `ALU_OPERATION_MULSU; 
                    MULU: ALU_cmd = `ALU_OPERATION_MULU;
                    DIV: ALU_cmd = `ALU_OPERATION_DIV; 
                    DIVU: ALU_cmd = `ALU_OPERATION_DIVU;            
                    REM: ALU_cmd = `ALU_OPERATION_REM; 
                    REMU: ALU_cmd = `ALU_OPERATION_REMU;               
                    default: ALU_cmd = `ALU_OPERATION_DEFAULT;
                endcase
            end
        MEMORY_OPERATIONS:
            ALU_cmd = `ALU_OPERATION_ADD;
        BRANCH_OPERATIONS:
            case(Funct3)
                BEQ: ALU_cmd = `ALU_OPERATION_BEQ;
                BNE: ALU_cmd = `ALU_OPERATION_BNE;
                BLT: ALU_cmd = `ALU_OPERATION_BLT;
                BGE: ALU_cmd = `ALU_OPERATION_BGE;
                BLTU: ALU_cmd = `ALU_OPERATION_BLTU;
                BGEU: ALU_cmd = `ALU_OPERATION_BGEU;
                default: ALU_cmd = `ALU_OPERATION_DEFAULT;
            endcase    
        default: ALU_cmd = `ALU_OPERATION_DEFAULT;
    endcase

end
    
    
    
endmodule



/* R format
0000000 000  add
0100000 000  sub
0000000 100  xor
0000000 110  or
0000000 111  and
0000000 001  sll
0000000 101  slr
0100000 101  sra
0000000 010  slt
0000000 011  sltu
*/