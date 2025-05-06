`timescale 1ns / 1ps


module IDEX(
input clk,
input rst,
input stall,
input [`datawidth-1:0] PC,
//control bypass
input Branch,
input MemRead,
input MemtoReg,
input [1:0] ALUOp,
input MemWrite,
input ALUSrc,
input RegWrite,
//input register and data bypass
input [`datawidth-1:0] rd_data1,
input [`datawidth-1:0] rd_data2,
input [`datawidth-1:0] imm_data,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input [4:0] Funct,
//Harzard flag bypass 
input LoadUseHazard,

//output register and data bypass
output reg [`datawidth-1:0] PC_o,
output reg Branch_o,
output reg MemRead_o,
output reg MemtoReg_o,
output reg [1:0] ALUOp_o,
output reg MemWrite_o,
output reg ALUSrc_o,
output reg RegWrite_o,
output reg [`datawidth-1:0] rd_data1_o,
output reg [`datawidth-1:0] rd_data2_o,
output reg [`datawidth-1:0] imm_data_o,
output reg [4:0] rs1_o,
output reg [4:0] rs2_o,
output reg [4:0] rd_o,
output reg [4:0] Funct_o,
output reg LoadUseHazard_o
    );

    
always @(posedge clk) begin
    if(rst) begin
            PC_o <= 0;    
            Branch_o <= 0;
            MemRead_o <= 0;
            MemtoReg_o <= 0;
            ALUOp_o <= 0;
            MemWrite_o <= 0;
            ALUSrc_o <= 0;
            RegWrite_o <= 0;
            rd_data1_o <= 0;
            rd_data2_o <= 0;
            imm_data_o <= 0;
            rs1_o <= 0;
            rs2_o <= 0;
            rd_o <= 0;
            Funct_o <= 0; 
            LoadUseHazard_o <= 0;
    end
    else begin 
        if(stall) begin
            PC_o <= PC_o; 
            Branch_o <= Branch_o;
            MemRead_o <= MemRead_o;
            MemtoReg_o <= MemtoReg_o;
            ALUOp_o <= ALUOp_o;
            MemWrite_o <= MemWrite_o;
            ALUSrc_o <= ALUSrc_o;
            RegWrite_o <= RegWrite_o;
            rd_data1_o <= rd_data1_o;
            rd_data2_o <= rd_data2_o;
            imm_data_o <= imm_data_o;
            rs1_o <= rs1_o;
            rs2_o <= rs2_o;
            rd_o <= rd_o;
            Funct_o <= Funct_o;
            LoadUseHazard_o <= LoadUseHazard_o;
        end
        else begin 
            PC_o <= PC;  
            Branch_o <= Branch;
            MemRead_o <= MemRead;
            MemtoReg_o <= MemtoReg;
            ALUOp_o <= ALUOp;
            MemWrite_o <= MemWrite;
            ALUSrc_o <= ALUSrc;
            RegWrite_o <= RegWrite;
            rd_data1_o <= rd_data1;
            rd_data2_o <= rd_data2;
            imm_data_o <= imm_data;
            rs1_o <= rs1;
            rs2_o <= rs2;
            rd_o <= rd;
            Funct_o <= Funct;
            LoadUseHazard_o <= LoadUseHazard;
        end
    end
end
          
    
    
endmodule
