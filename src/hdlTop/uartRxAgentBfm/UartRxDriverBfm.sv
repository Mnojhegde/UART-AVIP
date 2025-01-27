
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

  
  //Variable: bclk
  //baud clock for uart transmisson/reception
  bit bclk;
   
  //Variable: baudRate
  //Used to sample the uart data
	
  //reg[31:0] baudRate = 9600;
  
  //Variable: baudRate
  // Counter to keep track of clock cycles
  reg [15:0] counter;  
  
  //Variable: baudDivider
  //to Calculate baud rate divider
  reg [15:0] baudDivider;
  
  
  //Creating the handle for the proxy_driver
  UartRxDriverProxy uartRxDriverProxy;
   

  //-------------------------------------------------------
  // Used to display the name of the interface
  //-------------------------------------------------------
  initial begin
    `uvm_info(name, $sformatf(name),UVM_LOW)
  end

  
  //------------------------------------------------------------------
  // Task: bauddivCalculation
  // this task will calculate the baud divider based on sys clk frequency
  //-------------------------------------------------------------------
	
    task bauddivcalculation(input oversamplingmethod,input baudrate);
      real clkPeriodStartTime; 
      real clkPeriodStopTime;
      real clkPeriod;
      real clkFrequency;
      int baudDivisor;
      @(posedge clk);
      clkPeriodStartTime = $realtime;
      @(posedge clk);
      clkPeriodStopTime = $realtime; 
      clkPeriod = clkPeriodStopTime - clkPeriodStartTime;
      clkFrequency = ( 10 **9 )/ clkPeriod;

      baudDivisor = (clkFrequency)/(oversamplingmethod * baudrate); 

      baudclkgenerator(baudDivisor);
    endtask

  //------------------------------------------------------------------
  // Task: baudclkgenerator
  // this task will generate baud clk based on baud divider
  //-------------------------------------------------------------------

    task baudclkgenerator(input int baudDivisor);
      static int count=0;
      forever begin 
        @(posedge clk or negedge clk)
    
        if(count == (baudDivisor-1))begin 
          count <= 0;
          baudClk <= ~baudClk;
        end 
        else begin 
          count <= count +1;
        end   
      end
    endtask

  
 //  //-------------------------------------------------------
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
