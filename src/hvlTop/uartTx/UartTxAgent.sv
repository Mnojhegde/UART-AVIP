`ifndef UARTTXAGENT_INCLUDED_
`define UARTTXAGENT_INCLUDED_

class UartTxAgent extends uvm_component;
  `uvm_component_utils(UartTxAgent)
  
  UartTxAgentConfig uartTxAgentConfig;
  UartTxDriverProxy uartTxDriverProxy;
  //UartTxMonitorProxy uartTxMonitorProxy;
  //UartTxCoverage uartTxCoverage;
  UartTXSequencer uartTxSequencer;
  uvm_analysis_port #(UartTxTransaction) uartTxAgentAnalysisPort;

  extern function void new( string name = "UartTxAgent");
  extern virtual function build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phasee phase);

endclass : UartTxAgent

function void UartTxAgent :: new( string name = "UartTxAgent" , uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void UartTxAgent :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(UartTxAgentConfig) :: get(this , "", "uartTxAgentConfig",uartTxAgentConfig)))
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO OBTAIN AGENT CONFIG"))

 // uartTxMonitorProxy = UartTxMonitorProxy :: type_id :: create("uartTxMonitorProxy",this);
  if(uartTxAgentConfig.is_active == UVM_ACTIVE)
   begin 
     uartTxDriverProxy = UartTxDriverProxy :: type_id :: create("uartTxDriverProxy",this);
     uartTxSequencer = UartTxSequencer :: type_id :: create("uartTxSequencer",this);
   end 
  
  if(uartTxAgentConfig.hascoverage == 1)
   //uartTxCoverage = UartTxCoverage :: type_id :: create("uartTxCoverage",this);

  uartTxAgentAnalysisPort = new("uartTxAgentAnalysisPort",this);
endfunction : build_phase

function void UartTxAgent :: connect_phase( uvm_phase phase);
  super.connect_phase(phase);
  if(uartTxAgentConfig.is_active==UVM_ACTIVE)
   begin 
     uartTxDriverProxy.seq_item_port.connect(UartTxSequencer.seq_item_export);
   end
  if(uartTxAgentConfig.hascoverage == 1)
    begin 
     // uartTxMonitorProxy.uartTxMonitorAnalysisPort.connect(uartTxCoverage.uartTxCoverageAnalysisExport);
    end 
 // uartTxMonitorProxy.uartTxMonitorAnalysisPort.connect(this.uartTxAgentAnalysisPort);
endfunction : connect_phase

`endif

