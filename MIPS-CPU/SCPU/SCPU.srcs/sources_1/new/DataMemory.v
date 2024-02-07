`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:07:54
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,
    input [31:0] result,
    input [31:0] readData2,
    input _WR,
    input _RD,
    input DBdataSrc,
    output [31:0] write_data
    );

	reg [7:0] DataMem [0:60];
	//reg [31:0] DataOut;
	wire [31:0] DataOut;
	
	initial begin
	   DataMem[8]  = 8'b00000000;
	   DataMem[9]  = 8'b00000000;
	   DataMem[10] = 8'b00000000;
	   DataMem[11] = 8'b00000101;
	end
	
//	always @( _RD or result) begin
//	    if(!_RD) begin
//            DataOut[7:0]   = DataMem[result + 3];
//            DataOut[15:8]  = DataMem[result + 2];
//            DataOut[23:16] = DataMem[result + 1];
//            DataOut[31:24] = DataMem[result];
//        end
//    end
      assign  DataOut[7:0]   = (_RD == 1) ? DataMem[result + 3] : 8'bz;
      assign  DataOut[15:8]  = (_RD == 1) ? DataMem[result + 2] : 8'bz;
      assign  DataOut[23:16] = (_RD == 1) ? DataMem[result + 1] : 8'bz;
      assign  DataOut[31:24] = (_RD == 1) ? DataMem[result] : 8'bz;
	
	always @(negedge clk) begin
		if(_WR == 1) begin	
            DataMem[result]   <= readData2[31:24]; 
            DataMem[result+1] <= readData2[23:16];
            DataMem[result+2] <= readData2[15:8];
            DataMem[result+3] <= readData2[7:0];
        end
	end
   
    assign write_data = ( DBdataSrc == 0 )? result : DataOut;

endmodule
