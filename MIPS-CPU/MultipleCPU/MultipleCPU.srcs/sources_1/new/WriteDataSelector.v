`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 21:12:28
// Design Name: 
// Module Name: WriteDataSelector
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


module WriteDataSelector(
    input WrRegDSrc,
    input [31:0] nextPC,
    input [31:0] DB,
    output [31:0] WriteData
    );
    
    assign WriteData = (WrRegDSrc ? DB : nextPC);
endmodule
