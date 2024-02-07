`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 13:12:51
// Design Name: 
// Module Name: AvoidShake
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


module AvoidShake(
    input clk1000,
    input keyInput,
    output reg keyOut
    );
    
    reg [19:0] fifo;
    reg [1:0] keyInput_reg;
    wire change;
    
    initial 
        keyOut = 1'b1;
    
    assign change = keyInput_reg[0] ^ keyInput_reg[1];
    
    always @(posedge clk1000) begin
        keyInput_reg <= {keyInput_reg[0], keyInput};
        
        if (change == 1)
            fifo <= 20'b0;
        else
            fifo <= {fifo[18:0],1'b1};
        
        if (fifo == 20'hfffff)
            keyOut <= keyInput_reg[0];    
    end
endmodule
