`timescale 1ns / 1ps


`include "riscv_ctrl_para.v"
module InstMem(
input [`datawidth-1:0] InstAddress,
output [31:0] Inst
    );
    
wire [7:0] MEMORY [`InstMemorySize-1:0]; //32-bit instruction memory

assign Inst = {MEMORY[InstAddress+3],MEMORY[InstAddress+2],MEMORY[InstAddress+1],MEMORY[InstAddress]};


//Initialize some instructions below
assign MEMORY[0]=8'b1_0000011;//lw rd rs1 imm
assign MEMORY[1]=8'b0_001_0100;
assign MEMORY[2]=8'b0000_0101;
assign MEMORY[3]=8'b00001111;

assign MEMORY[4]=8'b1_0110011;//add rd rs1 rs2
assign MEMORY[5]=8'b1_000_0100;
assign MEMORY[6]=8'b1001_1010;
assign MEMORY[7]=8'b0000000_0;

assign MEMORY[8]=8'b1_0010011;//addi rd rs1 imm
assign MEMORY[9]=8'b1_000_0100;
assign MEMORY[10]=8'b0001_0100;
assign MEMORY[11]=8'b00000000;

assign MEMORY[12]=8'b0_0100011;//sw rs1 rs2 imm
assign MEMORY[13]=8'b0_010_1000;    
assign MEMORY[14]=8'b1001_0101;
assign MEMORY[15]=8'b0000111_0;   
    
endmodule