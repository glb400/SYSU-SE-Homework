`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:33:40
// Design Name: 
// Module Name: Extend
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


module Extend(
    input ExtSel,
    input [15:0] imd,
    output reg [31:0] ExtOut
    );
    
    always @(imd or ExtSel) begin
        if(ExtSel) begin
            if(imd[15])
                ExtOut <= {16'hffff,imd[15:0]};
            else
                ExtOut <= {16'h0000,imd[15:0]};
        end
        
        else 
            ExtOut <= {16'h0000, imd[15:0]};
    end
endmodule
