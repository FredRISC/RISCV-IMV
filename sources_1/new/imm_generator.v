`timescale 1ns / 1ps

`include "riscv_ctrl_para.v"
module Imm_gen(
input [31:0] inst,
output reg signed [`datawidth-1:0] imm_out
);

wire [1:0] sel65;
wire [3:2] sel32;

assign sel65 = inst[6:5]; // I,S,B types
assign sel32 = inst[3:2]; // for J,U types

always @(inst) begin
    casez(sel65)
        2'b00: begin
                if(sel32[0] == 1'b0) begin
                    imm_out = {{20{inst[31]}},inst[31:20]}; //load instruction - I type
                end
                else begin
                    imm_out = {{12{inst[31]}},inst[31:12]}; //auipc - U type
                end
            end
        2'b01: begin
                if(sel32[0] == 1'b0) begin
                    imm_out = {{20{inst[31]}},inst[31:25],inst[11:7]}; //store instruction - S type
                end
                else begin
                    imm_out = {{12{inst[31]}},inst[31:12]}; // lui - U type
                end
            end
        2'b11: begin
            case(sel32)
                2'b00: imm_out = {{20{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8]}; //conditional branch instruction - B type
                2'b11: imm_out = {{12{inst[31]}},inst[33],inst[21:12],inst[22],inst[30:23]}; //jal - J type
                2'b01: imm_out = {{20{inst[31]}},inst[31:20]}; //jalr - I type
                default: imm_out = imm_out;
            endcase
        end
        
        default: imm_out = {64{1'bx}}; 
    endcase
end

endmodule
