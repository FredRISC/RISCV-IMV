`timescale 1ns / 1ps



module Forwarding(
input IDEX_rs1, IDEX_rs2, 
input EXMEM_rd, 
input MEMWB_rd,
input EXMEM_RegWrite,
input MEMWB_RegWrite,
output reg [1:0] ForwardA,
output reg[1:0] ForwardB
    );

wire forwardA_flag = EXMEM_RegWrite && (EXMEM_rd != 0) && EXMEM_rd == IDEX_rs1;
wire forwardB_flag = EXMEM_RegWrite && (EXMEM_rd != 0) && EXMEM_rd == IDEX_rs2;

always @(*) begin
    if(forwardA_flag) begin //EXMEM->IDEX stage has priority
        ForwardA = 2'b10;
    end 
    else if(MEMWB_RegWrite && (MEMWB_rd != 0) && MEMWB_rd == IDEX_rs1) begin
        ForwardA = 2'b01;
    end
    else begin
        ForwardA = 2'b00;
    end
end

always @(*) begin
    if(forwardB_flag) begin
        ForwardB = 2'b10;
    end 
    else if(MEMWB_RegWrite && (MEMWB_rd != 0) && MEMWB_rd == IDEX_rs2) begin
        ForwardB = 2'b01;
    end
    else begin
        ForwardB = 2'b00;
    end
end

    
endmodule
