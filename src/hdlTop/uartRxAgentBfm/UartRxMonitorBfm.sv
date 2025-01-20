//-------------------------------------------------------
// Importing Uart global package
//-------------------------------------------------------
import UartGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : UartRxMonitorBfm
//  Connects the master monitor bfm with the master monitor prox
//--------------------------------------------------------------------------------------------

interface UartRxMonitorBfm (input  bit   clk,
                            input  bit   reset,
                            input  bit   rx
                           );

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Importing the Reciever package file
  //-------------------------------------------------------
  import UartRxPkg::*;
  
  //Variable: name
  //Used to store the name of the interface

  string name = "UART_RECIEVER_MONITOR_BFM"; 
  
  //Creating the handle for the proxy_driver

  //UartRxMonitorProxy uartRxMonitorProxy;
   

  //-------------------------------------------------------
  // Used to display the name of the interface
  //-------------------------------------------------------
  initial begin
    `uvm_info(name, $sformatf(name),UVM_LOW)
  end
 
  //-------------------------------------------------------
  // Task: WaitForReset
  //  Waiting for the system reset
  //-------------------------------------------------------

  task WaitForReset();
    
  endtask: WaitForReset

  

endinterface : UartRxMonitorBfm
