`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 12:51:26
// Design Name: 
// Module Name: Display
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


module Display(
    input [1:0] SW_in,
    input rst,
    input [7:0] PC, [7:0] nextPC,
    input [7:0] ADROut, [7:0] BDROut,
    input [7:0] DBDROut, [7:0] ALUoutDROut,
    input [7:0] result, [7:0] DB,
    output reg [7:0] out1, reg [7:0] out2
    );
    
    always @(SW_in) begin
        if (rst == 0) begin
            out1 <= 8'b11111111;
            out2 <= 8'b11111111;
        end
        else begin
            case(SW_in)
                2'b00: {out1, out2} = {PC, nextPC};
                2'b01: {out1, out2} = {ADROut, BDROut};
                2'b10: {out1, out2} = {DBDROut, ALUoutDROut};
                2'b11: {out1, out2} <= {result, DB};
                default: {out1, out2} = 16'b0000000000000000;
            endcase
        end
    end
endmodule
