/*
* Behavioral D Flip-Flop
* with active low asynch/synch resets and enable
*/

module BehavDff(D,clk,reset,aReset,enable, Q,Qbar);
  input D,clk,reset,aReset,enable;
  output Q,Qbar;
  
  reg Q, Qbar;

  always @ (posedge clk or aReset)	//No reset or enable b/c synch.
  if (~aReset) begin			//Asynch
    Q <= 0;
    Qbar <= 1;
  end else if (~reset) begin
    Q <= 0;
    Qbar <= 1;
  end else if (~enable) begin
    Q <= D;
    Qbar <= ~D;
  end
endmodule
