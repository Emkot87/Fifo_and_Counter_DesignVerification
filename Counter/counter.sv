
module counter
        (output logic [15:0] data_out,
        input logic [15:0] data_in,
        input logic rst_, ld_cnt, updn_cnt, count_enb, clk);

always_ff @(posedge clk, negedge rst_ ) begin
    if(!rst_) begin
        data_out <= 0;
    end
    else begin 
        if(!ld_cnt) begin 
            data_out <= data_in;
        end
        else if(count_enb) begin
	    if(updn_cnt == 1) data_out <= data_out + 1;
	    else if(updn_cnt == 0) data_out <= data_out - 1; 
            //data_out <= (updn_cnt == 1) ? data_out + 1 : data_out - 1 ;
        end
    end
end

endmodule