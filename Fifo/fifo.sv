module fifo
        #(parameter WIDTH = 16,
        parameter DEPTH = 16)
        (output logic [WIDTH-1:0] fifo_data_out,
        output logic fifo_full, fifo_empty,
        input logic [WIDTH-1:0] fifo_data_in,
        input logic rst_, clk, fifo_write, fifo_read);

        logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;
        logic [DEPTH-1:0][WIDTH-1:0] fifo_memory;
        logic [$clog2(DEPTH):0] cnt;

	always_ff @(posedge clk, negedge rst_) begin 

	if(!rst_) begin
	    for(bit[4:0] i = 0 ;i <= DEPTH - 1 ; i++)begin fifo_memory[i] <= 0 ; end
	    wr_ptr <= 0;
   	    rd_ptr <= 0;
	    cnt <= 0;
        end

        else begin

            if(fifo_write && !fifo_full) begin
                fifo_memory[wr_ptr] <= fifo_data_in;
                wr_ptr <= wr_ptr + 1 ;
                cnt <= cnt + 1 ;
            end
        
            else if(fifo_read && !fifo_empty)begin
                fifo_data_out <= fifo_memory[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                cnt <= cnt - 1;
            end

        end
    end
    
    always_comb begin
        if(cnt == 0) begin 
            fifo_empty = 1;
            fifo_full = 0;
        end
        else if(cnt == DEPTH) begin 
            fifo_empty = 0;
            fifo_full = 1;
        end
        else begin 
            fifo_empty = 0;
            fifo_full = 0;
        end
    end

endmodule