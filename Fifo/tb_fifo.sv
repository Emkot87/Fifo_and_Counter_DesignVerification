`timescale 1ns/1ns

module tb_fifo;
    logic [15:0] tfifo_data_in, tfifo_data_out;

    logic trst_, tclk, tfifo_write, tfifo_read, tfifo_full, tfifo_empty;

    fifo f1 (
        .fifo_data_in(tfifo_data_in),     
        .rst_(trst_), 
        .clk(tclk), 
        .fifo_write(tfifo_write), 
        .fifo_read(tfifo_read),
        .fifo_data_out(tfifo_data_out), 
        .fifo_full(tfifo_full), 
        .fifo_empty(tfifo_empty)
        );

    bind f1 fifo_property fp1 (
        .pfifo_data_in(fifo_data_in),
        .prst_(rst_),
        .pclk(clk),
        .pfifo_write(fifo_write),
        .pfifo_read(fifo_read),
        .pfifo_data_out(fifo_data_out),
        .pfifo_full(fifo_full),
        .pfifo_empty(fifo_empty),
        .prd_ptr(f1.rd_ptr),
        .pwr_ptr(f1.wr_ptr),
        .pcnt(f1.cnt)
    );

    localparam CLK_PERIOD = 4;

    always #(CLK_PERIOD/2) tclk=~tclk;
    
    initial begin
        #1  trst_ = 1'bx; tclk = 1'bx; tfifo_write = 1'bx; tfifo_read = 1'bx; tfifo_data_in = 16'bx;  

        #10 trst_ = 1'b0; tclk = 1'b1; tfifo_write = 1'b0; tfifo_read = 1'b0; tfifo_data_in = 16'b0;  

        #16 trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd1;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd2;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd3;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd4;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd5;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd6;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd7;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd8;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd9;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd10;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd11;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd12;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd13;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd14;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd15;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd16;

        #4  trst_ = 1'b1; tfifo_write = 1'b1; tfifo_read = 1'b0; tfifo_data_in = 16'd234;

        #4  trst_ = 1'b1; tfifo_write = 1'b0; tfifo_read = 1'b1; tfifo_data_in = 16'd234;
        
        #(16*5) trst_ = 1'b1; tfifo_write = 1'b0; tfifo_read = 1'b1; tfifo_data_in = 16'd234;

        $stop(2);
    end

endmodule
