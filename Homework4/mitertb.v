module testbench;
  reg reset, start, clk;
  reg [3:0] out;
  
  miter miter1(start, reset, clk, out);
  
  initial begin
  
    clk = 0;
    start = 1;
  	reset = 1;
    #10; reset = 0;
    #120;
  end
  always #5 clk <= ~clk;
endmodule