module miter(start,reset,clk, out);
  
  input start, reset, clk;
  output out;
  
  wire [3:0] count1, count2;

  counter(count1,start,reset,clk);
  gatecount(count2,start,reset,clk);
  
  xor x1(xout1, count1,count2);
  xor x2(xout2, count1,count2);
  or o1(out, xout1,xout2);

endmodule
