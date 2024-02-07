`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 21:12:56
// Design Name: 
// Module Name: DBDRSelector
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


module DBDRSelector(
    input DBDataSrc,
    input [31:0] result,
    input [31:0] DataOut,
    output [31:0] DB
    );
    
    assign DB = (DBDataSrc ? DataOut : result);
endmodule
