module ctrlTB;
  reg clk, data_in;
  reg reset, run, shift, update;
  wire data_out;
  wire [4:0] z; 
  
  control_unit ctrl(clk, data_in, reset, run, shift, update, data_out, z);  

  initial begin
      clk = 1;
      data_in = 1;
      reset = 0;
      run = 0;
      shift = 0;
      update = 0;
	  
      #30 reset = 1;
      #10 reset = 0;
	  
      run = 1;
      #10 run = 0;
	  
	  // 0011 1011
	  shift = 1;
      #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1;
      #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1;
      #10 shift = 0;
	  update = 1;
      #10 update = 0;
	  run = 1;
      #10 run = 0;
     
	  data_in = 0;
      shift = 1;
      #10 shift = 0;
	  update = 1;
      #10 update = 0;
	  run = 1;
      #10 run = 0;
      
	  // 1011 0000
	  data_in = 0;
      shift = 1;
      #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
      #10 shift = 0;
	  update = 1;
      #10 update = 0;
	  run = 1;
      #10 run = 0;
      
	  // 0000 0010
	  shift = 1;
      data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
	  #10 data_in = 1; #10 data_in = 0;
      #10 shift = 0;
	  update = 1;
      #10 update = 0;
	  run = 1;
      #10 run = 0;
      
	  // 0010 0101
	  shift = 1;
      data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
      #10 shift = 0;
	  update = 1;
      #10 update = 0;
	  run = 1;
      #10 run = 0;
      
	  // 1000 0001
	  shift = 1;
      data_in = 1; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
	  #10 data_in = 0; #10 data_in = 0; #10 data_in = 1;
      #10 shift = 0;
	  update = 1;
      #10 update = 0;
	  run = 1;
      #10 run = 0;
      
	  reset = 1;
      #10 reset = 0;
      
	  // 0000 0101
	  shift = 1;
      data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
      #10 shift = 0;
    end
  always #5 clk < =  ~clk;
  
endmodule