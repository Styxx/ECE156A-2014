/*
*	Finite State Machine
*	Based off Ford Thunderbird template from 152A
*	Vincent "Styxx" Chang
*/


module fsm (clk, x, rs, reset, shift, update, run);
/*
  `define RS 4'b0001                      //Reset state
  `define RI 4'b0010                      //Run/Idle state
  `define SH 4'b0100                      //Shift state
  `define UP 4'b1000                      //Update state input
*/

  input clk;
  input x;                                //Signal that makes the FSM change state
  input rs;                               //Signal that initializes the FSM to RS
  output reset, shift, update, run;
  reg [3:0] state, next;

  parameter RS = 4'b0001                  //Reset state
  parameter RI = 4'b0010                  //Run/Idle state
  parameter SH = 4'b0100                  //Shift state
  parameter UP = 4'b1000                  //Update state input
  
  always @ (posedge clk) begin
    if(rs)
      state <= RS;
    else
      state <= next;
  end
  
  always @ (state or x or next) begin
    next = state;
    reset = 1;
    shift = 0;
    update = 0;
    run = 0;
    
    case (state)
    /*  
    *   Reset State
    *   Initializes the FSM and generates the "reset" signal to
    *   the control unit.
    */
    	RS:begin
    		reset = 1;
    		run = 0;
    		shift = 0;
    		update = 0;
    		if(!x)	next = RI;
    		else	next = RS;
    	end
    	/*
    	*   Run/Idle State
    	*   The operations given to the control unit are executed only in
    	*   this state, which is indicated by the "run" signal.
    	*/
    	RI:begin
    		reset = 0;
    		run = 1;
    		shift = 0;
    		update = 0;
    		if(!x)	next = RI;
    		else	next = SH;
    	end
    	/*
    	*   Shift State
    	*   When the FSM reaches this state, the control unit starts to shift
    	*   the instructions/operands to be executed from the input "data_in."
    	*/
    	SH:begin
    		reset = 0;
    		run = 0;
    		shift = 1;
    		update = 0;
    		if(!x)	next = UP;
    		else	next = SH;
    	end
    	/*
    	*   Update
    	*   Contents of shift register (instructions) are latched onto another
    	*   set of latches ("shadow" register), so that the instructions/operands
    	*   are already "stabilized" when executed. The contents are updated by
    	*   the "update" signal.
    	*/
    	UP:begin
    		reset = 0;
    		run = 0;
    		shift = 0;
    		update = 0;
    		if(!x)	next = RI;
    		else	next = RS;
    	end
    endcase
  end
  
endmodule
