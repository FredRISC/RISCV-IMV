`timescale 1ns / 1ps



module Control_Unit(
input [6:0] opcode,
output reg Branch,
output reg MemRead,
output reg MemtoReg,
output reg [1:0] ALUOp,
output reg MemWrite,
output reg ALUSrc,
output reg RegWrite
    );
    
`include "riscv_ctrl_para.v"
localparam R_type = 7'b0110011;
localparam I_R_type = 7'b0110011;
localparam I_load_type = 7'b0000011;
localparam S_type = 7'b0100011;
localparam B_type = 7'b1100011;


always @(opcode) begin

    casez(opcode) //don't cares are set to 0
        R_type: 
            {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10};
        I_R_type: 
            {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10};
        I_load_type:
            {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,2'b00};       
        S_type: 
            {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {1'b1,1'b1,1'b0,1'b0,1'b1,1'b0,2'b00};
        B_type: 
            {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {1'b0,1'b1,1'b0,1'b0,1'b0,1'b1,2'b01};
        default: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {8{1'bx}};  
    endcase

end
    
endmodule
