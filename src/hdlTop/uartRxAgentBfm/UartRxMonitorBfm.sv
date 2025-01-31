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
  //UartRxMonitorProxy uartRxMonitorProxy;
   

  //-------------------------------------------------------
  // Used to display the name of the interface
  //-------------------------------------------------------
  initial begin
    `uvm_info(name, $sformatf(name),UVM_LOW)
  end

  //------------------------------------------------------------------
  // Task: Baud_div
  // this task will calculate the baud divider based on sys clk frequency
  //-------------------------------------------------------------------
	
 //  task Baud_div(input overSampling, input baudRate);
	  
	// baudDivider = (FREQUENCY *1000000000) / (overSampling * baudRate);    
	  
 //  endtask: Baud_div
 
 //  initial begin 
	  
	//   Baud_div(agtcfg.overSampling, agtcfg.baudRate);   // variables yet to be added in the agent
	  
 //    forever begin
	//     @(posedge clk or negedge clk) begin
 //        	if (counter == baudDivider - 1) begin
 //            		bclk <= ~bclk;   // Toggle bclk when counter reaches baudDivider
 //            		counter <= 0;    // Reset the counter
 //        	end else begin
 //            		counter <= counter + 1;  // Increment the counter
 //        	end
 //    	    end
 //    	end
 //   end

  
  //-------------------------------------------------------
  // Task: WaitForReset
  //  Waiting for the system reset
  //-------------------------------------------------------

  task WaitForReset();
    @(negedge reset)
    `uvm_info(name, $sformatf("system reset detected"), UVM_HIGH)
    
    @(posedge reset);
    `uvm_info(name, $sformatf("system reset deactivated"), UVM_HIGH)
  endtask: WaitForReset

  //-------------------------------------------------------
  // Task: BreakIndicator
  //  Set break error if data input (UARTn_RXD) was held low for longer than a full-word transmission time
  //-------------------------------------------------------

   task BreakIndicator(inout UartRxPacketStruct uartRxPacketStruct, input UartConfigStruct uartConfigStruct);
    time StartTime, StopTime;
    time BitTransmissionTime;
    time WordTransmissionTime;
    time Breakstart, BreakStop;
     
    @(posedge clk) begin
      @(negedge rx) begin
        StartTime = $time;
        @(posedge clk.triggered) begin
	  StopTime = $time;
	end
      end
    end

    BitTransmissionTime = StartTime - StopTime;
    WordTransmissionTime = 64 * BitTransmissionTime;

    forever begin
      @(posedge clk) begin
	if (rx == 0) begin
	  if(BreakStart == BreakStop)
	    BreakStart = $time;
	  else 
	    BreakStop = $time;
	end
	else begin
	  BreakStop = 0;
	  BreakStop = 0;
	end
      end

    forever begin
      @(posedge clk) begin
	if((BreakStop - BreakStart) > WordTransmission)
	  BreakError = 1;   // < GIVE FIELD LOCATION>
	else
	  BreakError = 0;   // < GIVE FIELD LOCATION>
      end
    end
  endtask
			
	
endinterface : UartRxMonitorBfm
