/*
* Structural 4-bit counter with D Flip-Flops
* with active low asynch/synch resets and enable
* Counts up from 0 to 15 and repeats
*/

module upcnt (count, start,a_reset,s_reset,clk);
  input start, a_reset, s_reset, clk;
  output [3:0] count;
  wire [3:0] count;

  wire x1,x2,x3,x4, a1,a2,a3;		  //Qbar goes unused.
  
  //FF1 - Least sig. bit.
  xor xor1(x1, ~start,count[0]);
  and and1(a1, ~start,count[0]);
  StructDff dff1(x1,clk,a_reset,s_reset,start, count[0],Qbar);

  //FF2
  xor xor2(x2, a1,count[1]);
  and and2(a2, a1,count[1]);  
  StructDff dff2(x2,clk,a_reset,s_reset,start, count[1],Qbar);

  //FF3
  xor xor3(x3, a2,count[2]);
  and and3(a3, a2,count[2]);
  StructDff dff3(x3,clk,a_reset,s_reset,start, count[2],Qbar);

  //FF4 - Most sig. bit.
  xor xor4(x4, a3,count[3]);
  and and4(a4, a3,count[3]);
  StructDff dff4(x4,clk,a_reset,s_reset,start, count[3],Qbar);
endmodule