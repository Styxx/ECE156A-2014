module countertb;

  reg reset, start, clk;
  reg [3:0] count;
  
  counter count(count, start, reset, clk);
  
  initial begin
    clk = 0;
    start = 1;
	
  	reset = 1;
    #10; reset = 0;
	
    #120;
  end
  
  always #5 clk <= ~clk;

endmodule