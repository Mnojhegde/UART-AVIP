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
                           output  bit   tx
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

  //Variable: freq 
  //to calculate the frequency of system clk
  int freq =0;
  
   //Variable: bclk
  //baud clock for uart transmisson/reception
  bit bclk;
   
   //Variable: baud_rate
  //Used to sample the uart data
  reg[31:0] baud_rate = 9600;
  
   //Variable: baud_rate
  // Counter to keep track of clock cycles
  reg [15:0] counter;  
  
   //Variable: baud_divider
  //to Calculate baud rate divider
  reg [15:0] baud_divider;
  
   //Variable: count
  //to count no of cycles
  int count;
  
  //Creating the handle for the proxy_driver

  UartTxDriverProxy uartTxDriverProxy;
   

  //-------------------------------------------------------
  // Used to display the name of the interface
  //-------------------------------------------------------
  initial begin
    `uvm_info(name, $sformatf(name),UVM_LOW)
  end
  

  //-------------------------------------------------------
  // Task: bclk_gen
  // this task will generate the bclk from system clk
  //-------------------------------------------------------
  task bclk_gen(input clk);
   		realtime time_start, time_end, period;
        time_start = $realtime;
		@(negedge clk) 
          count=count+1;
     	if(count==1)
          time_end = $realtime;
            
		period = (time_end - time_start);
    freq = (1 / period *1000000000); // Convert to ns
    
    baud_divider = freq / (16 * baud_rate);    //16x sampling
  endtask: bclk_gen
 
 
  initial begin 
    forever begin
    @(posedge clk) begin
        if (counter == baud_divider - 1) begin
            bclk <= ~bclk;   // Toggle bclk when counter reaches baud_divider
            counter <= 0;    // Reset the counter
        end else begin
            counter <= counter + 1;  // Increment the counter
        end
    end
    end
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
   // @(posedge bclk)

  endtask: DriveToBfm

endinterface : UartTxDriverBfm
