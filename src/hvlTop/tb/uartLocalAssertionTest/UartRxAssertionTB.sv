
`ifndef UARTRXASSERTIONTB_INCLUDED_
`define UARTRXASSERTIONTB_INCLUDED_

`include "uvm_macros.svh"
import uvm_pkg :: *;

module UartRxAssertionTb;
  logic Rx;
  bit clk = 0;

  always #5 clk = ~clk;
  initial begin 
    #80;
    $finish;
  end 

  UartRxAssertions uartRxAssertions(.uartClk(clk),.uartRx(Rx));
  
  initial begin 
    When_startBitisdetected_nextCycleDataTransferStarts_ThenStopBitDetected_AssertionPass();
  end 

  task  When_startBitisdetected_nextCycleDataTransferStarts_ThenStopBitDetected_AssertionPass();
    #4  Rx = 1;
    #10 Rx = 0;
    #10 Rx = 1;
    #10 Rx = 0;
    #10 Rx = 1;
    #10 Rx = 1;
    #10 Rx = 0;
    #10 Rx = 1 ;
  endtask 
endmodule 

`endif
