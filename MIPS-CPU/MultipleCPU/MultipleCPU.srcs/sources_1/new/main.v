`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 13:25:07
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input rst,
    input [1:0] SW_in,
    
    output [5:0] Opcode,
//    output [31:0] ADROut,
//    output [31:0] BDROut,
//    output [31:0] ALUoutDROut,
//    output [31:0] DBDROut,
    output [31:0] PC,
    output [31:0] nextPC,
    output [31:0] instruction,
   
   output [31:0] ReadData1,
   output [31:0] ReadData2,
   output [31:0] result,
   
    output [4:0] rs,
    output [4:0] rt,
    
    output [7:0] out1,
    output [7:0] out2,
    
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
    output DBDataSrc,
    output RegWre,
    output WrRegDSrc,
    output InsMemRW,
    output mRD,
    output mWR,
    output IRWre,
    output ExtSel,
    output zero,
    output sign,
     
    output [1:0] PCSrc,
    output [1:0] RegDst,    
    output [2:0] ALUOp,
    
    output [31:0] ExtOut,
    
    output [2:0] cur,
    output [2:0] next
    );
    
//    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, zero, sign;  
//    wire [1:0] PCSrc;
//    wire [1:0] RegDst;    
//    wire [2:0] ALUOp;
    wire [4:0] rd, sa, WriteReg;
    wire [15:0] imd;
    wire [25:0] addr;
    wire [31:0] DBDRIn, DataOut, JumpAddr, WriteData, ADROut, BDROut, ALUoutDROut, DBDROut;

//    wire [31:0] ReadData1, ReadData2;
//    wire [31:0] result;
    assign Opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign sa = instruction[10:6];
    assign imd = instruction[15:0];
    assign addr = instruction[25:0];
    
    PC pc(clk,rst,PCWre,PCSrc,JumpAddr, ExtOut, ReadData1, PC, nextPC);
    
    ALU alu(ALUSrcA, ALUSrcB, ALUOp, sa, ADROut, ExtOut, BDROut, result, zero, sign);
    ALUoutDR aluoutdr(clk, result, ALUoutDROut);
    
    DataMEM datamem(mRD, mWR, ALUoutDROut, BDROut,DataOut);
    DBDRSelector dbdrselector(DBDataSrc, result, DataOut, DBDRIn);
    DBDR dbdr(clk, DBDRIn, DBDROut);

    WriteDataSelector writedataselector(WrRegDSrc, PC + 8, DBDROut, WriteData);
    WriteRegSelector writeregselector(RegDst, rt, rd, WriteReg);
    
    RegisterFile registerfile(clk, RegWre, WriteReg, instruction[25:21], instruction[20:16], instruction[15:11], WriteData, ReadData1, ReadData2);
    ADR adr(clk, ReadData1, ADROut);
    BDR bdr(clk, ReadData2, BDROut);
    
    Extend extend(ExtSel, imd, ExtOut);
    
    PC4 pc4(addr, PC, JumpAddr);
    
    InsMEM insmem(clk, InsMemRW,IRWre ,PC, instruction);

    ControlUnit controlunit(clk, rst, zero, sign, Opcode, mWR, mRD, IRWre, RegWre,
                            PCWre, ExtSel, InsMemRW, ALUSrcA, ALUSrcB,DBDataSrc,
                            WrRegDSrc, PCSrc,RegDst, ALUOp, cur, next);
                            
//    Display display(SW_in, rst, PC[7:0], nextPC[7:0],{3'b000, rs},ReadData1[7:0],{3'b000, rt},ReadData2[7:0],result[7:0], instruction[7:0], out1, out2);

    Display display(SW_in, rst, PC[7:0], nextPC[7:0],ADROut[7:0],BDROut[7:0],DBDROut[7:0],ALUoutDROut[7:0],{3'b000,PCSrc,cur}, {5'b00000, next}, out1, out2);

endmodule
