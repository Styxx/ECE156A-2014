/*
* Behavioural counter up to 10(dec)
* Vincent "Styxx" Chang
*/
module counter(count, start,reset,clk);
  input start, reset, clk;
  output [3:0] count;

  reg [3:0] count;

  always @ (posedge clk or posedge reset)
    if(reset) begin
	    count <= 4'b0;
    end else if (~start) begin
      if (count == 2'b1010) begin
        count <= 4'b0;
      end else begin
	      count <= count + 1;
      end
    end

endmodule
