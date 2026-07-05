`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JOHN WICK(BOOGYMAN)
// 
// Create Date: 05.07.2026 17:06:00
// Design Name: HDLC PROTOCOL
// Module Name: FIFO
// Project Name: HDLC
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO(
    input clk,
    input rst,
    input [7:0]data_in,
    input rd_en,
    input wr_en,
    output reg [7:0] data_out,
    output  full,
    output  empty
    );
    reg [5:0] re_pointer,wr_pointer;
    reg [7:0] mem [31:0];
    
    //------Read Operation------
    always@(posedge clk) begin
        if (rst) begin
            data_out<=8'b0;
        end
        else begin
            if (rd_en && !empty) begin
                data_out<=mem[re_pointer[4:0]];
            end
        end
    end
    integer i;
    
    //------Write Operation------
    always@(posedge clk) begin
        if (rst) begin
            for(i=0;i<8;i=i+1)
                mem[i]<=0;
        end
        else if(!full && wr_en) begin
            mem[wr_pointer[4:0]]<=data_in;
        end
    end
    
    //------Pointer Logic------
    always@(posedge clk) begin
        if (rst)begin
        wr_pointer<=6'd0;
        end
        else if (!full && wr_en)begin
            wr_pointer<=wr_pointer+1;
        end
    end
    
    always@(posedge clk) begin
        if (rst) begin
            re_pointer<=6'd0;
        end
        else if (!empty && rd_en) begin
            re_pointer<=re_pointer+1;
        end
    end
    
    assign full=(wr_pointer==({~re_pointer[5],re_pointer[4:0]}));
    assign empty=(re_pointer==wr_pointer);
    
