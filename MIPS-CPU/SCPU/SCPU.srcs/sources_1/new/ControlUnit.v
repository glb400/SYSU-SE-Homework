`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:14:39
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] op,
	input zero,
	input sign,
	output reg PCWre,
	output reg ALUSrcA,
	output reg ALUSrcB,
	output reg DBDataSrc,
	output reg RegWre,
	output reg InsMemRW,
	output reg RD,
	output reg WR,
	output reg RegDst,
	output reg ExtSel,
	output reg [1:0] PCSrc,
	output reg [2:0] ALUOp
    );
    initial 
        InsMemRW = 1'b1;
    
    always @(op or zero or sign)begin
        case(op)
        6'b010010: //ori
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 0;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b011;
        end
        6'b000000: //add
        begin 
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b000;
        end
        6'b000010: //addiu
            begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 0;
                ExtSel = 1;
                PCSrc = 2'b00;
                ALUOp = 3'b000;
        end
        6'b000001: //sub
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b001;
        end
        6'b010001: //and
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b100;
        end
        6'b010011: //or
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b011;
        end
        6'b011000: //sll
        begin
                PCWre = 1;
                ALUSrcA = 1;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b010;
        end
        6'b110001: //bne
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 1;
                if(0 == zero)
                    PCSrc = 2'b01;
                else PCSrc = 2'b00;
                ALUOp = 3'b001;
        end
        6'b011100: //slti
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 0;
                ExtSel = 1;
                PCSrc = 2'b00;
                ALUOp = 3'b110;
        end
        6'b110000: //beq
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 1;
                if(1 == zero)
                   PCSrc = 2'b01;
                else PCSrc = 2'b00;
                ALUOp = 3'b001;
        end
        6'b100110: //sw
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 1;
                RD = 0;
                WR = 1;
                RegDst = 1;
                ExtSel = 1;
                PCSrc = 2'b00;
                ALUOp = 3'b000;
        end
        6'b100111: //lw
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                DBDataSrc = 1;
                RegWre = 1;
                InsMemRW = 1;
                RD = 1;
                WR = 0;
                RegDst = 0;
                ExtSel = 1;
                PCSrc = 2'b00;
                ALUOp = 3'b000;
        end
        6'b010000: //andi
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 0;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b100;
        end
        6'b111000: //j
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 0;
                PCSrc = 2'b10;
                ALUOp = 3'b000;
        end
        6'b111111: //halt
        begin
                PCWre = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 0;
                RD = 1;
                WR = 1;
                RegDst = 0;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b000;
        end
        6'b110010: //bltz
        begin
                PCWre = 1;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 1;
                RD = 0;
                WR = 0;
                RegDst = 1;
                ExtSel = 1;
                if(1 == sign)
                    PCSrc = 2'b01;
                else PCSrc = 2'b00;
                ALUOp = 3'b001;
        end
        default:
        begin
                PCWre = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                InsMemRW = 1;
                RD = 1;
                WR = 1;
                RegDst = 0;
                ExtSel = 0;
                PCSrc = 2'b00;
                ALUOp = 3'b000;
        end
        endcase
    end
endmodule
