/*
* Behavioral JK Flip-Flop using D Flip-Flop
* with active low asynch/synch resets and enable
*/

module BehavJK(J,K,clk,reset,aReset,enable, Q,Qbar);
  input J,K,clk,reset,aReset,enable;
  wire D;
  output Q,Qbar;
 
    assign D = ((J && Qbar)||(~K && Q));		//Combinational Logic
    BehavDff dff(D,clk,reset,aReset,enable,Q,Qbar);	//D Flip-Flop

endmodule
