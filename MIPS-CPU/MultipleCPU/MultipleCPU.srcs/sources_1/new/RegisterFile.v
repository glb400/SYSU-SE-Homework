`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:47:01
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input clk,
    input RegWre,
    input [4:0] WriteReg,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
//    output reg [31:0] ReadData1,
//    output reg [31:0] ReadData2
    );
    
    reg [31:0] Register [0:31];
    
    integer i;
    initial begin
        for (i = 0;i < 32;i = i + 1)
            Register[i] <= 0;
    end

    assign ReadData1 = Register[rs];
    assign ReadData2 = Register[rt];
    
        
    always @(posedge clk) begin
        if(WriteReg != 0 && (RegWre == 1))
            Register[WriteReg] <= WriteData;
    end
endmodule
