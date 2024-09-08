`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIT Rourkela
// Engineer: Rishi Sriram
// 
// Create Date: 08/23/2024 11:09:54 PM
// Design Name: 
// Module Name: transmitter
// Project Name: 
// Target Devices: Digilent Basys 3
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


module TxUART(
    input clk,
    input [7:0] data,
    input transmit,
    input reset,
    output reg TxD
    );

    reg [3:0] bit_counter;
    reg [13:0] baudrate_counter;
    reg [9:0] shiftright_register;
    reg state,next_state;
    reg shift;
    reg load;
    reg clear;

    parameter clk_freq = 100_000_000;
    parameter baud_rate = 9600;
    parameter div_sample = 4;
    parameter div_counter = clk_freq/(baud_rate);
    parameter mid_sample = (div_sample/2);
    parameter div_bit = 10;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            bit_counter <= 0;
            baudrate_counter <=0;
        end else begin
            baudrate_counter <= baudrate_counter + 1;
            if (baudrate_counter == div_counter - 1)begin
                state <= next_state;
                baudrate_counter <= 0;
                if (load)
                    shiftright_register = {1'b1,data,1'b0};
                if (clear)
                    bit_counter <= 0;
                if (shift)begin
                    shiftright_register <= shiftright_register >> 1;
                    bit_counter <= bit_counter + 1;
                end
            end
        end
    end

    always @(posedge clk) begin
        load <= 0;
        shift <= 0;
        clear <= 0;
        TxD <= 1;
        case (state)
            0:begin
                if (transmit) begin
                    next_state <= 1;
                    load <= 1;
                    shift <= 0;
                    clear <= 0;
                end else begin
                    next_state <= 0;
                    TxD <= 1;         
                end
            end

            1:begin
                if (bit_counter == 10)begin
                    next_state <= 0;
                    clear <= 1;
                end else begin
                    next_state <= 1;
                    TxD <= shiftright_register[0];
                    shift <= 1;                
                end
            end
            default: next_state <= 0;
        endcase
    end
endmodule
