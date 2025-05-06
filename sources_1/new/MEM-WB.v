`timescale 1ns / 1ps


module MEMWB(
input clk,
input rst,
input stall,
//control bypass
input MemtoReg,
input RegWrite,
//input register and data bypass
input [4:0] rd,
input [`datawidth-1:0] rd_MemData,
input [`datawidth-1:0] ALU_result,
//output register and data bypass
output reg MemtoReg_o,
output reg RegWrite_o,
output reg [4:0] rd_o,
output reg [`datawidth-1:0] rd_MemData_o,
output reg [`datawidth-1:0] ALU_result_o
);
    
    
always @(posedge clk) begin
    if(rst) begin
            MemtoReg_o <= 0;
            RegWrite_o <= 0;
            rd_o <= 0;
            rd_MemData_o <= 0;
            ALU_result_o <= 0;
    end
    else begin 
        if(stall) begin
            MemtoReg_o <= MemtoReg_o;
            RegWrite_o <= RegWrite_o;
            rd_o <= rd_o;
            rd_MemData_o <= rd_MemData_o;
            ALU_result_o <= ALU_result_o;
        end
        else begin 
            MemtoReg_o <= MemtoReg;
            RegWrite_o <= RegWrite;
            rd_o <= rd;
            rd_MemData_o <= rd_MemData;
            ALU_result_o <= ALU_result;
        end
    end
end
          
    
    
endmodule
