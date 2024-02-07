`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 17:39:34
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
    input reset,
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
   wire _RD;
   wire _WR;
   wire ExtSel;
   wire [1:0] PCSrc;
   wire RegDst;
   wire PCWre;
   wire zero;
   wire sign;
   wire DBdataSrc;
   wire [2:0] ALUOp;
   wire [4:0] rs;
   wire [4:0] rt;
   wire [4:0] rd;
   wire [4:0] sa;
   wire [31:0] nextPC;
   wire [31:0] curPC;
   wire [31:0] IDataOut;
   wire [31:0] readData1;
   wire [31:0] readData2;
   wire [31:0] write_data;
   wire [31:0] result;
   wire [31:0] DataOut;
   wire [31:0] next;
   wire clk190;
   wire clk1000;
   wire [7:0] out1;
   wire [7:0] out2;
   
    main uut(
             .clk(clk),
             .reset(reset),
             .SW_in(SW_in),
             .ALUSrcA(ALUSrcA),
             .ALUSrcB(ALUSrcB),
             .RegWre(RegWre),
             .InsMemRW(InsMemRW),
             ._RD(_RD),
             ._WR(_WR),
             .ExtSel(ExtSel),
             .PCSrc(PCSrc),
             .RegDst(RegDst),
             .PCWre(PCWre),
             .zero(zero),
             .sign(sign),
             .DBdataSrc(DBdataSrc),
             .ALUOp(ALUOp),
             .rs(rs),
             .rt(rt),
             .rd(rd),
             .sa(sa),
             .nextPC(nextPC),
             .curPC(curPC),
             .IDataOut(IDataOut),
             .readData1(readData1),
             .readData2(readData2),
             .write_data(write_data),
             .result(result),
             .DataOut(DataOut),
             .next(next),
             .out1(out1),
             .out2(out2)        
          );    
            
   CLK_divider divider(reset,mclk,clk190,clk1000);
        
   Show show(reset,clk190,out1,out2,place,dispcode);
        
   AvoidShake as(clk1000,clk_butn,clk);
    
endmodule
