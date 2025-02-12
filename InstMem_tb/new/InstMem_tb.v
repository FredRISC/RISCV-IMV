`timescale 1ns / 1ps

//`include "riscv_ctrl_para.v"

module InstMem_tb(

    );
    
reg [31:0] InstAddress;
wire [31:0] Inst;
reg clk;
    
InstMem InstMem_inst(InstAddress,Inst);     

initial begin
    InstAddress = 0;
    clk = 0;
    repeat(15) begin
        @(posedge clk) begin
            InstAddress = InstAddress + 1;
        end
    end
end

always #2 begin
    clk = ~clk;
end

    
endmodule
