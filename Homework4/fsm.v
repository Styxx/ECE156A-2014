module fsm (clk, x, rs, reset, shift, update, run);
  `define RS 4'b0001                  //Reset state
  `define RI 4'b0010                  //Run/Idle state
  `define SH 4'b0100                  //Shift state
  `define UP 4'b1000                  //Update state input
  
  input clk;
  input x;                            //Signal that makes the FSM change state
  input rs;                           //Signal that initializes the FSM to RS
  output reset, shift, update, run;
  reg [3:0] state, next_state;
  
  
  










endmodule
