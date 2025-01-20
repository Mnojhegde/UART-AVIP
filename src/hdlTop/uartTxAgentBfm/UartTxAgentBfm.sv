//--------------------------------------------------------------------------------------------
// Module      : UART Transmitter Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module UartTxAgentBfm(UartIf uartIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("uart transmitter agent bfm",$sformatf("UART TRANSMITTER AGENT BFM"),UVM_LOW);
  end
  
  //-------------------------------------------------------
  // Transmitter driver bfm instantiation
  //-------------------------------------------------------
  
  UartTxDriverBfm uartTxDriverBfm (.clk(intf.clk),
                                     .reset(intf.reset),
                                     .tx(intf.tx),
                                     .rx(intf.rx)
  );

  //-------------------------------------------------------
  // Transmitter monitor bfm instantiation
  //-------------------------------------------------------
  
 UartTxMonitorBfm uartTxMonitorBfm (.clk(intf.clk),
                                     .reset(intf.reset),
                                     .tx(intf.tx),
                                     .rx(intf.rx)
  );


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual UartTxDriverBfm)::set(null,"*","UartTxDriverBfm",uartTxDriverBfm);
    uvm_config_db#(virtual UartTxMonitorBfm)::set(null,"*","UartTxMonitorBfm",uartTxMonitorBfm);
  end

endmodule : UartTxAgentBfm
