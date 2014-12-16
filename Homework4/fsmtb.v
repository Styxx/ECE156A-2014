module fsmtb;

reg clk, rs, x;
reg reset, shift, update, run;

fsm FinStMach(clk, x, rs, reset, shift, update, run);

initial	begin
	clk=1;
	x=1;
	rs=1;
	  
	#10 rs=0; #4; #10 rs=1;			//Quick Reset
	#10 x=0;						//From reset to run
	#10 x=1;						//From run to shift
	#10 x=0;						//From shift to update
	#10 x=1;						//From update to reset
	#10 x=1;						//From reset to reset
	#10 x=0;						//From reset to run
	#10 x=0;						//From run to run
	#10 x=1;						//From run to shift
	#10 x=1;						//From shift to shift
	#10 x=0;						//From shift to update
	#10 x=0;						//From update to run
	#40;
end
always #5 clk <= ~clk;

endmodule