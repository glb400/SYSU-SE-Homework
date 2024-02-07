`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 13:07:12
// Design Name: 
// Module Name: ALU
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


module ALU(
    input[2:0] ALUOp,
    input[31:0] ReadData1,
    input[31:0] ReadData2,
    output zero,
    output reg [31:0] result,
    output sign
    );
    
    initial begin
        result = 0;
    end
    assign zero = (result ? 0 : 1);
    assign sign = result[31];
    
    always @(ReadData1 or ReadData2 or ALUOp) begin
        case(ALUOp)
            3'b000: result = ReadData1 + ReadData2;
            3'b001: result = ReadData1 - ReadData2;
            3'b010: result = ReadData2 << ReadData1;
            3'b011: result = ReadData1 | ReadData2;
            3'b100: result = ReadData1 & ReadData2;
            3'b101: result = (ReadData1 < ReadData2)? 1:0;
            3'b110: begin
                        if(ReadData1 < ReadData2 && (ReadData1[31] == ReadData2[31]))
                            result = 1;
                        else if(ReadData1[31] == 1 && ReadData2[31] == 0) result = 1;
                        else result = 0;
                    end
            3'b111: result = (~ReadData1 & ReadData2) | (ReadData1 & ~ReadData2);
            default: result = 0;
        endcase
    end
endmodule
