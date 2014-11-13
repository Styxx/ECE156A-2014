/*
*  Miter for Up Counter + Decoder block
*/


module CountDecoderMiter(full_out, start,a_reset,s_reset,clk);

  input start, a_reset, s_reset, clk;
  output full_out;

  wire gate_out, behav_out;

  //(out, start,a_reset,s_reset,clk);
  StructCountDecode gate(gate_out, start, a_reset, s_reset, clk);
  BehavCountDecode behav(behav_out, start, a_reset, s_reset, clk);

  xor xTop(t1, gate_out, behav_out);
  xor xBot(b1, gate_out, behav_out);

  or or1(full_out, t1,b1);

endmodule