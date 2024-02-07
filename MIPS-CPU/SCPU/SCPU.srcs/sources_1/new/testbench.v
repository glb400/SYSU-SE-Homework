`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 20:51:06
// Design Name: 
// Module Name: test
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


module testbench(

    );
    reg clk;
    reg reset;
    reg mclk;
    reg [1:0] SW_in;
    reg clk_butn;
    
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
    wire [7:0] dispcode;
    wire [3:0] place;
    
    main uut(
        .clk(clk),
        .mclk(mclk),
        .SW_in(SW_in),
        .clk_butn(clk_butn),
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
        .clk190(clk190),
        .clk1000(clk1000),
        .out1(out1),
        .out2(out2),
        .dispcode(dispcode),
        .place(place)
        );
        
        initial begin
            clk = 0;
            reset = 1;
            #10;
            forever #10 clk = ~clk;
        end
             
endmodule
