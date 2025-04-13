module rx_test;
  reg clk, reset, rxd;
  wire rx_done;
  wire [7:0]data_out;
  
  uart_rx UR(clk,reset, rxd, rx_done, data_out, tick);
  
  always #10 clk = ~clk; //t =20ns, f=50Mhz;
  
  initial begin 
    clk = 0;
    reset = 1; //if
    #11 reset = 0; //else
    #20 rxd = 0; // start bit
    $display($time, "start process");
    
    rdata(1);
    $display($time, "rdata 1");
    rdata(0);
    $display($time, "rdata 2");
    rdata(1);
    $display($time, "rdata 3");
    rdata(0);
    $display($time, "rdata 4");
    rdata(1);
    $display($time, "rdata 5");
    rdata(0);
    $display($time, "rdata 6");
    rdata(1);
    $display($time, "rdata 7");
    rdata(0);
    $display($time, "rdata 8");
    rdata(1);
    $display($time, "stop bit");
    
    #100000 $stop;
    
  end
  
  task rdata;
    input inp;
    begin 
      @(posedge tick)
        begin
         rxd = inp;
         $display($time, "supply data");
        end
    end 
  endtask
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(2,rx_test);
  end
  
endmodule
    