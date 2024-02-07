`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 21:23:28
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input clk,
    input rst,
    input zero,
    input sign,
    input [5:0] Opcode,
    
//    output reg [2:0] curstate,
//    output reg [2:0] nextstate,
    output reg mWR,
    output reg mRD,
    output reg IRWre,
    output reg RegWre,
    output reg PCWre,
    output reg ExtSel,
    output reg InsMemRW,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg WrRegDSrc,
    output reg [1:0] PCSrc,
    output reg [1:0] RegDst,
    output reg [2:0] ALUOp,
    output reg [2:0] cur,
    output reg [2:0] next
    );
    
//    reg [2:0] cur;
//    reg [2:0] next;
    
    //State Table
    parameter [2:0] IF = 3'b000;
    parameter [2:0] ID = 3'b001;
    parameter [2:0] EXE1 = 3'b110;
    parameter [2:0] EXE2 = 3'b101;
    parameter [2:0] EXE3 = 3'b010;
    parameter [2:0] MEM = 3'b011;
    parameter [2:0] WB1 = 3'b111;
    parameter [2:0] WB2 = 3'b100;
    
    parameter [5:0] ADD = 6'b000000;
    parameter [5:0] SUB = 6'b000001;
    parameter [5:0] ADDIU = 6'b000010;
    parameter [5:0] AND = 6'b010000;
    parameter [5:0] ANDI = 6'b010001;
    parameter [5:0] ORI = 6'b010010;
    parameter [5:0] XORI = 6'b010011;
    parameter [5:0] SLL = 6'b011000;
    parameter [5:0] SLTI = 6'b100110;
    parameter [5:0] SLT = 6'b100111;
    parameter [5:0] SW = 6'b110000;
    parameter [5:0] LW = 6'b110001;
    parameter [5:0] BEQ = 6'b110100;
    parameter [5:0] BNE = 6'b110101;
    parameter [5:0] BLTZ = 6'b110110;
    parameter [5:0] J = 6'b111000;
    parameter [5:0] JR = 6'b111001;
    parameter [5:0] JAL = 6'b111010;
    parameter [5:0] HALT = 6'b111111;                                                   
        
    initial begin
        next <= ID;
    end
    
    always @(posedge clk) begin
        if(!rst)
            cur <= IF;
        else 
            cur <= next;
    end    
    
    always @(cur or Opcode or zero or sign) begin
        case(cur)
            IF: next <= ID;
            ID: 
                begin
                    case (Opcode)
                        J,JR,JAL,HALT:begin
                            next <= IF;
                        end
                        BEQ,BNE,BLTZ:begin
                            next <= EXE2;
                        end
                        SW,LW:begin
                            next <= EXE3;
                        end
                        default:
                            next <= EXE1;
                    endcase
                end
            EXE1:
                begin
                    next <= WB1;
                end
            EXE2:
                begin
                    next <= IF;
                end
            EXE3:
                begin
                    next <= MEM;
                end
            MEM:
                begin
                    case (Opcode)
                        SW:begin
                            next <= IF;
                        end
                        LW:begin
                            next <= WB2;
                        end
                    endcase
                end
            WB1:
                begin
                    next <= IF;
                end
            WB2:
                begin
                    next <= IF;
                end
        endcase
    end
    
//    reg [9:0] c;
            
    always @(cur or zero or sign or Opcode) begin
 
//        c <= 10'b0000000000;
//        if (c < 1000) begin
//            c <= c + 1;
//        end
            
        //PCWre
//        if (cur == WB1 
//        || cur == WB2 
//        || (Opcode == SW && cur == MEM) 
//        || (Opcode == BEQ || Opcode == BNE || Opcode == BLTZ && cur == EXE2)     
//        || (Opcode == J || Opcode == JR || Opcode == JAL && cur == ID))
//           PCWre = 1;
//        else
//           PCWre = 0;

        if (cur == IF) begin
            if (Opcode == HALT)
                PCWre = 0;
            else
                PCWre = 1;
        end
        else
            PCWre = 0;
            
//        PCWre = (next == IF) && (Opcode != HALT);
        //ALUSrcA
        if (cur == EXE1 && Opcode == SLL)
            ALUSrcA = 1;
        else
            ALUSrcA = 0;
        //ALUSrcB
        if ((cur == EXE1 && (Opcode == ADDIU 
                            || Opcode == ANDI 
                            || Opcode == ORI 
                            || Opcode == XORI 
                            || Opcode == SLTI)) || (cur == EXE3 && (Opcode == SW || Opcode == LW))) 
            ALUSrcB = 1;
        else 
            ALUSrcB = 0;
        //DBDataSrc
        if (cur == MEM && Opcode == LW)
            DBDataSrc = 1;
        else
            DBDataSrc = 0;
        //RegWre
        //if (Opcode == BEQ || Opcode == BNE || Opcode == BLTZ || Opcode == J || Opcode == SW || Opcode == JR || Opcode == HALT)
        if (Opcode == BNE || Opcode == BLTZ || Opcode == J || Opcode == SW || Opcode == JR || Opcode == HALT)
            RegWre = 0;
        else
            RegWre = 1;
        //WrRegDSrc 
        if (cur == WB1 || cur == WB2)
            WrRegDSrc = 1;
        else if ((cur == ID && Opcode == JAL) || (cur == ID && Opcode == LW) || Opcode == JR || Opcode == BEQ)
            WrRegDSrc = 0;
        //InsMemRW
//        if (cur == IF)
//            InsMemRW = 1;
//        else
//            InsMemRW = 0;
        InsMemRW = 1;
        //mRD
        if (cur == MEM && Opcode == LW)
            mRD = 1;
        else
            mRD = 0;
        //mWR
        if (cur == MEM && Opcode == SW)
            mWR = 1;
        else
            mWR = 0;
        //IRWre
        if (cur == IF)
            IRWre = 1;
        else
            IRWre = 0;
        //ExtSel
        if ((cur == EXE1 && (Opcode == ADDIU || Opcode == SLTI )) || cur == EXE2 || cur == EXE3) 
            ExtSel = 1;
        else if (cur == EXE1 && (Opcode == ANDI || Opcode == XORI || Opcode == ORI))
            ExtSel = 0;
        //PCSrc
//        if (next == IF && (Opcode == J || Opcode == JAL))
        if (Opcode == J || Opcode == JAL)
            PCSrc = 2'b11;
//        else if (next == IF && Opcode == JR)
        else if (Opcode == JR)
            PCSrc = 2'b10;
//        else if (next == IF && ((Opcode == BEQ && zero == 1) || (Opcode == BNE && zero == 0) || (Opcode == BLTZ && sign == 1)))
        else if (cur == IF && ((Opcode == BEQ && zero == 1) || (Opcode == BNE && zero == 0) || (Opcode == BLTZ && sign == 1)))
            PCSrc = 2'b01;
        else
            PCSrc = 2'b00;
        //RegDst
//        if ((cur == ID || next == ID) && Opcode == JAL)
        if ((cur == ID && Opcode == BEQ) || Opcode == JR)
            RegDst = 2'b00;
        else if ((cur == WB1 && (Opcode == ADDIU 
                                || Opcode == ANDI 
                                || Opcode == ORI 
                                || Opcode == XORI 
                                || Opcode == SLTI)) || cur == WB2)    
            RegDst = 2'b01;
        else if (cur == WB1 && (Opcode == ADD 
                                || Opcode == SUB 
                                || Opcode == AND 
                                || Opcode == SLT 
                                || Opcode == SLL))
            RegDst = 2'b10;
        else 
            RegDst = 2'b11;
        //ALUOp
        case (Opcode)
            ADD,ADDIU,LW,SW:begin
                ALUOp = 3'b000;
            end
            SUB,BEQ,BNE,BLTZ:begin
                ALUOp = 3'b001;
            end
            SLL:begin
                ALUOp = 3'b010;
            end
            ORI:begin
                ALUOp = 3'b011;
            end
            AND,ANDI:begin
                ALUOp = 3'b100;
            end
            SLT,SLTI:begin
                ALUOp = 3'b110;
            end
            XORI:begin
                ALUOp = 3'b111;
            end
            default:begin
                ALUOp = 3'b000;
            end
        endcase  
    end    
endmodule
