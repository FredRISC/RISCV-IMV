`timescale 1ns / 1ps


`include "riscv_ctrl_para.v"
module InstMem(
input [`datawidth-1:0] InstAddress,
output [31:0] Inst
    );
    
wire [7:0] MEMORY [`InstMemorySize-1:0]; //32-bit instruction memory

assign Inst = {MEMORY[InstAddress+3],MEMORY[InstAddress+2],MEMORY[InstAddress+1],MEMORY[InstAddress]};


//Initialize some instructions below


assign MEMORY[0]=8'b1_0010011;//addi rd rs1 imm //addi x9 x0 10 //x9=10
assign MEMORY[1]=8'b0_000_0100;
assign MEMORY[2]=8'b1010_0000;
assign MEMORY[3]=8'b00000000;


assign MEMORY[4]=8'b0_0100011;//sw rs1 rs2 imm //sw x0 x9 4 //MEM[10]=4
assign MEMORY[5]=8'b0_010_0010;    
assign MEMORY[6]=8'b1001_0000;
assign MEMORY[7]=8'b0000000_0;   


assign MEMORY[8]=8'b1_0010011;//addi rd rs1 imm //addi x5 x0 15 //x5=15
assign MEMORY[9]=8'b0_000_0010;
assign MEMORY[10]=8'b1111_0000;
assign MEMORY[11]=8'b00000000;

assign MEMORY[12]=8'b0_0110011;//add rd rs1 rs2 //add x4 x5 x9 //x4=x9+x5=25
assign MEMORY[13]=8'b1_000_0010;
assign MEMORY[14]=8'b1001_0010;
assign MEMORY[15]=8'b0000000_0;


assign MEMORY[16]=8'b1_0000011;//lw rd rs1 imm //lw x3 x9 0  //x3=MEM[10]=4
assign MEMORY[17]=8'b1_001_0001;
assign MEMORY[18]=8'b0000_0100;
assign MEMORY[19]=8'b00000000;


//x3 loaduse hazard 
assign MEMORY[20]=8'b0_0110011;//add rd rs1 rs2 //add x4 x3 x5 //x4=x3+x5=19=10011
assign MEMORY[21]=8'b1_000_0010;
assign MEMORY[22]=8'b0101_0001;
assign MEMORY[23]=8'b0000000_0;





endmodule