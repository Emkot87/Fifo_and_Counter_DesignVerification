`timescale 1ns/1ns
module counter_property(pdata_in, prst_, pld_cnt, pupdn_cnt, pcount_enb, pclk, pdata_out);

input [15:0] pdata_in,pdata_out;
input prst_, pld_cnt, pupdn_cnt, pcount_enb, pclk;

property pr1;
    @(posedge pclk) !prst_ |-> pdata_out == 0;
endproperty

property pr2;
    @(posedge pclk) disable iff(!prst_) (pld_cnt && !pcount_enb) |=> (pdata_out == $past(pdata_out) );
endproperty

property pr3;
    @(posedge pclk) disable iff(!prst_) 
         (pld_cnt && pcount_enb) |=> 
	if($past(pupdn_cnt))
        ( ($past(pdata_out) + 1)  == pdata_out)
        else if( !($past(pupdn_cnt)) )
        ( ($past(pdata_out) - 1)  == pdata_out);
endproperty

ap1 : assert property (pr1) else $display("pr1 FAIL time : %0t ", $time);
cp1 : cover property (pr1) $display("pr1 PASS time : %0t ", $time);

ap2 : assert property (pr2) else $display("pr2 FAIL time : %0t", $time);
cp2 : cover property (pr2) $display("pr2 PASS time : %0t", $time);

ap3 : assert property (pr3) else $display("pr3 FAIL time : %0t", $time);
cp3 : cover property (pr3) $display("pr3 PASS time : %0t", $time);


endmodule