/*
* Testbench
*/
module BehavUpCntTB();

//Controls
reg clk;
reg a_reset;
reg s_reset;
reg start;

wire count;

BehavUpCnt uc(count, start,a_reset,s_reset,clk);

//setup
initial
begin
	clk <= 1'b0;
	s_reset <= 1'b0;
	start <= 1'b0;
	#10 s_reset <= 1'b1; // wait 10 time units (mS, nS, etc) then assign 1 to reset
	#20 a_reset <= 1'b0;
	#30 a_reset <= 1'b1;
	#35 a_reset <= 1'b0;
	#40 a_reset <= 1'b1;

end

//clock signal
always
begin
	#20 clk <= ~clk; // clock signal with period of 20
end
endmodule

/*
* Behavioural 4-bit counter
* with active low asynch/synch resets and enable
* Counts up from 0 to 15 and repeats
*/

module BehavUpCnt(count, start,a_reset,s_reset,clk);
  input start, a_reset, s_reset, clk;
  output [3:0] count;

  reg [3:0] count;

  always @ (posedge clk or a_reset)
    if(~a_reset) begin
	count = 4'b0;
    end else if (~s_reset) begin
	count = 4'b0;
    end else if (~start) begin
	count <= count + 1;
    end

endmodule
