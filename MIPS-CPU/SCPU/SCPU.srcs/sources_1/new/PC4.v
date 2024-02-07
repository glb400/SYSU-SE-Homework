`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:12:14
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
   input [31:0] PC,
   input [31:0] ExtOut,
   input  [1:0] PCSrc,
   input [25:0] address,
   output reg[31:0] next
   );
   wire [31:0] PCAddedFour;
   assign PCAddedFour = PC + 4;

   always @(*) begin
	   case(PCSrc)
	       2'b00:   next <= PCAddedFour;	
	       2'b01:   next <= PC + 4 + ExtOut * 4;	
	       2'b10:   next <= {PCAddedFour[31:28], address, 1'b0, 1'b0};
	       2'b11:   next <= 32'b0;	
	       default:   next <= 32'b0;
	  endcase
    end
endmodule
