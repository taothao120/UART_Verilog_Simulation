module tx_test;
  reg clk, reset, tx_start;
  reg [7:0] data_in;
  wire txd, tx_done;
  
  uart_tx UT(clk, reset, tx_start, data_in, txd, tx_done); // instantiation
  
  initial begin
    clk = 0;
    reset = 1; // if
    #11 reset = 0;//else
    #40 tx_start = 1;
    $display($time, "start process");
    data_in = 8'haa; //1010_1010
    #5000 tx_start = 0;
    #500000 $stop;
    
  end
  always #10 clk = ~clk; // T = 20ns, f =50Mhz
  
  initial begin
    $dumpfile("dum.vcd"); // waveform generation
    $dumpvars(2, tx_test);
  end
  
endmodule