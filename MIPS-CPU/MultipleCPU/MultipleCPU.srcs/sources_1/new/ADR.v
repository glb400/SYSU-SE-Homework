`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/13 17:08:39
// Design Name: 
// Module Name: ADR
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


module ADR(
    input clk,
    input [31:0] ADRIn,
    output reg [31:0] ADROut
    );
    
    always @(posedge clk) begin
//    always @(negedge clk) begin
        ADROut = ADRIn;
    end
endmodule
