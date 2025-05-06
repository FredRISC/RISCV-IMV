`timescale 1ns / 1ps


module Top_tb(

    );
    reg clk;
    reg rst;
    
    
    initial begin
        clk=0;
        rst=1;
        #10 rst=0;
    end
    
    Top Top_inst(clk,rst);
        
    always #2 begin
        clk = ~clk;
    end

    

    
endmodule
