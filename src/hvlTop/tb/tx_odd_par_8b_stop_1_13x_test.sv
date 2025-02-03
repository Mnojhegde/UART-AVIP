`ifndef TXODDPAR8BSTOP116XTEST_INCLUDED_
`define TXODDPAR8BSTOP116XTEST_INCLUDED_

class tx_odd_par_8b_stop_1_13x_test extends UartBaseTest ;
  `uvm_component_utils(tx_odd_par_8b_stop_1_13x_test)
  
  tx_odd_par_8b_stop_1_13x_vseq tx_odd_par_8b_stop_1_13x_vseq_h;

  UartEnvConfig           uartEnvConfig;
  UartEnv                 uartEnv;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_odd_par_8b_stop_1_13x_test", uvm_component parent = null);
  extern task run_phase(uvm_phase phase);
  extern  function void  build_phase(uvm_phase phase);
  extern  function void  setupUartEnvConfig();
  extern  function void  setupUartTxAgentConfig();
  extern  function void  setupUartRxAgentConfig();

endclass : tx_odd_par_8b_stop_1_13x_test

function tx_odd_par_8b_stop_1_13x_test::new(string name = "tx_odd_par_8b_stop_1_13x_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void tx_odd_par_8b_stop_1_13x_test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  setupUartEnvConfig();
  uartEnv = UartEnv :: type_id :: create("uartEnv" , this);
endfunction  : build_phase

 function void tx_odd_par_8b_stop_1_13x_test :: setupUartEnvConfig();
   super.setupUartEnvConfig();
endfunction : setupUartEnvConfig 

 function void tx_odd_par_8b_stop_1_13x_test :: setupUartTxAgentConfig();
  
  uartEnvConfig.uartTxAgentConfig = UartTxAgentConfig :: type_id :: create("uartTxAgentConfig");
  uartEnvConfig.uartTxAgentConfig.is_active = UVM_ACTIVE;
  uartEnvConfig.uartTxAgentConfig.hasCoverage = 1;
  uartEnvConfig.uartTxAgentConfig.hasParity = PARITY_ENABLED;
  uartEnvConfig.uartTxAgentConfig.uartOverSamplingMethod = OVERSAMPLING_13;
  uartEnvConfig.uartTxAgentConfig.uartBaudRate = BAUD_9600;
  uartEnvConfig.uartTxAgentConfig.uartDataType = FIVE_BIT;
  uartEnvConfig.uartTxAgentConfig.uartParityType = ODD_PARITY;
  uvm_config_db #(UartTxAgentConfig) :: set(this,"*", "uartTxAgentConfig",uartEnvConfig.uartTxAgentConfig);

endfunction : setupUartTxAgentConfig

function void tx_odd_par_8b_stop_1_13x_test :: setupUartRxAgentConfig();
super.setupUartRxAgentConfig();

endfunction : setupUartRxAgentConfig

task tx_odd_par_8b_stop_1_13x_test::run_phase(uvm_phase phase);
  
 tx_odd_par_8b_stop_1_13x_vseq_h = tx_odd_par_8b_stop_1_13x_vseq::type_id::create("tx_odd_par_8b_stop_1_13x_vseq_h");
  `uvm_info(get_type_name(),$sformatf("tx_odd_par_8b_stop_1_13x_test"),UVM_LOW);
  phase.raise_objection(this);
    tx_odd_par_8b_stop_1_13x_vseq_h.start(uartEnv.uartVirtualSequencer);
  phase.drop_objection(this);

endtask : run_phase

`endif

