`ifndef UARTRXCOVERAGE_INCLUDED_
`define UARTRXCOVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: UartRxCoverage
//  This class is used to include covergroups and bins required for functional coverage
//--------------------------------------------------------------------------------------------
class UartRxCoverage extends uvm_subscriber #(UartRxTransaction);
  `uvm_component_utils(UartRxCoverage)

  //Variable: uartRxAgentConfig;
  //Handle for uart recevier agent configuration
  UartRxAgentConfig uartRxAgentConfig;
  
  //-------------------------------------------------------
  // Covergroup : UartRxCovergroup 
  //  Covergroup consists of the various coverpoints
  //  based on the number of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup UartRxCovergroup with function sample (UartRxAgentConfig uartRxAgentConfig, UartRxTransaction uartRxTransaction);
    RX_CP : coverpoint uartRxTransaction.receivingData{
      option.comment = "rx";
      bins UART_RX = {[1:$]};
    }

    // DATA_WIDTH_CP : coverpoint uartRxAgentConfig.data_type{
    //   option.comment = "data_width";
    //   bins TRANSFER_BIT_5 = {5};
    //   bins TRANSFER_BIT_6 = {6};
    //   bins TRANSFER_BIT_7 = {7};
    //   bins TRANSFER_BIT_8 = {8};
    // }

    // PARITY_CP : coverpoint uartRxAgentConfig.parity_type{
    //   option.comment = "parity_type";
    //   bins EVEN_PARITY = {0};
    //   bins ODD_PARITY = {1};
    // }

    // STOP_BIT_CP : coverpoint uartRxAgentConfig.stop_bit{
    //   option.comment = "stop bit width";
    //   bins STOP_BIT_1 = {1};
    //   bins STOP_BIT_2 = {2};
    // }

    // DATA_WIDTH_CP_PARITY_CP : cross DATA_WIDTH_CP,PARITY_CP;
    // DATA_WIDTH_CP_STOP_BIT_CP :cross DATA_WIDTH_CP,STOP_BIT_CP;
    
  endgroup: UartRxCovergroup

  
  //-------------------------------------------------------
  //Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "UartRxCoverage", uvm_component parent = null);
  extern function void write(UartRxTransaction t);
  extern virtual function void report_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
endclass : UartRxCoverage

//--------------------------------------------------------------------------------------------
// Construct: new
// 
// Parameters:
//  name -  UartRxCoverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function  UartRxCoverage::new(string name = "UartRxCoverage", uvm_component parent = null);
  super.new(name, parent);
  UartRxCovergroup = new();
endfunction : new

//---------------------------------------------------------------------------------------------------------
// Build Phase
//
//-------------------------------------------------------------------------------------------------------------
function void UartRxCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db #(UartRxAgentConfig) :: get(this,"","uartRxAgentConfig",uartRxAgentConfig)))
  `uvm_fatal("FATAL Rx AGENT CONFIG", $sformatf("Failed to get Rx agent config in coverage"))
endfunction : build_phase

    
//-------------------------------------------------------
// Function: write
//  Creates the write method
//
// Parameters:
//  t - UartRxTransaction handle
//-------------------------------------------------------
function void UartRxCoverage::write(UartRxTransaction t);
  `uvm_info(get_type_name(),$sformatf("Before calling SAMPLE METHOD"),UVM_HIGH);
  foreach(t.receivingData[i]) begin
    UartRxCovergroup.sample(uartRxAgentConfig,t);
  end
  `uvm_info(get_type_name(),"After calling SAMPLE METHOD",UVM_HIGH);

endfunction : write

//--------------------------------------------------------------------------------------------
// Function: report_phase
//  Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function void  UartRxCoverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("UART RX Agent Coverage = %0.2f %%",  UartRxCovergroup.get_coverage()), UVM_NONE);
endfunction: report_phase

`endif
