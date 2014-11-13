/*
* Structural JK Flip-Flop using D Flip-Flop
* with active low asynch/synch resets and enable
*/

module StructJK(J,K,clk,reset,aReset,enable, Q,Qbar);

  input J, K, clk, reset, aReset, enable;
  output Q, Qbar;

  wire nK, top, bot, mid;

  //Combinational Logic

  and and1(top, J,Qbar);
  and and2(bot, ~K,Q);
  or or1(mid, top,bot);

  //D Flip Flop
  StructDff dff(mid,clk,aReset,reset,enable, Q,Qbar);

endmodule

