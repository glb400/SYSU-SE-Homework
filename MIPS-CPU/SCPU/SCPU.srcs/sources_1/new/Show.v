`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 19:18:57
// Design Name: 
// Module Name: Show
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


module Show(
    input reset,
    input clk,
    input [7:0] in1, [7:0] in2,
    output reg [3:0] place,
    output [7:0] dispcode
    );
    reg [3:0] display_data;
    initial 
        place = 4'b1110;
    
    always @(posedge clk)begin
        case(place)
        4'b1110:
            begin
                place = 4'b1101;
                display_data = in2[7:4];
            end
        4'b1101:
            begin
                place = 4'b1011;
                display_data = in1[3:0];
            end
        4'b1011:
            begin
                place = 4'b0111;
                display_data = in1[7:4];
            end
        4'b0111:
            begin
                place = 4'b1110;
                display_data = in2[3:0];
            end
        default:
            begin
                place = 4'b1110;
                display_data = 4'b1111;
            end
        endcase    
    end
    
    SegLED segled(
    .reset(reset),
    .display_data(display_data),
    .dispcode(dispcode)
);
endmodule
