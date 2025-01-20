
`ifndef UARTRXAGENT_INCLUDED_
`define UARTRXAGENT_INCLUDED_

class UartRxAgent extends uvm_component;
  `uvm_component_utils(UartRxAgent)
  
  UartRxAgentConfig uartRxAgentConfig;
  UartRxDriverProxy uartRxDriverProxy;
 // UartRxMonitorProxy uartRxMonitorProxy;
  //UartRxCoverage uartRxCoverage;
  UartRXSequencer uartRxSequencer;
  uvm_analysis_port #(UartRxTransaction) uartRxAgentAnalysisPort;

  extern function void new( string name = "UartRxAgent");
  extern virtual function build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phasee phase);

endclass : UartRxAgent

function void UartRxAgent :: new( string name = "UartRxAgent" , uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void UartRxAgent :: build_phase( uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(UartRxAgentConfig) :: get(this , "", "uartRxAgentConfig",uartRxAgentConfig)))
    `uvm_fatal(get_type_name(),$sformatf("FAILED TO OBTAIN AGENT CONFIG"))

  //uartRxMonitorProxy = UartRxMonitorProxy :: type_id :: create("uartRxMonitorProxy",this);
  if(uartRxAgentConfig.is_active == UVM_ACTIVE)
   begin 
     uartRxDriverProxy = UartRxDriverProxy :: type_id :: create("uartRxDriverProxy",this);
     uartRxSequencer = UartRxSequencer :: type_id :: create("uartRxSequencer",this);
   end 
  
  if(uartRxAgentConfig.hascoverage == 1)
    //uartRxCoverage = UartRxCoverage :: type_id :: create("uartRxCoverage",this);

  uartRxAgentAnalysisPort = new("uartRxAgentAnalysisPort",this);
endfunction : build_phase

function void UartRxAgent :: connect_phase( uvm_phase phase);
  super.connect_phase(phase);
  if(uartRxAgentConfig.is_active==UVM_ACTIVE)
   begin 
     uartRxDriverProxy.seq_item_port.connect(UartRxSequencer.seq_item_export);
   end
  if(uartRxAgentConfig.hascoverage == 1)
   begin 
     //uartRxMonitorProxy.uartRxMonitorAnalysisPort.connect(uartRxCoverage.uartRxCoverageAnalysisExport);
   end 
  //uartRxMonitorProxy.uartRxMonitorAnalysisPort.connect(uartRxAgentAnalysisPort);
endfunction : connect_phase

`endif
