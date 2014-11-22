/*
* Structural D Flip-Flop
* with active low asynch/synch resets and (synch) enable
* seemingly positive edge triggered
*/

module StructDff(D,clk,aReset,reset,enable, Q,Qbar);
  input D, clk, aReset, reset, enable;
  output Q, Qbar;

  wire sAndOut, tOut1,bOut1, firstOut,firstCon, tOut2,bOut2, preQ,preQbar;

  //Sync Reset
  and sAnd (sAndOut, D,reset);

  //Main Body - Master latch
  nand topNand1(tOut1, ~clk,sAndOut,~enable);
  nand botNand1(bOut1, ~clk,tOut1,~enable);
  nand topNand2(firstOut, tOut1,firstCon);
  nand botNand2(firstCon, bOut1,firstOut);

  //Slave latch
  nand topNand3(tOut2, clk,firstOut);
  nand botNand3(bOut2, clk,tOut2);
  nand topNand4(preQ, tOut2,preQbar);
  nand botNand4(preQbar, bOut2, preQ);

  //Async Reset
  and aAnd1(Q, preQ,aReset);
  not nQ(Qbar, Q);

endmodule
