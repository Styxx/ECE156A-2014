
module counter ( count, start, reset, clk );
  output [3:0] count;
  input start, reset, clk;
  wire   n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22;

  FD2 \count_reg[0]  ( .D(n16), .CP(clk), .CD(n15), .Q(count[0]), .QN(n11) );
  FD2 \count_reg[2]  ( .D(n14), .CP(clk), .CD(n15), .Q(count[2]), .QN(n10) );
  FD2 \count_reg[1]  ( .D(n13), .CP(clk), .CD(n15), .Q(count[1]), .QN(n8) );
  FD2 \count_reg[3]  ( .D(n12), .CP(clk), .CD(n15), .Q(count[3]), .QN(n9) );
  MUX21L U15 ( .A(n17), .B(n11), .S(start), .Z(n16) );
  AO7 U16 ( .A(n8), .B(n18), .C(n11), .Z(n17) );
  IV U17 ( .A(reset), .Z(n15) );
  EN U18 ( .A(n19), .B(n10), .Z(n14) );
  MUX21L U19 ( .A(n20), .B(n21), .S(n8), .Z(n13) );
  OR2 U20 ( .A(n11), .B(start), .Z(n21) );
  AO6 U21 ( .A(n11), .B(n18), .C(start), .Z(n20) );
  ND2 U22 ( .A(n9), .B(n10), .Z(n18) );
  EO U23 ( .A(n22), .B(n9), .Z(n12) );
  ND2 U24 ( .A(n19), .B(count[2]), .Z(n22) );
  NR3 U25 ( .A(start), .B(n8), .C(n11), .Z(n19) );
endmodule

