//-------------------------------------------------------
// Importing Uart global package
//-------------------------------------------------------
import UartGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : UartTxDriverBfm
//  Used as the HDL driver for Uart
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------

interface UartTxDriverBfm (input  bit   clk,
                           input  bit   reset,
                           input  bit   tx,
                           input  bit   rx,
                           );

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import UartTxPkg::*;
  
  //Variable: name
  //Used to store the name of the interface

  string name = "UART_TRANSMITTER_DRIVER_BFM"; 
  
  //Creating the handle for the proxy_driver

  UartTxDriverProxy uartTxDriverProxy;
   

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
  
  //--------------------------------------------------------------------------------------------
  // Task: DriveToBfm
  //  This task will drive the data from bfm to proxy using converters
  //--------------------------------------------------------------------------------------------

  task DriveToBfm();
    

  endtask: DriveToBfm

endinterface : UartTxDriverBfm

