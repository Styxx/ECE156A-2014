module control_unit (clk, data_in, reset, run, shift, update, data_out, z);
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
  
  








endmodule
