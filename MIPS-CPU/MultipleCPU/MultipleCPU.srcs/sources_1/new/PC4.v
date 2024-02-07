`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:11:58
// Design Name: 
// Module Name: PC4
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


module PC4(
    input [25:0] addr,
    input [31:0] PC,
    output reg [31:0] nextPC
    );
    
    always @(addr) begin
        nextPC[31:28] <= PC[31:28];
        nextPC[27:2] <= addr[25:0];
        nextPC[1:0] <= 2'b00;
    end 
endmodule
