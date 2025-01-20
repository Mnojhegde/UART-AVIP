`ifndef UARTBASETEST_INCLUDED_
`define UARTBASETEST_INCLUDED_

class UartBaseTest extends uvm_test;
 
  `uvm_component_utils(UartBaseTest)
 
  UartVirtualBaseSequence uartVirtualBaseSequence;
  UartEnvConfig           uartEnvConfig;
  UartEnv                 uartEnv;
 
  extern function new(string name = "UartBaseTest" , uvm_component parent = null);
  extern virtual function void  build_phase(uvm_phase phase);
  extern virtual function void  setupUartEnvConfig();
  extern virtual function void  setupUartTxAgentConfig();
  extern virtual function void  setupUartRxAgentConfig();
  extern virtual function void  end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : UartBaseTest

function UartBaseTest :: new(string name = "UartBaseTest" , uvm_component parent = null);
  super.new(name,parent);
endfunction  : new

virtual function void UartBaseTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  uartEnvConfig = UartEnvConfig :: type_id :: create("uartEnvConfig" , this);
  setupUartEnvConfig();
  uartEnv = uartEnv :: type_id :: create("uartEnv" , this);
endfunction  : build_phase

virtual function void UartBaseTest :: setupUartEnvConfig();
  uartEnvConfig = UartEnvConfig :: type_id :: create("uartEnvConfig");
  uartEnvConfig.hasscoreboard = 1;
  uartEnvConfig.hasvirtualsequencer = 1;
  uvm_config_db #(UartEnvConfig) :: set(this, * , "uartEnvConfig",uartEnvConfig);
  setupUartTxAgentConfig();
  setupUartRxAgentConfig();
endfunction : setupUartEnvConfig 

virtual function void UartBaseTest :: setupUartTxAgentConfig();
  uartEnvConfig.uartTxAgentConfig = UartTxAgentConfig :: type_id :: create("uartTxAgentConfig");
  uartEnvConfig.uartTxAgentConfig.is_active = UVM_ACTIVE;
  uartEnvConfig.uartTxAgentConfig.hascoverage = 1;
  uartEnvConfig.uartTxAgentConfig.hasparity = 1;
  uvm_config_db #(UartTxAgentConfig) :: set(this,*, "uartTxAgentConfig",uartEnvConfig.uartTxAgentConfig);

endfunction : setupUartTxAgentConfig

virtual function void UartBaseTest :: setupUartRxAgentConfig();
  uartEnvConfig.UartRxAgentConfig = UartRxAgentConfig :: type_id :: create("uartRxAgentConfig");
  uartEnvConfig.uartRXAgentConfig.is_active = UVM_PASSIVE;
  uartEnvConfig.uartRxAgentConfig.hascoverage = 1;
  uartEnvConfig.uartRxAgentConfig.hasparity = 1;
  uvm_config_db#(UartRxAgentConfig) :: set(this, * , "uartRxAgentConfig", uartEnvConfig.uartRxAgentConfig);

endfunction : setupUartRxAgentConfig

virtual function void UartBaseTest :: end_of_elaboration_phase(uvm_phase phase); 
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

virtual task UartBaseTest :: run_phase(uvm_phase phase);
  uartVirtualBaseSequence = UartVirtualBaseSequence :: type_id :: create("uartVirtualBaseSequence");
  phase.raise_objection(this);
   uartVirtualBaseSequence.start(uartEnv.uartVirtualSequencer);
  phase.drop_objection(this);
endtask : run_phase

`endif  

  
