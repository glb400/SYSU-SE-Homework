`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 12:58:42
// Design Name: 
// Module Name: CLK_divider
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


module CLK_divider(
    input rst,
    input clk,
    output clk190,
    output clk1000
    );
    
    reg [26:0] fifo;
    always @(posedge clk) begin
        if (rst == 0)
            fifo <= 0;
        else 
            fifo <= fifo + 1;
    end
    
    assign clk190 = fifo[14];
    assign clk1000 = fifo[18];
endmodule
