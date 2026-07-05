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


module FIFO_tb(

    );
    reg clk;
    reg rst;
    reg [7:0]data_in;
    reg rd_en;
    reg wr_en;
    wire [7:0] data_out;
    wire  full;
    wire  empty;
    FIFO f1(.clk(clk),.rst(rst),.data_in(data_in),.rd_en(rd_en),.wr_en(wr_en),.data_out(data_out),.full(full),.empty(empty));
    initial begin
    clk=0;
    forever #5 clk=~clk;
    end
    initial begin
    data_in=8'b1;
    forever #10 data_in=data_in+1'b1;
    end
    initial begin 
        rst=1;rd_en=0;wr_en=0;
        #20 rst=0;wr_en=1'b1;
        #20 rd_en=1'b1;
        #100 $finish;
        #100 $stop;
    end
    
endmodule
