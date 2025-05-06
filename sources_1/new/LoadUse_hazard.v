`timescale 1ns / 1ps



module LoadUse_hazard(
input EX_MemRead,
input [4:0] ID_rs1, 
input [4:0] ID_rs2, 
input [4:0] EX_rd,
output LoadUseHazard
    );
    
assign LoadUseHazard = EX_MemRead && (EX_rd == ID_rs1 || EX_rd == ID_rs2);
    
endmodule
