`timescale 1ns / 1ps


module stall(
input LoadUseHazard,
output PC_stall,
output IFID_stall,
output IDEX_stall,
output EXMEM_bubble,
output EXMEM_stall,
output MEMWB_stall
    );
   
assign PC_stall = LoadUseHazard? 1'b1:1'b0;   
assign IFID_stall = LoadUseHazard? 1'b1:1'b0;
assign EXMEM_stall = 1'b0;
assign MEMWB_stall = 1'b0;
assign IDEX_stall = LoadUseHazard? 1'b1:1'b0;
assign EXMEM_bubble = LoadUseHazard? 1'b1:1'b0;


endmodule
