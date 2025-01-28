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

  
   //Variable: bclk
  //baud clock for uart transmisson/reception
	
  bit baudClk;
   
   //Variable: baudRate
  //Used to sample the uart data
	
  // reg[31:0] baudRate = 9600; 

  
  //Variable: oversampling_clk
  // clk used to sample the data
	
  bit oversampling_clk;
  
  //Variable: counter
  // Counter to keep track of clock cycles
	
  reg [15:0] counter;  
  
  //Variable: baudDivider
  //to Calculate baud rate divider
	
  reg [15:0] baudDivider;
  
  
  //Creating the handle for the proxy_driver

  UartTxDriverProxy uartTxDriverProxy;
   
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
	  
    	`uvm_info(name,$sformatf("data_packet=\n%p",uartTxPacketStruct),UVM_HIGH);
    	`uvm_info(name,$sformatf("DRIVE TO BFM TASK"),UVM_HIGH);
    
	 bclk_counter(agtcfg.oversamplingmethod);   // configure in agt config
    
     	sample_data(uartTxPacketStruct);

  endtask: DriveToBfm
 
  //--------------------------------------------------------------------------------------------
  // Task: bclk_counter
  //  This task will count the number of cycles of bclk and generate oversampling_clk to sample data
  //--------------------------------------------------------------------------------------------

  task bclk_counter(input oversamplingmethod);
    static int countbclk = 0;
    forever begin
	@(posedge baudClk)
	if(countbclk == (oversamplingmethod/2)-1) begin
      		oversampling_clk = ~oversampling_clk;
      		countbclk=0;
      	end
      	else begin
      	countbclk = countbclk+1;
      end
   
    end
  endtask
  
  //--------------------------------------------------------------------------------------------
  // Task: sample_data
  //  This task will send the data to the uart interface based on oversampling_clk
  //--------------------------------------------------------------------------------------------
  
  task sample_data(inout UartTxPacketStruct uartTxPacketStruct);
     int total_transmission = $size(uartTxPacketStruct.transmissionData);
     //@(posedge oversampling_clk) 
    // tx = START_BIT;  //create enum
	  
     for(int transmission_number=0 ; transmission_number < total_transmission; transmission_number++)begin 
	for( int i=0 ; i< DATA_WIDTH ; i++) begin
      		@(posedge oversampling_clk or negedge oversampling_clk) begin
        		tx = uartTxPacketStruct.trasmissionData[transmission_number][i];
      	end
    end
  end
    //@(posedge oversampling_clk)
    //tx = STOP_BIT;  // create enum 
  endtask
	     
endinterface : UartTxDriverBfm
