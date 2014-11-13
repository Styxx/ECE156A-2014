/*
* Testbench
*/

module BehavBCDto7TB();

reg [3:0]d_in;
wire [6:0] all_out;

BehavBCDto7 bcd(all_out, d_in);

//setup
initial
begin
	d_in <= 4'b0000;
	#10 d_in <= 4'b0001;
	#20 d_in <= 4'b0010;
	#30 d_in <= 4'b0011;
	#40 d_in <= 4'b0100;
	#50 d_in <= 4'b0101;
	#60 d_in <= 4'b0110;
	#70 d_in <= 4'b0111;
	#80 d_in <= 4'b1000;
	#90 d_in <= 4'b1001;
	#100 d_in <= 4'b1010;
	#110 d_in <= 4'b1100;
	#120 d_in <= 4'b1101;
	#130 d_in <= 4'b1110;
	#140 d_in <= 4'b1111;
	#150 d_in <= 4'b0000;
	#160 d_in <= 4'b0001;

end
endmodule

/*
*  Behavioural BCD to 7-segment decoder
*  Signals are active low
*/


module BehavBCDto7(all_out, d_in);

  input [3:0] d_in;
  output [6:0] all_out;
  reg [6:0] all_out;

  // all_out format {g, f, e, d, c, b, a}
  always @(d_in)
    case (d_in)
      4'h0: all_out = 7'b1000000;
      4'h1: all_out = 7'b1111001;
      4'h2: all_out = 7'b0100100;
      4'h3: all_out = 7'b0110000;
      4'h4: all_out = 7'b0011001;
      4'h5: all_out = 7'b0010010;
      4'h6: all_out = 7'b0000010;
      4'h7: all_out = 7'b1111000;
      4'h8: all_out = 7'b0000000;
      4'h9: all_out = 7'b0010000;
      4'hA: all_out = 7'b0001000;
      4'hB: all_out = 7'b0000011;
      4'hC: all_out = 7'b1000110;
      4'hD: all_out = 7'b0100001;
      4'hE: all_out = 7'b0000110;
      4'hF: all_out = 7'b0001110;
      default: all_out = 7'b0110110;
    endcase

endmodule