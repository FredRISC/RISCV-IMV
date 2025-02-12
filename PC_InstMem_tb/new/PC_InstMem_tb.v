`timescale 1ns / 1ps


module PC_InstMem_tb(

    );
    
reg clk;
reg rst;
reg [31:0] pc_imm;
reg Branch;

wire [31:0] Inst;
wire [31:0] pc;
    
    
InstMem InstMem_inst(pc,Inst);     
program_counter pc_inst(clk,rst,pc_imm,Branch,pc);
    
 
always #2 begin
    clk = ~clk;
end

    
initial begin
    clk = 0;
    rst = 1;
    Branch = 0; //when Branch=0 the pc will run regular task (+4 each cycle); whem Branch=1 the pc will add immediate to its current value.
    pc_imm = 8;
    
    #2
    rst = 0;
    Branch = 1;
    #4
    Branch = 0;
    pc_imm = -8;
    #4
    Branch = 1;
    #4
    $finish;     
end

    
    
endmodule


