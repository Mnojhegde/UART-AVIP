
// Importing Uart global package
//-------------------------------------------------------
import UartGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : UartRxMonitorBfm
//  Connects the master monitor bfm with the master monitor prox
//--------------------------------------------------------------------------------------------

interface UartRxMonitorBfm (input  logic   clk,
                            input  logic reset,
                            input  logic   rx
                           );

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
	import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  //import UartRxPkg:: UartRxMonitorProxy;
  
  //Used to store the name of the interface
  string name = "UART_TRANSMITTER_MONITOR_BFM"; 

  //baud clock for uart transmisson/reception	
  bit baudClk;
  bit oversamplingClk;
   
   
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
  task GenerateBaudClk(inout UartConfigStruct uartConfigStruct);
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

      baudDivisor = (clkFrequency)/(uartConfigStruct.uartOverSamplingMethod * uartConfigStruct.uartBaudRate); 

      BaudClkGenerator(baudDivisor);
  endtask

  //------------------------------------------------------------------
  // Task: BaudClkGenerator
  // this task will generate baud clk based on baud divider
  //-------------------------------------------------------------------

	task BaudClkGenerator(input int baudDiv);
		static int count=0;
		forever begin 
			@(posedge clk or negedge clk)
			if(count == (baudDiv-1))begin 
				count <= 0;
				baudClk <= ~baudClk;
			end 
			else begin 
				count <= count +1;
			end   
		end
	endtask

  //--------------------------------------------------------------------------------------------
  // Task: bclk_counter
  //  This task will count the number of cycles of bclk and generate oversamplingClk to sample data
  //--------------------------------------------------------------------------------------------
  task BclkCounter(input int uartOverSamplingMethod);
    static int countbClk = 0;
    forever begin
			@(posedge baudClk)
			if(countbClk == (uartOverSamplingMethod/2)-1) begin
      	oversamplingClk = ~oversamplingClk;
      	countbClk=0;
      end
      else begin
      	countbClk = countbClk+1;
      end
    end
  endtask
	
  //-------------------------------------------------------
  // Task: WaitForReset
  //  Waiting for the system reset
  //-------------------------------------------------------
  task WaitForReset();
    @(negedge reset);
    `uvm_info(name, $sformatf("system reset activated"), UVM_LOW)
    @(posedge reset);
    `uvm_info(name, $sformatf("system reset deactivated"), UVM_LOW)
  endtask: WaitForReset

	task StartMonitoring(inout UartRxPacketStruct uartRxPacketStruct , inout UartConfigStruct uartConfigStruct);
  	fork 
     	BclkCounter(uartConfigStruct.uartOverSamplingMethod);
     	Deserializer(uartRxPacketStruct,uartConfigStruct);
   	join_any
   	disable fork ;
	endtask 

  //-------------------------------------------------------
  // Task: DeSerializer
  //  converts serial data to parallel
  //-------------------------------------------------------

  task Deserializer(inout UartRxPacketStruct uartRxPacketStruct, inout UartConfigStruct uartConfigStruct);
    	@(negedge rx);
      repeat(1) @(posedge oversamplingClk);//needs this posedge or 1 cycle delay to avoid race around or delay in output
      for( int i=0 ; i < uartConfigStruct.uartDataType ; i++) begin
     		@(posedge oversamplingClk) begin
	  			uartRxPacketStruct.receivingData[i] = rx;
      	end
    	end
    	if(uartConfigStruct.uartParityEnable ==1) begin   
	  		@(posedge oversamplingClk)
	    	uartRxPacketStruct.parity = rx;
    	end
    	@(posedge oversamplingClk);
  endtask
			

  //-------------------------------------------------------
  // Task: StopBitCheck
  // to check valid stop bit and framing error occurs when a received character does not have a valid STOP bit.
  //-------------------------------------------------------
  //task StopBitCheck (inout  UartRxPacketStruct uartRxPacketStruct,input bit rx,input int transmission_number);
 //		if (rx == 1) begin
  //			FramingError = 0;
  //			`uvm_info(name, $sformatf("Stop bit detected"), UVM_HIGH)
  //		end
  //		else begin
  //			FramingError = 1;
  //			`uvm_info(name, $sformatf("Stop bit not detected"), UVM_HIGH)
  //		end
  //endtask	
  //-------------------------------------------------------
  // Task: parityCheck
  //  The parityCheck task checks for parity errors in the transmitted data 
  //-------------------------------------------------------
  // task parityCheck(inout UartRxPacketStruct uartRxPacketStruct,input bit rx,input int transmission_number);
    
   // int cal_parity;
    
   //if(uartConfigStruct.uartParityType == EVEN_PARITY)begin
  //	cal_parity = ^uartRxPacketStruct.receivingData[transmission_number];
//      end
	
//	   else begin 
//	      cal_parity = ~^uartRxPacketStruct.receivingData[transmission_number];
 //       end 
 //   if(rx==cal_parity)
  //    begin
    //    parity_error==0;
     // end
     //else
      //begin
     // parity_error==1;
     // end
  // endtask:parityCheck
		
endinterface : UartRxMonitorBfm
