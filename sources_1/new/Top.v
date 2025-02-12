`timescale 1ns / 1ps

module Top(
input clk,
input rst,
output [31:0] test
    );
`include "riscv_ctrl_para.v"              
//program counter and instruction
wire [31:0] Instruction;
wire [31:0] pc;
//wire [`datawidth-1:0] pc_imm;

//Immediate
wire signed [`datawidth-1:0] imm_out;

//Define control signals
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

//Parsing instruction
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] funct3;
wire [6:0] funct7;
wire [6:0] opcode; //Decide instruction format
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign rs1 = Instruction[19:15];
assign rs2 = Instruction[24:20];
assign rd = Instruction[11:7];
assign opcode = Instruction[6:0]; 

//register data
wire [`datawidth-1:0] rdata1; 
wire [`datawidth-1:0] rdata2;
wire [`datawidth-1:0] wdata;
//ALU
wire [3:0] ALU_cmd;
wire [4:0] ALU_Funct = {funct7[0],funct7[5], funct3}; //MSb is used to check if it's of M-extension
wire IsMul;
wire [`datawidth-1:0] ALU_a = rdata1;
wire [`datawidth-1:0] ALU_b;
wire [`datawidth-1:0] ALU_result;
wire PC_branch;
//data memory
wire [`datawidth-1:0] rd_MemData;
wire [`datawidth-1:0] wr_MemData = rdata2;
wire [`DataMemorySize-3:0] MemAddr = ALU_result[`DataMemorySize-3:0];

//Instantiate modules
program_counter program_counter_inst(clk, rst, imm_out, PC_branch, pc);
InstMem InstMem_inst(pc, Instruction);
Control_Unit Control_Unit_inst(.opcode(opcode), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
Imm_gen Imm_gen_inst(.inst(Instruction), .imm_out(imm_out));
Registerfile Registerfile_inst(.clk(clk), .rst(rst), .wdata(wdata), .rs1(rs1), .rs2(rs2), .rd(rd), .RegWrite(RegWrite), .rdata1(rdata1), .rdata2(rdata2));
ALU_Control ALU_Control_inst(ALUOp,ALU_Funct,ALU_cmd,IsMul);
ALU ALU_inst(ALU_a,ALU_b,ALU_cmd,IsMul,ALU_result,PC_branch);
Mux ALU_SRC_MUX(ALUSrc,rdata2,imm_out,ALU_b);
DataMem DataMem_inst(clk,MemWrite,MemRead,funct3,MemAddr,wr_MemData,rd_MemData);
Mux DataMem_MUX(MemtoReg,rd_MemData,ALU_result,wdata);

endmodule



