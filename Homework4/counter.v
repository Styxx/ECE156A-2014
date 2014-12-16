/*
* Behavioural counter up to 10(dec)
*/
module counter(count, start,a_reset,s_reset,clk);
  input start, reset, clk;
  output [3:0] count;

  reg [3:0] count;

  always @ (posedge clk or reset)
    if(reset) begin
	    count = 4'b0;
    end else if (~start) begin
      if (count == 2'b1010) begin
        count = 4'b0;
      end else begin
	      count <= count + 1;
      end
    end

endmodule
