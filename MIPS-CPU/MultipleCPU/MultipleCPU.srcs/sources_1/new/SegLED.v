`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 13:00:58
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
    input rst,
    input [3:0] display_data,
    output reg [7:0] dispcode
    );
    
    always @(display_data) begin
        if (rst == 0)
            dispcode = 8'b11111111;
        else begin
            case (display_data)
                4'b0000:dispcode = 8'b11000000;
                4'b0001:dispcode = 8'b11111001;
                4'b0010:dispcode = 8'b10100100;
                4'b0011:dispcode = 8'b10110000;
                4'b0100:dispcode = 8'b10011001;
                4'b0101:dispcode = 8'b10010010;
                4'b0110:dispcode = 8'b10000010;
                4'b0111:dispcode = 8'b11011000;
                4'b1000:dispcode = 8'b10000000;
                4'b1001:dispcode = 8'b10010000; 
                4'b1010:dispcode = 8'b10001000;
                4'b1011:dispcode = 8'b10000011;
                4'b1100:dispcode = 8'b11000110;
                4'b1101:dispcode = 8'b10100001;
                4'b1110:dispcode = 8'b10000110;
                4'b1111:dispcode = 8'b10001110;
                default:dispcode = 8'b00000000;
            endcase                                                
         end
    end
endmodule                