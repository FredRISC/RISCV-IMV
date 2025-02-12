`timescale 1ns / 1ps


`include "riscv_ctrl_para.v"

module DataMem(
input clk,
input MemWrite,
input MemRead,
input [2:0] funct3, //0:lb, 1:lh, 2:,lw, 3:lbu, 4:lhu, 5:sb, 6:sh, 7:sw

input [`DataMemorySize-3:0] dataAddr,
input [`datawidth-1:0] dataIn,
output reg [`datawidth-1:0] dataOut
    );
    
reg [7:0] MEMORY [`DataMemorySize-1:0]; //8-bit data  

always @(posedge clk) begin
    casez({MemWrite, MemRead})
        2'b01: begin
                case(funct3)
                    'd0: dataOut <= {{24{MEMORY[dataAddr][7]}},MEMORY[dataAddr]}; 
                    'd1: dataOut <= {{16{MEMORY[dataAddr+1][7]}}, MEMORY[dataAddr+1], MEMORY[dataAddr]}; 
                    'd2: dataOut <= {MEMORY[dataAddr+3], MEMORY[dataAddr+2], MEMORY[dataAddr+1], MEMORY[dataAddr]}; 
                    'd4: dataOut <= {{24{1'b0}}, MEMORY[dataAddr]}; 
                    'd5: dataOut <= {{16{1'b0}}, MEMORY[dataAddr+1], MEMORY[dataAddr]}; 
                    default: dataOut <= {`DataMemorySize{1'bx}};
                endcase
            end
        2'b10: begin
                    case(funct3)
                    'd0: MEMORY[dataAddr] <= dataIn[7:0]; 
                    'd1: {MEMORY[dataAddr+1],MEMORY[dataAddr]} <= dataIn[15:0]; 
                    'd2: {MEMORY[dataAddr+3],MEMORY[dataAddr+2],MEMORY[dataAddr+1],MEMORY[dataAddr]} <= dataIn[31:0]; 
                    default: {MEMORY[dataAddr+3],MEMORY[dataAddr+2],MEMORY[dataAddr+1],MEMORY[dataAddr]} <= {`DataMemorySize{1'bx}};
                endcase
            end
        
        default: begin
                dataOut <= {64{1'bx}};
                {MEMORY[dataAddr+3],MEMORY[dataAddr+2],MEMORY[dataAddr+1],MEMORY[dataAddr]} <= {MEMORY[dataAddr+3],MEMORY[dataAddr+2],MEMORY[dataAddr+1],MEMORY[dataAddr]};
            end
    endcase
end


endmodule
