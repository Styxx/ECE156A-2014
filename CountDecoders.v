/*
*  Behavioral and Structual Up Counter + Decoder Blocks
*/


module BehavCountDecode(out, start,a_reset,s_reset,clk);

  input start,a_reset,s_reset,clk;
  output [6:0] out;

  reg [6:0] out;
  wire [3:0] connector;
  
  BehavUpCnt counter(connector, start,a_reset,s_reset,clk);
  BehavBCDto7 decoder(out, connector);

endmodule





module StructCountDecode(out, start,a_reset,s_reset,clk);

  input start, a_reset,s_reset,clk;
  output [6:0] out;

  wire [3:0] connector;

  upcnt counter(connector, start,a_reset,s_reset,clk);
  bcdto7 decoder(out, connector);

endmodule