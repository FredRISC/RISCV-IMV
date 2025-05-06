`timescale 1ns / 1ps


`include "riscv_ctrl_para.v"
module Mux3(
input [1:0] sel,
input [`datawidth-1:0] a,
input [`datawidth-1:0] b,
input [`datawidth-1:0] c,
output reg [`datawidth-1:0] mux_out
);
    
always @(sel) begin
    casez(sel)
        2'b00: mux_out = a;
        2'b01: mux_out = b;
        2'b10: mux_out = c;
        default: mux_out = 2'bzz;
    endcase
end
    
endmodule
