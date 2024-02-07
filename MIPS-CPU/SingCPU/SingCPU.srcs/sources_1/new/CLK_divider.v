`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 17:34:03
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
    input wire reset,
    input wire clk,
    output wire clk190,
    output wire clk1000
    );
    reg [26:0] fifo;
    
    always @(posedge clk) begin
        begin
            if(reset == 0)
                fifo <= 0;
            else
                fifo <= fifo + 1;
        end
    end
    
    assign clk190 = fifo[14];
    assign clk1000 = fifo[18];
endmodule
