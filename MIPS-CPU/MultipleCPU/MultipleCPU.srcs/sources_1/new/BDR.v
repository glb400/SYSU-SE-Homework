`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 21:07:42
// Design Name: 
// Module Name: BDR
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


module BDR(
    input clk,
    input [31:0] BDRIn,
    output reg [31:0] BDROut
    );
    
    always @(posedge clk) begin
//    always @(negedge clk) begin
        BDROut = BDRIn;
    end
endmodule
