
//-------------------------------------------------------
// Importing Uart global package
//-------------------------------------------------------
import UartGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : UartRxDriverBfm
//  Used as the HDL driver for Uart
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------

interface UartRxDriverBfm (input  bit   clk,
                           input  bit   reset,
                           output  bit  rx
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

  string name = "UART_RECIEVER_DRIVER_BFM"; 
  
  //Creating the handle for the proxy_driver

  UartRxDriverProxy uartRxDriverProxy;
   

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

  //--------------------------------------------------------------------------------------------
  // Task: DeSerialization
  //  This task will convert the serial data obtained to parallel formate
  //--------------------------------------------------------------------------------------------

  task DeSerialization();

  endtask

  //--------------------------------------------------------------------------------------------
  // Task: ExtractDataFrame
  //  This task will discards the start bit, parity bit, and stop bit from the packet to extract the data frame
  //--------------------------------------------------------------------------------------------

  task ExtractDataFrame();

  endtask

endinterface : UartRxDriverBfm
