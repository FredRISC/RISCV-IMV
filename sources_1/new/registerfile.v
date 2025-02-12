`timescale 1ns / 1ps

`include "riscv_ctrl_para.v"
module Registerfile(
input clk,
input rst,

input [63:0] wdata,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input RegWrite,

output [`datawidth-1:0] rdata1,
output [`datawidth-1:0] rdata2
    );
    
    
reg [`datawidth-1:0] registers [0:31]; //32 32-bit registers


//output rdata according to the inputs //not driven by clock due to pipeline
assign rdata1 = rst? 0 :registers[rs1]; //|| (rs1=='d0)
assign rdata2 = rst? 0 :registers[rs2];

//write registers with clk
always @(posedge clk) begin
    registers[0] <= 'd0; //hardcoded 0
    if(rst) begin
        registers[rd] <= {64{1'bx}};    
    end
    else begin
        if(RegWrite && (rd != 'd0)) begin
            registers[rd] <= wdata;
        end
        else begin
            registers[rd] <= registers[rd];
        end
    end

end
    
    
endmodule
