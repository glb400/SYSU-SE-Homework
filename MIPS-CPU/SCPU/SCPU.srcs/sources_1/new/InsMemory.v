`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:09:44
// Design Name: 
// Module Name: InsMemory
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


module InsMemory(
    input [31:0] IAddr,
    input InsMemRW, //指令存储器读写控制信号，为0写，为1读
//    input IDataIn,
    output [31:0] IDataOut //指令存储器数据输出端口
    );
    reg [7:0] InsMEM [127:0];
    
    initial begin
        $readmemb("C:/Users/YURAN GU/Desktop/Ins.txt", InsMEM, 0, 127);
    end
	assign IDataOut = { InsMEM[IAddr], InsMEM[IAddr + 1], InsMEM[IAddr + 2], InsMEM[IAddr + 3] };
endmodule
