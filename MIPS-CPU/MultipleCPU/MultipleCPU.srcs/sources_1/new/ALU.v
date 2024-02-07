`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 19:32:42
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
    input ALUSrcA,
    input ALUSrcB,
    input [2:0] ALUOp,
    input [4:0] sa,
    input [31:0] ReadData1,
    input [31:0] ExtOut,
    input [31:0] ReadData2,
    output reg [31:0] result,
    output zero,
    output sign
    );
    
    assign zero = (result ? 0 : 1);
    assign sign = result[31];
    
    wire [31:0] A;
    wire [31:0] B;
    assign A = (ALUSrcA ? sa : ReadData1);
    assign B = (ALUSrcB ? ExtOut : ReadData2);
    
    always @ (A or B or ALUOp) begin 
        case(ALUOp)
            3'b000: result <= A + B;
            3'b001: result<=  A - B;
            3'b010: result <= B << A;            
            3'b011: result <= A | B;    
            3'b100: result <= A & B;        
            3'b101: result <= (A < B) ? 1 : 0;
            3'b110: result <= (((A < B) && (A[31] == B[31])) || ((A[31] == 1 && B[31] == 0))) ? 1 : 0;
            3'b111: result <= A ^ B;
            default: result <= 0;             
        endcase
    end
endmodule
