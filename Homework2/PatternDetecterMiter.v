module PatternDetecterMiter(z, clk,in,reset);
	input clk, in, reset;
	output z;

	wire state_out, register_out;

	machine_a State (state_out, clk, in, reset);
	machine_b Register(register_out, clk, in, reset);

	xor xTop (t1, state_out, register_out);
	xor xBot (b1, state_out, register_out);

	or or1(z, t1, b1);

endmodule
