`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 19:41:16
// Design Name: 
// Module Name: avoidshake
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


module avoidshake(
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
        begin
            keyInput_reg <= {keyInput_reg[0],keyInput};
        end
        if(1 == change)
            fifo <= 20'b0;
        else fifo <= {fifo[18:0],1'b1};
        begin
                if(20'hfffff == fifo)
                    keyOut <= keyInput_reg[0];
        end
    end
endmodule
