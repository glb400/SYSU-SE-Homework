`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:01:56
// Design Name: 
// Module Name: DataMEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataMEM(
    input mRD,
    input mWR,
    input [31:0] DAddr,
    input [31:0] DataIn,
    output reg [31:0] DataOut
    );
    
    reg [7:0] DataMem [0:63];
    
    integer i;
    initial begin
        DataOut <= 0;
        for(i = 0;i < 64;i = i + 1)
            DataMem[i] <= 0;
    end
    
    always @(mRD or mWR) begin
        if(mWR) begin
            DataMem[DAddr] <= DataIn[31:24];
            DataMem[DAddr + 1] <= DataIn[23:16];
            DataMem[DAddr + 2] <= DataIn[15:8];
            DataMem[DAddr + 3] <= DataIn[7:0];
        end 
        
        if(mRD) begin
            DataOut[31:24] <= DataMem[DAddr];
            DataOut[23:16] <= DataMem[DAddr + 1];
            DataOut[15:8] <= DataMem[DAddr + 2];
            DataOut[7:0] <= DataMem[DAddr + 3];
        end
    end    
endmodule
