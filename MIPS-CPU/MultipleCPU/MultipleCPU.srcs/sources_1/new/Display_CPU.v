`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 14:57:15
// Design Name: 
// Module Name: Display_CPU
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


module Display_CPU(
    input mclk,
    input rst,
    input [1:0] SW_in,
    input clk_butn,
     
    output [7:0] dispcode,
    output [3:0] place
    );
    
    wire clk;
    wire ALUSrcA;
    wire ALUSrcB;
    wire RegWre;
    wire InsMemRW;   
    wire mRD;
    wire mWR;
    wire ExtSel;
    wire [1:0] PCSrc;
    wire [1:0] RegDst;
    wire PCWre;
    wire zero;
    wire sign;
    wire IRWre;
    wire WrRegDSrc;
    wire DBDataSrc;
    wire [2:0] ALUOp;
    wire [5:0] Opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] sa;
    wire [31:0] PC;
    wire [31:0] nextPC;
    wire clk190;
    wire clk1000;
    wire [7:0] out1;
    wire [7:0] out2;
    wire [31:0] instruction, ReadData1, ReadData2, result, ExtOut;    
    wire [2:0] cur;
    
    main uut (
        .clk(clk),    
        .rst(rst),
        .SW_in(SW_in),
        .Opcode(Opcode),
        .PC(PC),
        .nextPC(nextPC),
        .instruction(instruction),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .result(result),
        .rs(rs),
        .rt(rt),
        .out1(out1),
        .out2(out2),
        
        .PCSrc(PCSrc),
        .RegDst(RegDst),
        .ALUOp(ALUOp),
        
        .PCWre(PCWre),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .RegWre(RegWre),
        .WrRegDSrc(WrRegDSrc),
        .InsMemRW(InsMemRW),
        .mRD(mRD),
        .mWR(mWR),
        .IRWre(IRWre),
        .ExtSel(ExtSel),
        .zero(zero),
        .sign(sign),
        .ExtOut(ExtOut),
        .cur(cur)
    );
    
    CLK_divider divider(rst,mclk,clk190,clk1000);
    
    Show show(rst,clk190,out1,out2,place,dispcode);
    
    AvoidShake as(clk1000,clk_butn,clk);          
endmodule
