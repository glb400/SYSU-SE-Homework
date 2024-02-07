`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 21:08:30
// Design Name: 
// Module Name: ALUoutDR
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


module ALUoutDR(
    input clk,
    input [31:0] AlUoutDRIn,
    output reg [31:0] AlUoutDROut
    );
    
    always @(posedge clk) begin
//    always @(negedge clk) begin
        AlUoutDROut = AlUoutDRIn;
    end
endmodule
