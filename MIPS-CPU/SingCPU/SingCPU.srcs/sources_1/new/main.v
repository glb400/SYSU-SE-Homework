`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 19:51:00
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
    input reset,
    input [1:0] SW_in,
    output ALUSrcA,
    output ALUSrcB,
    output RegWre,
    output InsMemRW,
    output _RD,
    output _WR,
    output ExtSel,
    output [1:0] PCSrc,
    output RegDst,
    output PCWre,
    output zero,
    output sign,
    output DBdataSrc,
    output [2:0] ALUOp,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sa,
    output reg [31:0] nextPC,
    output [31:0] curPC,
    output [31:0] IDataOut,
    output [31:0] readData1,
    output [31:0] readData2,
    output [31:0] write_data,
    output [31:0] result,
    output [31:0] DataOut,
    output [31:0] next,
    output [7:0] out1,
    output [7:0] out2
    );
    wire [4:0] write_reg;
    wire [5:0] Opcode;
    wire [15:0] imd;
    wire [31:0] ExtOut;
    wire [25:0] address;
    wire [31:0] ALU_data1;
    wire [31:0] ALU_data2;
    
    wire keyOut;
    initial begin
        nextPC = 32'h0000_0000;
    end
    
    PC pc(PCWre,clk,reset,nextPC,curPC);
    
    InsMemory insmem(curPC,InsMemRW,IDataOut);
    
    assign Opcode = IDataOut[31:26];
    assign rs = IDataOut[25:21];
    assign rt = IDataOut[20:16];
    assign rd = IDataOut[15:11];
    assign sa = IDataOut[10:6];
    assign imd = IDataOut[15:0];
    assign address = IDataOut[25:0];
    assign write_reg = (RegDst == 0) ? rt : rd;
    assign ALU_data1 = (ALUSrcA == 0) ? readData1 : sa;
    assign ALU_data2 = (ALUSrcB == 0) ? readData2 : ExtOut;
        
    ControlUnit cu(Opcode,zero,sign,PCWre,ALUSrcA,ALUSrcB,DBdataSrc,RegWre,InsMemRW,_RD,_WR,RegDst,ExtSel,PCSrc,ALUOp);
        
    RegFile regfile(clk,RegWre,rs,rt,write_reg,write_data,readData1,readData2);
    
    Extend ext(imd,ExtSel,ExtOut);
    
    ALU alu(ALUOp,ALU_data1,ALU_data2,zero,result,sign);    
    
    PC4 pc4(curPC,ExtOut,PCSrc,address,next);
    
    DataMemory dataMemory(clk,result,readData2,_WR,_RD,DBdataSrc,write_data);
    
    //Display disp(SW_in,reset,curPC[7:0],nextPC[7:0],{3'b000,rs},readData1[7:0],{3'b000,rt},readData2[7:0],{7'b0000000,ALUSrcA},{7'b0000000,ALUSrcB},out1,out2);
    Display disp(SW_in,reset,curPC[7:0],nextPC[7:0],{3'b000,rs},readData1[7:0],{3'b000,rt},readData2[7:0],write_data[7:0],result[7:0],out1,out2);

    always @(*) begin
        nextPC = next;
    end
endmodule
