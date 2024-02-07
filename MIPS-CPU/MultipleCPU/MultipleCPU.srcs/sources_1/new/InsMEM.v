`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:15:36
// Design Name: 
// Module Name: InsMEM
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


module InsMEM(
    input clk,
    input InsMemRW,
    input IRWre,
    input [31:0] IAddr,
    output reg [31:0] DataOut
    );
    reg [31:0] store;
    reg [7:0] insMem [0:127];
    
    initial begin
        $readmemb("C:/Users/YURAN GU/Desktop/Ins.txt", insMem);
    end    
    
//    always @(IAddr or InsMemRW) begin
    always @(*) begin
        if(InsMemRW) begin
            store[31:24] = insMem[IAddr];
            store[23:16] = insMem[IAddr + 1];
            store[15:8] = insMem[IAddr + 2];
            store[7:0] = insMem[IAddr + 3];
        end
    end

    reg [9:0] c;    

    always @(negedge clk) begin
//        if (IRWre)
        c <= 10'b0000000000;
        if (c < 1000) begin
            c <= c + 1;
        end
            DataOut <= store;
    end
endmodule
