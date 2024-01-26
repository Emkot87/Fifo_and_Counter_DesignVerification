`timescale 1ns/1ns

module fifo_property(pfifo_data_in, prst_, pfifo_write, pfifo_read, pclk, pfifo_data_out, pfifo_full, pfifo_empty, prd_ptr, pwr_ptr, pcnt );

input [15:0] pfifo_data_in, pfifo_data_out;
input [3:0] prd_ptr, pwr_ptr;
input [4:0] pcnt;
input prst_, pfifo_write, pfifo_read, pclk, pfifo_full, pfifo_empty;

property pr1;
    @(posedge pclk) !prst_ |-> (pfifo_empty && !pfifo_full && !prd_ptr && !pwr_ptr && !pcnt) ;
endproperty

property pr2;
    @(posedge pclk) disable iff(!prst_) !pcnt |-> pfifo_empty ;
endproperty

property pr3;
    @(posedge pclk) disable iff(!prst_) pcnt >= 16 |-> pfifo_full ;
endproperty

property pr4;
    @(posedge pclk) (pfifo_full && pfifo_write && !pfifo_read) |=> (pwr_ptr == $past(pwr_ptr));
endproperty

property pr5;
    @(posedge pclk) (pfifo_empty && !pfifo_write && pfifo_read) |=> (prd_ptr == $past(prd_ptr));
endproperty


ap1 : assert property (pr1) else $display("pr1 FAIL time : %0t", $time);
cp1 : cover property (pr1) $display("pr1 PASS time : %0t", $time);

ap2 : assert property (pr2) else $display("pr2 FAIL time : %0t", $time);
cp2 : cover property (pr2) $display("pr2 PASS time : %0t", $time);

ap3 : assert property (pr3) else $display("pr3 FAIL time : %0t", $time);
cp3 : cover property (pr3) $display("pr3 PASS time : %0t", $time);

ap4 : assert property (pr4) else $display("pr4 FAIL time : %0t", $time);
cp4 : cover property (pr4) $display("pr4 PASS time : %0t", $time);

ap5 : assert property (pr5) else $display("pr5 FAIL time : %0t", $time);
cp5 : cover property (pr5) $display("pr5 PASS time : %0t", $time);


endmodule