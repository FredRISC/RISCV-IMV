`timescale 1ns / 1ps



module R_inst_parser(
input [24:0] inst,
output [4:0] rd,
output [2:0] funct3,
output [4:0] rs1,
output [4:0] rs2,
output [6:0] funct7 
);
 
assign funct3 = inst[7:5];
assign funct7 = inst[24:18];
assign rs1 = inst[12:8];
assign rs2 = inst[17:13];
assign rd = inst[4:0];

endmodule
