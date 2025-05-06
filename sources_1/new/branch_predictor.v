`timescale 1ns / 1ps

//2-bit saturate counter predictor
module branch_predictor(
input PredictFailed, branch_ins,
output Predict
    );
    
reg [1:0] SatCounter = 2'b10;   //{00:N, 01:n, 10:t, 11:T}
assign Predict = SatCounter[1];

always @(*) begin
    if(branch_ins) begin
        if(!PredictFailed && SatCounter != 'd3) begin
            SatCounter = SatCounter + 'd1;
        end
        else if(PredictFailed && SatCounter != 'd0) begin
            SatCounter = SatCounter - 'd1;
        end
        else begin
            SatCounter = SatCounter;
        end
    end
    else begin
        SatCounter = SatCounter;
    end
end


endmodule
