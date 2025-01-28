`ifndef UARTRXASSERTIONS_INCLUDED_
`define UARTRXASSERTIONS_INCLUDED_

import UartGlobalPkg :: *;

interface UartRxAssertions ( input bit uartClk , input logic uartRx);
  import uvm_pkg :: *;
  `include "uvm_macros.svh"
  int localWidth = 0;
  bit uartParityEnabled = PARITY_ENABLED;
  bit uartStopDetectInitiation = 0;
  bit uartStartDetectInitiation = 1;
  bit uartDataWidthDetectInitiation = 0;
  bit uartEvenParityDetectionInitiation = 0;
  bit uartOddParityDetectionInitiation = 0;
  PARITY_TYPE uartEvenOddParity = EVEN_PARITY;
  bit [DATA_WIDTH-1 :0]uartLocalData;

  always@(posedge uartClk) begin 
    if(!(uartStartDetectInitiation))begin 
      localWidth++;
      uartLocalData = {uartLocalData,uartRx};
      if(localWidth == DATA_WIDTH)begin 
        if(uartParityEnabled == 1)begin 
          if(uartEvenOddParity == EVEN_PARITY)begin
            uartEvenParityDetectionInitiation = 1;
            uartOddParityDetectionInitiation = 0;
          end 
          else begin 
            uartEvenParityDetectionInitiation = 0;
            uartOddParityDetectionInitiation = 1;
          end 
          uartDataWidthDetectInitiation = 1;
          repeat(1)@(posedge uartClk);
          uartStopDetectInitiation = 1;
        end 
        else begin 
          uartDataWidthDetectInitiation = 1;
          uartStopDetectInitiation = 1;
        end 
      end 
    end 
  end 

  property start_bit_detection_property;
    @(posedge  uartClk) disable iff(!(uartStartDetectInitiation))
    (!($isunknown(uartRx)) && uartRx) |=> $fell(uartRx);
  endproperty

  IF_THERE_IS_FALLINGEDGE_ASSERTION_PASS: assert property (start_bit_detection_property)begin 
    $info("START BIT DETECTED : ASSERTION PASS");
    uartStartDetectInitiation = 0;
    end 
    else
      $error("FAILED TO DETECT STOP BIT : ASSERTION FAILED");
    
  property data_width_check_property;
    @(posedge uartClk) disable iff(!(uartDataWidthDetectInitiation))
    ##1 localWidth == DATA_WIDTH;
  endproperty 

  CHECK_FOR_DATA_WIDTH_LENGTH : assert property (data_width_check_property)begin 
    $info("DATA WIDTH IS MATCHING : ASSERTION PASS ");
    uartDataWidthDetectInitiation = 0;
    end 
    else 
      $error("DATA WIDTH MATCH FAILED : ASSERTION FAILED ");

  property even_parity_check;
    @(posedge uartClk) disable iff(!(uartEvenParityDetectionInitiation))
    ##1 uartRx == ^(uartLocalData);
  endproperty 
    
  CHECK_FOR_EVEN_PARITY : assert property (even_parity_check)begin 
    $info("EVEN PARITY IS DETECTED : ASSERTION PASS ");
    uartEvenParityDetectionInitiation = 0;
    end 
    else 
      $error("EVEN PARITY NOT DETECTED : ASSERTION FAIL ");

  property odd_parity_check;
    @(posedge uartClk) disable iff(!(uartOddParityDetectionInitiation))
    ##1 !uartRx == ^(uartLocalData);
  endproperty 
    
  CHECK_FOR_ODD_PARITY : assert property (odd_parity_check)begin 
    $info("ODD PARITY IS DETECTED : ASSERTION PASS ");
    uartOddParityDetectionInitiation = 0;
    end 
    else 
      $error("Odd PARITY NOT DETECTED : ASSERTION FAIL ");
 
  property stop_bit_detection_property;
    @(posedge uartClk) disable iff (!(uartStopDetectInitiation))
    ##1 ($rose(uartRx) || $stable(uartRx));
  endproperty

  CHECK_FOR_STOP_BIT : assert property(stop_bit_detection_property)begin 
    $info("STOP BIT IS BEING DETECTED : ASSERTION PASS ");
    uartStopDetectInitiation = 0;
    uartStartDetectInitiation = 1;
    end 
    else
      $error(" FAILED TO DETECT STOP BIT : ASSERTION FAIL ");
    
endinterface : UartRxAssertions

`endif
  
