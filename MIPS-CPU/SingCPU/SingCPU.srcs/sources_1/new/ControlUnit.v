`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 19:10:11
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
    input[5:0] op,
    input zero,
    input sign,
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
    output DBDataSrc,
    output RegWre,
    output InsMemRW,
    output RD,
    output WR,
    output RegDst,
    output ExtSel,
    output [1:0] PCSrc,
    output [2:0] ALUOp
    );
    
    // Control Signals
    assign RegDst = (op == 6'b000000 || op == 6'b000001 || op == 6'b010001 || op == 6'b010011 || op == 6'b011000 || op == 6'b110001 || op == 6'b110000 || op == 6'b100110 || op == 6'b111000 || op == 6'b110010) ? 1 : 0;
    assign PCWre = (op == 6'b111111) ? 0 : 1;
    assign ExtSel = (op == 6'b010010 || op == 6'b000000 || op == 6'b000001 || op == 6'b010001 || op == 6'b010011 || op == 6'b011000 || op == 6'b010000 || op == 6'b111000 || op == 6'b111111) ? 0 : 1;
    assign DBDataSrc = (op == 6'b100111) ? 1 : 0;
    assign WR = (op == 6'b100110 || op == 6'b111111) ? 0 : 1;
    assign RD = (op == 6'b100111 || op == 6'b111111) ? 0 : 1;
    assign ALUSrcA = (op == 6'b011000) ? 1 : 0;
    assign ALUSrcB = (op == 6'b010010 || op == 6'b000010 || op == 6'b011100 || op == 6'b100110 || op == 6'b100111 || op == 6'b010000) ? 1 : 0;
    assign RegWre = (op == 6'b110001 || op == 6'b110000 || op == 6'b100110 || op == 6'b111000 || op == 6'b111111 || op == 6'b110010) ? 0 : 1;
    
    // PCSrc - choose next address
    assign PCSrc[0] = ((op == 6'b110000 && zero == 1) || (op == 6'b110001 && zero == 0)) ? 1 : 0;
    assign PCSrc[1] = (op == 6'b111000) ? 1 : 0;
    
    // ALUOp - choose ALU functions
    assign ALUOp[0] = (op == 6'b010010 || op == 6'b000001 || op == 6'b010011 || op == 6'b110001 || op == 6'b110000 || op == 6'b110010) ? 1 : 0;
    assign ALUOp[1] = (op == 6'b010010 || op == 6'b010011 || op == 6'b011000 || op == 6'b011100) ? 1 : 0;
    assign ALUOp[2] = (op == 6'b010001 || op == 6'b011100 || op == 6'b010000) ? 1 : 0;
    
endmodule
