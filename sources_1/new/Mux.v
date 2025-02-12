`timescale 1ns / 1ps


`include "riscv_ctrl_para.v"
module Mux(
input sel,
input [`datawidth-1:0] a,
input [`datawidth-1:0] b,
output reg [`datawidth-1:0] mux_out
);
    
always @(sel) begin
    case(sel)
        1'b0: mux_out = a;
        default: mux_out = b;
    endcase
end
    
endmodule
