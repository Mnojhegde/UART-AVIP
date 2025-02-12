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
  string name = "UART_TRANSMITTER_MONITOR_BFM";
  //Variable: bclk
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
      if(uartConfigStruct.OverSampledBaudFrequencyClk==1)begin
      baudDivisor = (clkFrequency)/(uartConfigStruct.uartOverSamplingMethod * uartConfigStruct.uartBaudRate);
      end
      else begin
      baudDivisor = (clkFrequency)/(uartConfigStruct.uartBaudRate);
      end
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
	  @(negedge rx);
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
        //BclkCounter(uartConfigStruct.uartOverSamplingMethod);
        fork
        BclkCounter(uartConfigStruct.uartOverSamplingMethod);
        Deserializer(uartRxPacketStruct,uartConfigStruct);
                join_any
         @(negedge oversamplingClk);
         disable fork ;
        endtask

function evenParityCompute(input UartConfigStruct uartConfigStruct,input UartRxPacketStruct uartRxPacketStruct);
  bit parity;
  case(uartConfigStruct.uartDataType)
    FIVE_BIT: parity = ^(uartRxPacketStruct.transmissionData[4:0]);
    SIX_BIT :parity = ^(uartRxPacketStruct.transmissionData[5:0]);
    SEVEN_BIT: parity = ^(uartRxPacketStruct.transmissionData[6:0]);
    EIGHT_BIT : parity = ^(uartRxPacketStruct.transmissionData[7:0]);
  endcase
return parity;
endfunction
function oddParityCompute(input UartConfigStruct uartConfigStruct,input UartRxPacketStruct uartRxPacketStruct);
  bit parity;
  case(uartConfigStruct.uartDataType)
      FIVE_BIT: parity = ~^(uartRxPacketStruct.transmissionData[4:0]);
      SIX_BIT :parity = ~^(uartRxPacketStruct.transmissionData[5:0]);
      SEVEN_BIT: parity = ~^(uartRxPacketStruct.transmissionData[6:0]);
      EIGHT_BIT : parity = ~^(uartRxPacketStruct.transmissionData[7:0]);
  endcase
return parity;
endfunction
  //-------------------------------------------------------
  // Task: DeSerializer
  //  converts serial data to parallel
  //-------------------------------------------------------
  task Deserializer(inout UartRxPacketStruct uartRxPacketStruct, inout UartConfigStruct uartConfigStruct);
	  @(negedge rx);
        if(uartConfigStruct.OverSampledBaudFrequencyClk==1)begin
        repeat(1) @(posedge oversamplingClk);//needs this posedge or 1 cycle delay to avoid race around or delay in output
        for( int i=0 ; i < uartConfigStruct.uartDataType ; i++) begin
                        @(posedge oversamplingClk) begin
				uartRxPacketStruct.transmissionData[i] = rx;
                end
        end
        if(uartConfigStruct.uartParityEnable ==1) begin
                                @(posedge oversamplingClk)
                                uartRxPacketStruct.parity = rx;
		parityCheck(uartConfigStruct,uartRxPacketStruct,rx);

        end
        @(posedge oversamplingClk);
		stopBitCheck(uartRxPacketStruct,rx);

        end
        else if(uartConfigStruct.OverSampledBaudFrequencyClk==0)begin
         repeat(1)@(posedge baudClk);
          for( int i=0 ; i < uartConfigStruct.uartDataType ; i++) begin
          @(posedge baudClk)begin
		  uartRxPacketStruct.transmissionData[i] = rx;
          end
         end
         if(uartConfigStruct.uartParityEnable ==1) begin
         @(posedge baudClk)
         uartRxPacketStruct.parity = rx;
		 parityCheck(uartConfigStruct,uartRxPacketStruct,rx);
         end
         @(posedge baudClk);
		stopBitCheck(uartRxPacketStruct,rx);
        end
        endtask
		 task stopBitCheck (inout  UartRxPacketStruct uartRxPacketStruct,input bit rx);
			 if (rx == 1) begin
                        uartRxPacketStruct.framingError = 0;
                        `uvm_info(name, $sformatf("???????????????????????????????????Stop bit detected"), UVM_LOW)
                end
                else begin
                        uartRxPacketStruct.framingError = 1;
                        `uvm_info(name, $sformatf("??????????????????????????????????????????????Stop bit not detected"), UVM_LOW)
                end
  endtask
		 task parityCheck(inout UartConfigStruct uartConfigStruct,inout UartRxPacketStruct uartRxPacketStruct,input bit rx);
   int cal_parity;
   if(uartConfigStruct.uartParityType == EVEN_PARITY)begin
           cal_parity = evenParityCompute(uartConfigStruct,uartRxPacketStruct);
     end
           else begin
           cal_parity = oddParityCompute(uartConfigStruct,uartRxPacketStruct);
       end
			 if(rx==cal_parity)begin
       uartRxPacketStruct.parityError=0;
     end
     else begin
     uartRxPacketStruct.parityError=1;
     end
  endtask:parityCheck
endinterface : UartRxMonitorBfm
