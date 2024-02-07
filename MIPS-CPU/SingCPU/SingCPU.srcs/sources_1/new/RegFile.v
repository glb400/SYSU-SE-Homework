`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:12:50
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input clk,
    input WE, 
	input [4:0] Read_reg1, 
	input [4:0] Read_reg2, 
	input [4:0] write_reg, 
	input [31:0] write_data, 
	output [31:0] Read_data1,
	output [31:0] Read_data2
	);

    reg [31:0] regFile[1:31]; 

    assign Read_data1 = (Read_reg1 == 5'b0) ? 0 : regFile[Read_reg1];
    assign Read_data2 = (Read_reg2 == 5'b0) ? 0 : regFile[Read_reg2];

    always @(negedge clk) begin //ÏÂ½µÑØ´¥·¢
	   if (WE==1 && write_reg != 0) begin
		      regFile[write_reg] <= write_data;
	       end
    end
endmodule
