//--------------------------------------------------------------------------------------------
// Module      : UART Reciever Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module UartRxAgentBfm(UartIf uartIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("uart transmitter agent bfm",$sformatf("UART TRANSMITTER AGENT BFM"),UVM_LOW);
  end
  
  //-------------------------------------------------------
  // Reciever driver bfm instantiation
  //-------------------------------------------------------
  
  UartRxDriverBfm UartRxDriverBfm (.clk(intf.clk),
                                     .reset(intf.reset),
                                     .tx(intf.tx),
                                     .rx(intf.rx)
  );

  //-------------------------------------------------------
  // Reciever monitor bfm instantiation
  //-------------------------------------------------------
  
 UartRxMonitorBfm UartRxMonitorBfm (.clk(intf.clk),
                                     .reset(intf.reset),
                                     .tx(intf.tx),
                                     .rx(intf.rx)
  );


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual UartRxDriverBfm)::set(null,"*","UartRxDriverBfm",UartRxDriverBfm);
    uvm_config_db#(virtual UartRxMonitorBfm)::set(null,"*","UartRxMonitorBfm",UartRxMonitorBfm);
  end

endmodule : UartRxAgentBfm
