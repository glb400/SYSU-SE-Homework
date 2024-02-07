`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 21:09:27
// Design Name: 
// Module Name: DBDR
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


module DBDR(
    input clk,
    input [31:0] DBDRIn,
    output reg [31:0] DBDROut
    );
    
    always @(posedge clk) begin
//    always @(negedge clk) begin   
        DBDROut = DBDRIn;
    end
endmodule
