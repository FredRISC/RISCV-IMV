`timescale 1ns / 1ps

`include "riscv_ctrl_para.v"
module program_counter(
input clk,
input rst,
input PC_stall,
input [`datawidth-1:0] pc_imm,
input Branch,
output reg [`datawidth-1:0] pc=0
    );
    
    
always @(posedge clk) begin
    if(rst) begin
        pc <= -4;
    end
    else if(!PC_stall) begin
        if(Branch) begin
            pc <= pc + pc_imm;
        end
        else begin
            pc <= pc + 'd4;
        end
    end
    else begin
        pc <= pc;
    end
end
    
    
endmodule
