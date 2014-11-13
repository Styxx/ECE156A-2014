/*
*  BCD to 7-segment decoder
*/


module bcdto7(all_out, d_in);
  input [3:0] d_in;
  output [6:0] all_out;
  wire [6:0] all_out;

  wire a1,a2,a3,a4,a5,a6,a7,a8,a9;

  and and1(a1, d_in[0],d_in[1]);		//ab
  and and2(a2, d_in[0],d_in[2]);		//ac
  and and3(a3, ~d_in[0],~d_in[2]);		//a'c'
  and and4(a4, ~d_in[0],~d_in[1]);		//a'b'
  and and5(a5, ~d_in[0],d_in[1]);		//a'b
  and and6(a6, d_in[1],~d_in[2]);		//bc'
  and and7(a7, ~d_in[0],d_in[2]);		//a'c
  and and8(a8, ~d_in[1],d_in[2]);		//b'c
  and and9(a9, d_in[0],~d_in[1],d_in[2]);	//ab'c

  or or1(all_out[0], a1,a2,a3,~d_in[2]);	//ab   + ac   + a'c' + c'
  or or2(all_out[1], a1,a4,~d_in[2]);		//ab   + a'b' + c'
  or or3(all_out[2], d_in[0],~d_in[1],d_in[2]);	//a    + b'   + c
  or or4(all_out[3], a3,a5,a6,a9);		//a'c' + a'b  + bc'  + ab'c
  or or5(all_out[4], a3,a5);			//a'c' + a'b
  or or6(all_out[5], a4,a7,a8,d_in[3]);		//a'b' + a'c  + b'c  + d
  or or7(all_out[6], a5,a6,a8,d_in[3]);		//a'b  + bc'  + b'c  + d

endmodule