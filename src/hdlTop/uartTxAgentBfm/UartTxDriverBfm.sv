//-------------------------------------------------------
// Importing Uart global package
//-------------------------------------------------------
import UartGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : UartTxDriverBfm
//  Used as the HDL driver for Uart
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface UartTxDriverBfm (input  logic   clk,
                           input  logic   reset,
                           output logic   tx
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

  
   //Variable: bclk
  //baud clock for uart transmisson/reception	
  bit baudClk;
     
  //Variable: oversamplingClk
  // clk used to sample the data
  bit oversamplingClk;
  
  //Variable: count
  //to count the no of clock cycles
  int count=0;

  //Variable: baudDivisor
  //used to generate the baud clock
  int baudDivisor;

  //Variable: baudDivider
  //to count the no of baud clock cycles
  int countbClk = 0;	
  
  //Creating the handle for the proxy_driver
  UartTxDriverProxy uartTxDriverProxy;

  UartTransmitterStateEnum uartTransmitterState;
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
   task GenerateBaudClk(inout UartConfigStruct uartConfigStruct);
      real clkPeriodStartTime; 
      real clkPeriodStopTime;
      real clkPeriod;
      real clkFrequency;
      int baudDivisor;
      int count;

      @(posedge clk);
      clkPeriodStartTime = $realtime;
      @(posedge clk);
      clkPeriodStopTime = $realtime; 
      clkPeriod = clkPeriodStopTime - clkPeriodStartTime;
      clkFrequency = ( 10 **9 )/ clkPeriod;

      if(uartConfigStruct.OverSampledBaudFrequencyClk ==1)begin
       baudDivisor = (clkFrequency)/(uartConfigStruct.uartOverSamplingMethod * uartConfigStruct.uartBaudRate); 
      end 
      else begin 
        baudDivisor = (clkFrequency)/(uartConfigStruct.uartBaudRate);
      end 
        
     BaudClkGenerator(baudDivisor);

    endtask


  //------------------------------------------------------------------
  // this block will generate baud clk based on baud divider
  //-------------------------------------------------------------------
    task BaudClkGenerator(input int baudDivisor);
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

	     
  //-------------------------------------------------------
  // Task: WaitForReset
  //  Waiting for the system reset
  //-------------------------------------------------------
  task WaitForReset();
	  @(negedge reset);
	  `uvm_info(name,$sformatf("RESET DETECTED"),UVM_LOW);
	  uartTransmitterState = RESET;
	  tx = 1; //DRIVE THE UART TO IDEAL STATE
	  @(posedge reset);
	  `uvm_info(name,$sformatf("RESET DEASSERTED"),UVM_LOW);
  endtask: WaitForReset
  
  //--------------------------------------------------------------------------------------------
  // Task: DriveToBfm
  //  This task will drive the data from bfm to proxy using converters
  //--------------------------------------------------------------------------------------------

  task DriveToBfm(inout UartTxPacketStruct uartTxPacketStruct , inout UartConfigStruct uartConfigStruct);
	fork
		BclkCounter(uartConfigStruct.uartOverSamplingMethod);
		SampleData(uartTxPacketStruct , uartConfigStruct);
	join_any
	disable fork;	
  endtask: DriveToBfm
 
  //--------------------------------------------------------------------------------------------
  //  This block will count the number of cycles of bclk and generate oversamplingClk to sample data
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
  
  //--------------------------------------------------------------------------------------------
  // Task: sample_data
  //  This task will send the data to the uart interface based on oversamplingClk
  //--------------------------------------------------------------------------------------------
task SampleData(inout UartTxPacketStruct uartTxPacketStruct , inout UartConfigStruct uartConfigStruct);
		@(posedge oversamplingClk);
		tx = START_BIT;
		uartTransmitterState = STARTBIT;
		for( int i=0 ; i< uartConfigStruct.uartDataType ; i++) begin
			@(posedge oversamplingClk)
				tx = uartTxPacketStruct.transmissionData[i];
				uartTransmitterState = DATABITTRANSFER;

		end
		if(uartConfigStruct.uartParityEnable ==1) begin 
		  uartTransmitterState=PARITYBIT;
			if(uartConfigStruct.uartParityErrorInjection==0) begin 
				if(uartConfigStruct.uartParityType == EVEN_PARITY)begin
					@(posedge oversamplingClk)
					case(uartConfigStruct.uartDataType)
						FIVE_BIT: tx = ^(uartTxPacketStruct.transmissionData[4:0]);
						SIX_BIT :tx = ^(uartTxPacketStruct.transmissionData[5:0]);
						SEVEN_BIT: tx = ^(uartTxPacketStruct.transmissionData[6:0]);
						EIGHT_BIT : tx = ^(uartTxPacketStruct.transmissionData[7:0]);
					endcase  
				end
				else if (uartConfigStruct.uartParityType == ODD_PARITY) begin 
				@(posedge oversamplingClk)
					case(uartConfigStruct.uartDataType)
						FIVE_BIT: tx = ~^(uartTxPacketStruct.transmissionData[4:0]);
						SIX_BIT :tx = ~^(uartTxPacketStruct.transmissionData[5:0]);
						SEVEN_BIT: tx = ~^(uartTxPacketStruct.transmissionData[6:0]);
						EIGHT_BIT : tx = ~^(uartTxPacketStruct.transmissionData[7:0]);
					endcase  
				end 
			end
			else begin 
			if(uartConfigStruct.uartParityType == EVEN_PARITY)begin
			@(posedge oversamplingClk)
			case(uartConfigStruct.uartDataType)
				FIVE_BIT: tx = ~^(uartTxPacketStruct.transmissionData[4:0]);
				SIX_BIT :tx = ~^(uartTxPacketStruct.transmissionData[5:0]);
				SEVEN_BIT: tx = ~^(uartTxPacketStruct.transmissionData[6:0]);
				EIGHT_BIT : tx = ~^(uartTxPacketStruct.transmissionData[7:0]);
			endcase	 
			end 
			else if(uartConfigStruct.uartParityType == ODD_PARITY) begin
			@(posedge oversamplingClk)
			case(uartConfigStruct.uartDataType)
				FIVE_BIT: tx = ^(uartTxPacketStruct.transmissionData[4:0]);
				SIX_BIT :tx = ^(uartTxPacketStruct.transmissionData[5:0]);
				SEVEN_BIT: tx = ^(uartTxPacketStruct.transmissionData[6:0]);
				EIGHT_BIT : tx = ^(uartTxPacketStruct.transmissionData[7:0]);
			endcase 
			end 
		end 
	end 
	@(posedge oversamplingClk)
		tx = STOP_BIT;  
		uartTransmitterState = STOPBIT;
endtask 
endinterface : UartTxDriverBfm
