`timescale 1ns/1ns

module tb_counter;

    	logic [15:0] tdata_in, tdata_out;
	logic trst_, tld_cnt, tupdn_cnt, tcount_enb, tclk;

	counter c1 (
        .data_in(tdata_in), 
        .rst_(trst_), 
        .ld_cnt(tld_cnt), 
        .updn_cnt(tupdn_cnt), 
        .count_enb(tcount_enb), 
        .clk(tclk), 
        .data_out(tdata_out)
        );

	bind c1 counter_property cp1 ( 
        .pdata_in(data_in), 
        .prst_(rst_), 
        .pld_cnt(ld_cnt), 
        .pupdn_cnt(updn_cnt), 
        .pcount_enb(count_enb), 
        .pclk(clk), 
        .pdata_out(data_out)
        );
    
    localparam CLK_PERIOD = 4;
    
    always #(CLK_PERIOD/2) tclk=~tclk;

    initial begin
        // first all xs
        #2  trst_=1'bx; tclk=1'bx; tdata_in=16'bx; tld_cnt=1'bx; tupdn_cnt=1'bx; tcount_enb=1'bx; 
        // activate reset
        #10 trst_=1'b0; tclk=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b1; tcount_enb=1'b0; 
        // hold reset for 16, not enable counting
        #16 trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b1; tcount_enb=1'b0;
        // enable counting upcounting
        #8  trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b1; tcount_enb=1'b1;
        // do nothing for one 
        #20 trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b0; tcount_enb=1'b0;
        // downcount
        #8  trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b0; tcount_enb=1'b1;
        // do nothing
        #16 trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b0; tcount_enb=1'b0;
        // load value
        #8 trst_=1'b1; tdata_in=16'd6942; tld_cnt=1'b0; tupdn_cnt=1'b1; tcount_enb=1'b0; 
        // do nothing
        #4  trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b1; tcount_enb=1'b0; 
        // count up till it resets
        #4  trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b1; tcount_enb=1'b1;
        // do nothing
        #32 trst_=1'b1; tdata_in=16'b0; tld_cnt=1'b1; tupdn_cnt=1'b1; tcount_enb=1'b0; 
        
        $stop(2);
    end
    

endmodule
