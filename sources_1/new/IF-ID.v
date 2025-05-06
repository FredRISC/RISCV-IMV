`timescale 1ns / 1ps


module IFID(
input clk,
input rst,
input stall,
input [`datawidth-1:0] inst,
input [`datawidth-1:0] pc,
output reg [`datawidth-1:0] inst_o,
output reg [`datawidth-1:0] pc_o
    );
    
    
always @(posedge clk) begin
    if(rst) begin
        pc_o <= 'd0;
        inst_o <= 'd0;        
    end
    else begin 
        if(stall) begin
            pc_o <= pc_o;
            inst_o <= inst_o; 
        end
        else begin 
            pc_o <= pc;
            inst_o <= inst; 
        end
    end
end
        
endmodule
