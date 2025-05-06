`timescale 1ns / 1ps

module Top(
input clk,
input rst
    );
    
    
`include "riscv_ctrl_para.v"              
`include "riscv_data_def.v"

/*Instantiate modules*/

//IF stage 
wire final_branch_verdict = EXMEM_Branch_o & EXMEM_PC_branch_o;
program_counter program_counter_inst(clk, rst, PC_stall, EXMEM_PC_imm_o, final_branch_verdict, pc);
InstMem InstMem_inst(pc, Instruction);

//ID stage
Instruction_parser Instruction_parser_inst(IFID_inst_o, funct3, funct7, rs1, rs2, rd, opcode); 
assign Funct = {funct7[0],funct7[5], funct3}; //MSb is used to check if it's of M-extension

Control_Unit Control_Unit_inst(.opcode(opcode), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
Imm_gen Imm_gen_inst(.inst(IFID_inst_o), .imm_out(imm_out));
Registerfile Registerfile_inst(.clk(clk), .rst(rst), .wdata(wdata), .rs1(rs1), .rs2(rs2), .rd(rd), .RegWrite(RegWrite), .rdata1(rdata1), .rdata2(rdata2));

//EX stage ALU modules
ALU_Control ALU_Control_inst(IDEX_ALUOp_o,IDEX_Funct_o,ALU_cmd,IsMul);
Mux3 Mux3_ins_OperandA(ForwardA,IDEX_rs1_o,wdata,EXMEM_ALU_result_o,ALU_a);
Mux3 Mux3_ins_Operandb(ForwardB,IDEX_rs2_o,wdata,EXMEM_ALU_result_o,ALU_b_SRC0);
Mux ALU_SRC_MUX(IDEX_ALUSrc_o,ALU_b_SRC0,IDEX_imm_data_o,ALU_b); 
ALU ALU_inst(ALU_a,ALU_b,ALU_cmd,IsMul,ALU_result,PC_branch);


//MEM stage Data Memory modules
DataMem DataMem_inst(clk,EXMEM_MemWrite_o,EXMEM_MemRead_o,EXMEM_funct3_o,EXMEM_ALU_result_o,EXMEM_wr_MemData_o,rd_MemData);

//WB stage write data Mux 
Mux DataMem_MUX(MEMWB_MemtoReg_o,MEMWB_ALU_result_o,MEMWB_rd_MemData_o,wdata);


//Stall unit & Load-Use hazard handler
LoadUse_hazard LoadUse_hazard_inst( //LoadUse_hazard
IDEX_MemRead_o,
rs1, rs2, IDEX_rd_o,
LoadUseHazard_o
);

stall stall_inst(
LoadUseHazard_o,
PC_stall,
IFID_stall,
IDEX_stall,
EXMEM_bubble,
EXMEM_stall,
MEMWB_stall
);
//stall unit ends


//IF-ID stage 

IFID IFID_inst(
clk,
rst,
IFID_stall,
Instruction,
pc,
IFID_inst_o,
IFID_pc_o
);
//IF-ID ends


//ID-EX stage 
IDEX IDEX_inst(
clk,
rst,
IDEX_stall,
IFID_pc_o,
Branch,
MemRead,
MemtoReg,
ALUOp,
MemWrite,
ALUSrc,
RegWrite,
rdata1,
rdata2,
imm_out,
rs1,
rs2,
rd,
Funct,
LoadUseHazard,
IDEX_PC_o,
IDEX_Branch_o,
IDEX_MemRead_o,
IDEX_MemtoReg_o,
IDEX_ALUOp_o,
IDEX_MemWrite_o,
IDEX_ALUSrc_o,
IDEX_RegWrite_o,
IDEX_rd_data1_o,
IDEX_rd_data2_o,
IDEX_imm_data_o,
IDEX_rs1_o,
IDEX_rs2_o,
IDEX_rd_o,
IDEX_Funct_o,
LoadUseHazard_o
);
//ID-EX stage ends


//EX-MEM stage
assign EXMEM_funct3 = IDEX_Funct_o[2:0];
EXMEM EXMEM_inst(
clk,
rst,
EXMEM_stall,
EXMEM_bubble,
IDEX_Branch_o,
IDEX_MemRead_o,
IDEX_MemtoReg_o,
IDEX_MemWrite_o,
IDEX_RegWrite_o,
IDEX_imm_data_o,
IDEX_rd_o,
ALU_result,
ALU_b_SRC0,
PC_branch,
EXMEM_funct3,
EXMEM_Branch_o,
EXMEM_MemRead_o,
EXMEM_MemtoReg_o,
EXMEM_MemWrite_o,
EXMEM_RegWrite_o,
EXMEM_PC_imm_o,
EXMEM_rd_o,
EXMEM_ALU_result_o,
EXMEM_wr_MemData_o,
EXMEM_PC_branch_o,
EXMEM_funct3_o
);
//EX-MEM stage ends


//MEM-WB stage

MEMWB MEMWB_inst(
clk,
rst,
MEMWB_stall,
EXMEM_MemtoReg_o,
EXMEM_RegWrite_o,
EXMEM_rd_o,
rd_MemData,
EXMEM_ALU_result_o,
MEMWB_MemtoReg_o,
MEMWB_RegWrite_o,
MEMWB_rd_o,
MEMWB_rd_MemData_o,
MEMWB_ALU_result_o
);
//MEM-WB ends



//Hazard Forwarding unit 

Forwarding Forwarding_inst(
IDEX_rs1, IDEX_rs2, 
EXMEM_rd_o, 
MEMWB_rd_o,
EXMEM_RegWrite_o,
MEMWB_RegWrite_o,
ForwardA,
ForwardB
);


endmodule



