`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:11:43
// Design Name: 
// Module Name: PC
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


module PC(
    input PCWre,
    input clk,
    input reset,
    input[31:0] nextPC,
    output reg [31:0] curPC
    );
    
    always@(posedge clk or negedge reset)begin
        if (!reset)
            curPC <= 0;
        else if (PCWre)
            curPC <= nextPC;
        end
endmodule
