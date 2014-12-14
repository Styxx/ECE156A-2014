module control_unit (clk,data_in,reset,run,shift,update, data_out,z);
  // Define the codes for the operations:
  `define INITLZ_MEM 2'b00
  `define ARITH 2'b01
  `define LOGIC 2'b10
  `define BUFFER 2'b11
  
  // I/O definitions:
  input clk, data_in;								//The clock and the serial input
  input reset, run, shift, update;					//Signals from the FSM
  output data_out;									//Data shifted out bit by bit.
  output [4:0] z;									//Internal
  memory:	reg [3:0] mem [3:0];
  
  /*
  *	Variables for the internal shift register and the shadow_reg:
  *	bits [7:6] = opcode (INITLZ_MEM, ARITH, LOGIC, BUFFER)
  * bits [5:4] = address in the memory when opcode=INITLZ_MEM
  * 0/1 for addition/subtraction when opcode=ARITH
  * 0/1 for AND/OR when opcode = LOGIC
  * bits [3:0] = data to the mem when opcode = INITLZ_MEM
  * = the addresses of the data in the mem when opcode = ARITH or LOGIC
  * bits [4:0] = data sent out to the output when opcode = BUFFER
  */
  reg [7:0] shift_reg, shadow_reg;

  //Extra variable definitions:
  wire data_out;
  reg [4:0] z;
  reg [1:0] address;
  reg [1:0] addressA, addressB;
  
  // Inputs: reset, run, shift, update (mutually exclusive)
  // Input: data_in
  always @ (posedge clk)
  	//When "reset" is activated, the memory unit and the internal registers are reset.
  	if (reset) begin
  		shift_reg = 7'b0000000;
  		shadow_reg = 7'b0000000;
  		mem = 0;										//Figure out syntax for memory unit
  	end
  	//At the "shift" state, data from "data_in" is shifted into the shift register.
  	else if (shift) begin
  		shift_reg[6] = shift_reg[5];
  		shift_reg[5] = shift_reg[4];
  		shift_reg[4] = shift_reg[3];
  		shift_reg[3] = shift_reg[2];
  		shift_reg[2] = shift_reg[1];
  		shift_reg[1] = shift_reg[0];
  		shift_reg[0] = data_in;
  	end
  	//At "update", shadow register gets content of shift register
  	else if (update) begin
  		shadow_reg[6] = shift_reg[6];
  		shadow_reg[5] = shift_reg[5];
  		shadow_reg[4] = shift_reg[4];
  		shadow_reg[3] = shift_reg[3];
  		shadow_reg[2] = shift_reg[2];
  		shadow_reg[1] = shift_reg[1];
  		shadow_reg[0] = shift_reg[0];
  	end
  	//During "run", the stable contents of the shadow register tell the control unit
  	//or memory unit what to do.
  	else if (run) begin
  	
  	end
  
  
  








endmodule
