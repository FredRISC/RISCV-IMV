`timescale 1ns / 1ps


module control_tb(

    );
    
wire [31:0] Instruction_tb [0:4];
assign Instruction_tb[0]=32'b0000000_01001_10101_000_01001_0110011; //add R-type, ALU_cmd should output 0000
assign Instruction_tb[1]=32'b000000001001_10100_001_01000_0010011; //slli I_R-type, ALU_cmd should output 0101
assign Instruction_tb[2]=32'b000000001001_10100_010_01000_0000011; //lw I type, ALU_cmd should output 0000
assign Instruction_tb[3]=32'b0000000_10100_01000_010_00001_0100011; //sw, S-type, ALU_cmd should output 0000
assign Instruction_tb[4]=32'b0000000_10100_01000_100_00001_1100011; //blt, B-type, LU_cmd should output 1100

reg [31:0] Instruction;

wire [2:0] funct3;
wire [6:0] funct7;
wire [6:0] opcode;
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign opcode = Instruction[6:0];

wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [4:0] ALU_Funct = {funct7[0],funct7[5], funct3}; //MSb is used to check if it's of M-extension
wire [3:0] ALU_cmd;
wire IsMul;

reg clk;

Control_Unit Control_Unit_inst(.opcode(opcode), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
ALU_Control ALU_Control_inst(ALUOp,ALU_Funct,ALU_cmd,IsMul);

    integer i = 0;
initial begin
    clk = 0;
    Instruction = Instruction_tb[i];
    #4
    repeat(4) begin
        @(posedge clk) begin
            i = i+1;
            Instruction = Instruction_tb[i];
        end
    end
    #4
    $finish;
end    

always #2 begin
    clk = ~clk;
end
    
endmodule


