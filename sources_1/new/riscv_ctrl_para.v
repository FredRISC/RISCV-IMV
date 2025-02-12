`timescale 1ns / 1ps

`define datawidth 32
`define InstMemorySize 2**20
`define InstAddrWidth 20
`define DataMemorySize 2**30

`define ALU_OPERATION_ADD 4'b0000
`define ALU_OPERATION_SUB 4'b0001
`define ALU_OPERATION_XOR 4'b0010
`define ALU_OPERATION_OR 4'b0011
`define ALU_OPERATION_AND 4'b0100
`define ALU_OPERATION_SLL 4'b0101
`define ALU_OPERATION_SRL 4'b0110
`define ALU_OPERATION_SRA 4'b0111
`define ALU_OPERATION_SLT 4'b1000
`define ALU_OPERATION_SLTU 4'b1001

`define ALU_OPERATION_BEQ 4'b1010
`define ALU_OPERATION_BNE 4'b1011
`define ALU_OPERATION_BLT 4'b1100
`define ALU_OPERATION_BGE 4'b1101
`define ALU_OPERATION_BLTU 4'b1110
`define ALU_OPERATION_BGEU 4'b1111

//M-extension
`define ALU_OPERATION_MUL 4'h0
`define ALU_OPERATION_MULH 4'h1
`define ALU_OPERATION_MULSU 4'h2
`define ALU_OPERATION_MULU 4'h3
`define ALU_OPERATION_DIV 4'h4
`define ALU_OPERATION_DIVU 4'h5
`define ALU_OPERATION_REM 4'h6
`define ALU_OPERATION_REMU 4'h7

`define ALU_OPERATION_DEFAULT 4'bxxxx


`define R_type = 7'b0110011;
`define I_type = 7'b0010011;
`define S_type = 7'b0100011;
`define B_type = 7'b1100011;
`define J_op = 7'b1101111;
`define U_LoadUpperImm_op = 7'b0110111;
`define U_AddUpperImmPC_op = 7'b0010111;
`define I_JumpLinkReg_op = 7'b1100111;
`define I_Environment_op = 7'b1110011;

