`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 17:50:08
// Design Name: 
// Module Name: SegLED
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


module SegLED(
    input reset,
    input [3:0] display_data,
    output reg [7:0] dispcode
    );
    always @(display_data) begin
        if(0 == reset)
            dispcode = 8'b11111111;
        else begin
        case(display_data)
            4'b0000:dispcode = 8'b1100_0000;
            4'b0001:dispcode = 8'b1111_1001;
            4'b0010:dispcode = 8'b1010_0100;
            4'b0011:dispcode = 8'b1011_0000;
            4'b0100:dispcode = 8'b1001_1001;
            4'b0101:dispcode = 8'b1001_0010;
            4'b0110:dispcode = 8'b1000_0010;
            4'b0111:dispcode = 8'b1101_1000;
            4'b1000:dispcode = 8'b1000_0000;
            4'b1001:dispcode = 8'b1001_0000; 
            4'b1010:dispcode = 8'b1000_1000;
            4'b1011:dispcode = 8'b1000_0011;
            4'b1100:dispcode = 8'b1100_0110;
            4'b1101:dispcode = 8'b1010_0001;
            4'b1110:dispcode = 8'b1000_0110;
            4'b1111:dispcode = 8'b1000_1110;
            default:dispcode = 8'b0000_0000;
         endcase                                                
         end
    end
endmodule
