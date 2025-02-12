`timescale 1ns / 1ps


module ALU_tb(

    );
`include "riscv_ctrl_para.v"
    
reg clk;
reg rst;
reg [`datawidth-1:0] a;
reg [`datawidth-1:0] b;
reg [3:0] ALU_cmd;
reg IsMul;

wire [`datawidth-1:0] ALU_result;
wire PC_branch;
    
ALU ALU_inst(a,b,ALU_cmd,IsMul,ALU_result,PC_branch);

wire [`datawidth-1:0] testbench_a [0:15]; //= {2, 10, 32'hfffff000,32'hfffff000, 32'hfffffd21, 32'h000ff000, 32'h000ff000, 32'hf00ff000,    32'hf00f0000, 32'hf00f0000};
wire [`datawidth-1:0] testbench_b [0:15]; //= {2, 4, 32'hfffffa5d, 32'h00000fff, 32'hfffff0ac, 4,            4,            4,          ,    32'hf00ff000, 32'hf00ff000};  


assign testbench_a[0] = 'd2;
assign testbench_b[0] = 'd2;

assign testbench_a[1] = 'd10;
assign testbench_b[1] = 'd4;

assign testbench_a[2] = 32'hfffff000;
assign testbench_b[2] = 32'hfffffa5d;

assign testbench_a[3] = 32'hfffff000;
assign testbench_b[3] = 32'h00000fff;

assign testbench_a[4] = 32'hfffffd21;
assign testbench_b[4] = 32'hfffff0ac;

assign testbench_a[5] = 32'h000ff000;
assign testbench_b[5] = 'd4;

assign testbench_a[6] = 32'h000ff000;
assign testbench_b[6] = 'd4;

assign testbench_a[7] = 32'hf00ff000;
assign testbench_b[7] = 'd4;

assign testbench_a[8] = 32'hf00f0000;
assign testbench_b[8] = 32'hf00ff000;

assign testbench_a[9] = 32'hf00ff000;
assign testbench_b[9] = 32'hf00f0000;

assign testbench_a[10] = 32'habcdef12;
assign testbench_b[10] = 32'habcdef12;


always #2 begin
    clk = ~clk;
end

initial begin
    clk = 0;
    rst = 0;
    ALU_cmd = `ALU_OPERATION_ADD;
    IsMul = 0;
    a = 2;
    b = 2;
    repeat (10) begin
        @(posedge clk) begin
             ALU_cmd = ALU_cmd + 1;
             a = testbench_a[ALU_cmd];
             b = testbench_b[ALU_cmd];
        end
    end
    
    //reset
    #10
    rst=1;
    $finish;
end


    
endmodule
