`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:59:30
// Design Name: 
// Module Name: WriteRegSelector
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


module WriteRegSelector(
    input [1:0] RegDst,
    input [4:0] rt,
    input [4:0] rd,
    output reg [4:0] WriteReg
    );
    
    always @(RegDst or rt or rd) begin
        case(RegDst)
            2'b00: WriteReg = 5'b11111;
            2'b01: WriteReg = rt;
            2'b10: WriteReg = rd;
            default: WriteReg = 0;
        endcase
    end
endmodule
