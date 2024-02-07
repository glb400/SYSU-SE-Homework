`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 19:46:26
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst,
    input PCWre,
    input [1:0] PCSrc,
    input [31:0] addr,
    input [31:0] imd,
    input [31:0] ReadData1,
    output reg [31:0] PC,
    output reg [31:0] nextPC
    );
    
    initial begin
        PC = 0;
        nextPC = 4;
    end
    
    always @(negedge clk or negedge rst)begin
        if(!rst)
            PC = 0;//reset
        else if (PCWre) begin//enable nextPC
            PC = nextPC;
        end
    end
    
    always @(PCSrc or imd or addr) begin
        case(PCSrc)
            2'b00: nextPC = PC + 4;
            2'b01: nextPC = PC + 4 + (imd * 4);
            2'b10: nextPC = ReadData1;
            2'b11: nextPC = addr;
        endcase
    end
endmodule
