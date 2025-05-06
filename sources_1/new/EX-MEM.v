`timescale 1ns / 1ps


module EXMEM(
input clk,
input rst,
input stall,
input bubble,
//control bypass
input Branch,
input MemRead,
input MemtoReg,
input MemWrite,
input RegWrite,
//input register and data bypass
input [`datawidth-1:0] PC_imm,
input [4:0] rd,
input [`datawidth-1:0] ALU_result,
input [`datawidth-1:0] wr_MemData,

//ALU branch decision
input PC_branch,
input [2:0] funct3,
//output register and data bypass
output reg Branch_o,
output reg MemRead_o,
output reg MemtoReg_o,
output reg MemWrite_o,
output reg RegWrite_o,
output reg [`datawidth-1:0] PC_imm_o,
output reg [4:0] rd_o,
output reg [`datawidth-1:0] ALU_result_o,
output reg [`datawidth-1:0] wr_MemData_o,
output reg PC_branch_o,
output reg [2:0] funct3_o
    );
    
    
always @(posedge clk) begin
    if(rst || bubble) begin
            Branch_o <= 0;
            MemRead_o <= 0;
            MemtoReg_o <= 0;
            MemWrite_o <= 0;
            RegWrite_o <= 0;
            PC_imm_o <= 0;
            rd_o <= 0;
            wr_MemData_o <= 0;
            PC_branch_o <= 0;
            funct3_o <= 0;
    end
    else begin 
        if(stall) begin
            Branch_o <= Branch_o;
            MemRead_o <= MemRead_o;
            MemtoReg_o <= MemtoReg_o;
            MemWrite_o <= MemWrite_o;
            RegWrite_o <= RegWrite_o;
            PC_imm_o <= PC_imm_o;
            rd_o <= rd_o;
            wr_MemData_o <= wr_MemData_o;
            PC_branch_o <= PC_branch_o;
            funct3_o <= funct3_o;            
        end
        else begin 
            Branch_o <= Branch;
            MemRead_o <= MemRead;
            MemtoReg_o <= MemtoReg;
            MemWrite_o <= MemWrite;
            RegWrite_o <= RegWrite;
            PC_imm_o <= PC_imm;
            rd_o <= rd;
            wr_MemData_o <= wr_MemData;
            PC_branch_o <= PC_branch;
            funct3_o <= funct3;            
            
        end
    end
end
          
    
    
endmodule
