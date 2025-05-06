`timescale 1ns / 1ps

`include "riscv_ctrl_para.v"

//program counter and instruction
wire [`datawidth-1:0] Instruction;
wire [`datawidth-1:0] pc;

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
wire [6:0] opcode; 


//register data
wire [`datawidth-1:0] rdata1; 
wire [`datawidth-1:0] rdata2;
wire [`datawidth-1:0] wdata;
//Scalar functional unit (ALU)
wire [4:0] Funct;
wire [3:0] ALU_cmd;
wire IsMul;
wire [`datawidth-1:0] ALU_b_SRC0;
wire [`datawidth-1:0] ALU_a;
wire [`datawidth-1:0] ALU_b;
wire [`datawidth-1:0] ALU_result;
wire PC_branch;
//data memory
wire [`datawidth-1:0] rd_MemData;
wire [`datawidth-1:0] wr_MemData;


//Stall unit 
wire LoadUseHazard;
wire PC_stall;
wire IFID_stall;
wire IDEX_stall;
wire EXMEM_stall;
wire EXMEM_bubble;
wire MEMWB_stall;



//IF-ID stage 
wire [`datawidth-1:0] IFID_inst_o;
wire [`datawidth-1:0] IFID_pc_o;



//ID-EX stage 
wire [`datawidth-1:0] IDEX_PC_o;
wire IDEX_Branch_o;
wire IDEX_MemRead_o;
wire IDEX_MemtoReg_o;
wire [1:0] IDEX_ALUOp_o;
wire IDEX_MemWrite_o;
wire IDEX_ALUSrc_o;
wire IDEX_RegWrite_o;
wire [`datawidth-1:0] IDEX_rd_data1_o;
wire [`datawidth-1:0] IDEX_rd_data2_o;
wire [`datawidth-1:0] IDEX_imm_data_o;
wire [4:0] IDEX_rs1_o;
wire [4:0] IDEX_rs2_o;
wire [4:0] IDEX_rd_o;
wire [4:0] IDEX_Funct_o;
wire LoadUseHazard_o;
wire [3:0] IDEX_ALU_cmd_o;
wire IDEX_IsMul_o;


//EX-MEM stage
wire [2:0] EXMEM_funct3;
wire EXMEM_Branch_o;
wire EXMEM_MemRead_o;
wire EXMEM_MemtoReg_o;
wire EXMEM_MemWrite_o;
wire EXMEM_RegWrite_o;
wire [`datawidth-1:0] EXMEM_PC_imm_o;
wire [4:0] EXMEM_rd_o;
wire [`datawidth-1:0] EXMEM_ALU_result_o;
wire [`datawidth-1:0] EXMEM_wr_MemData_o;
wire EXMEM_PC_branch_o;
wire [2:0] EXMEM_funct3_o;

//MEM-WB stage
wire MEMWB_MemtoReg_o;
wire MEMWB_RegWrite_o;
wire [4:0] MEMWB_rd_o;
wire [`datawidth-1:0] MEMWB_rd_MemData_o;
wire [`datawidth-1:0] MEMWB_ALU_result_o;


//Hazard Forwarding unit 
wire [1:0] ForwardA;
wire [1:0] ForwardB;


