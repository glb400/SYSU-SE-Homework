`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 16:31:09
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


module ts;

    reg clk;
    reg rst;
    
    
    wire [5:0] Opcode;
    wire [31:0] PC, nextPC, instruction;
    wire [4:0] rs, rt;
//    wire [31:0] ADROut, BDROut, ALUoutDROut, DBDROut;
    wire [1:0] SW_in;
    wire [7:0] out1;
    wire [7:0] out2;
    wire [31:0] ReadData1, ReadData2, result, ExtOut;
    
    
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
    wire [2:0] cur;
    main uut (
        .clk(clk),
        .rst(rst),
//        .SW_in(SW_in),
        .Opcode(Opcode),
//        .ADROut(ADROut),
//        .BDROut(BDROut),
//        .ALUoutDROut(ALUoutDROut),
//        .DBDROut(DBDROut),
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
        
        .RegDst(RegDst),
        .PCSrc(PCSrc),
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
    
    initial begin
        clk = 0;
        rst = 0;
        #20
        rst = 1;
    end
    
    always begin
        #3;
        clk = ~clk;
    end    
endmodule
