`timescale 1ns / 1ps

`include "riscv_ctrl_para.v"
module ALU(
input [`datawidth-1:0] a,
input [`datawidth-1:0] b,
input [3:0] ALU_cmd,
input IsMul,

output reg [`datawidth-1:0] ALU_result,
output reg PC_branch
    );
    
 //basic operation
 wire [`datawidth-1:0] a_xor_b =  a ^ b;
 wire [`datawidth-1:0] slt = ($signed(a)<$signed(b))? 'd1:'d0;
 wire [`datawidth-1:0] sltu = (a<b)? 'd1:'d0;
 
 //M-extension
 wire [`datawidth*2-1:0] mul = a * b;
 wire [`datawidth*2-1:0] mulh = $signed(a) * $signed(b);
 wire [`datawidth*2-1:0] mulsu = $signed(a) * b;
 wire [`datawidth*2-1:0] mulu = $unsigned(a) * $unsigned(b);
   
 //currently not support div
 
    
//ALU_result
always @(*) begin
    if(IsMul == 'd0) begin
        case(ALU_cmd) 
            `ALU_OPERATION_ADD: ALU_result = $signed(a) + $signed(b);
            `ALU_OPERATION_SUB: ALU_result = $signed(a) - $signed(b);
            `ALU_OPERATION_XOR: ALU_result = a_xor_b;
            `ALU_OPERATION_OR: ALU_result = a | b;
            `ALU_OPERATION_AND: ALU_result = a & b;
            `ALU_OPERATION_SLL: ALU_result = a << b[4:0];
            `ALU_OPERATION_SRL: ALU_result = a >> b[4:0];
            `ALU_OPERATION_SRA: ALU_result = $signed(a) >>> b[4:0];
            `ALU_OPERATION_SLT: ALU_result = slt;
            `ALU_OPERATION_SLTU: ALU_result = sltu;
            default: ALU_result = {`datawidth{1'bx}};
        endcase
    end
    else begin //currently not support div
        case(ALU_cmd[2:0])
            `ALU_OPERATION_MUL: ALU_result = mul[`datawidth-1:0];
            `ALU_OPERATION_MULH: ALU_result = mulh[`datawidth*2-1:32];
            `ALU_OPERATION_MULSU: ALU_result = mulsu[`datawidth*2-1:32];
            `ALU_OPERATION_MULU: ALU_result = mulu[`datawidth*2-1:32];
            default: ALU_result = {`datawidth{1'bx}};
        endcase
    end
end    

//PC_branch
always @(*) begin
    case(ALU_cmd)
        `ALU_OPERATION_BEQ: PC_branch = (a_xor_b == 'd0)? 'd1:'d0;
        `ALU_OPERATION_BNE: PC_branch = (a_xor_b == 'd0)? 'd0:'d1;
        `ALU_OPERATION_BLT: PC_branch = slt[0];
        `ALU_OPERATION_BGE: PC_branch = ~slt[0];
        `ALU_OPERATION_BLTU: PC_branch = sltu[0];
        `ALU_OPERATION_BGEU: PC_branch = ~sltu[0];
        default: PC_branch = 1'b0;
    endcase
end


    
endmodule


