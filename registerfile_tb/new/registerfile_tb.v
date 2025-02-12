`timescale 1ns / 1ps


module registerfile_tb(

    );
    
    
reg clk;
reg rst;
reg [63:0] wdata;
wire [63:0] rdata1;
wire [63:0] rdata2;
reg RegWrite;
reg [4:0] rs1, rs2, rd;

    
Registerfile Registerfile_inst(.clk(clk), .rst(rst), .wdata(wdata), .rs1(rs1), .rs2(rs2), .rd(rd), .RegWrite(RegWrite), .rdata1(rdata1), .rdata2(rdata2));


initial begin
//initialization
    clk = 1'b0;
    /*
    rst = 1'b0;
    wdata = 0;
    RegWrite = 0;
    rs1 = 0;
    rs2 = 0;
    rd = 0;
 //start write to register 1; 
    #2
    rd = 1;
    RegWrite = 1;
    wdata = 2;
 //read registers 1 & 0
    #4
    RegWrite = 0;
    rs1=rd;
    rs2=0;
 //write register 2
    #4
    rd=rd+1;
    RegWrite = 1;
    wdata=4;

 //read registers 2 and 1
    #4
    RegWrite = 0;
    rs1=rs1+1;
    rs2=rs2+1;
    
 //reset
    #6 
    rst=1;
    
    #10
    $finish;
    */
end


always #2 begin
    clk = ~clk;
end

initial begin
    rst = 1'b0;
    wdata = 0;
    RegWrite = 0;
    rs1 = 0;
    rs2 = 0;
    rd = 0;
    repeat (30) begin
        @(posedge clk) begin
            rd = rd+1;
            RegWrite = 1;
            wdata = wdata+1;      
        end
        #4
        @(posedge clk) begin
            rs1=rd;
            rs2=rd-1;
            RegWrite = 0;     
        end
    end
    
    //reset
    #6 
    rst=1;
    $finish;
end


    
endmodule
