`ifndef UARTENV_INCLUDED_
`define UARTENV_INCLUDED_

class Uart_Env extends uvm_env;
  `uvm_component_utils(Uart_Env)

  UartVirtualSequencer uartVirtualSequencer;
  UartTxAgent uartTxAgent;
  UartRxAgent uartRxAgent;
  UartEnvConfig uartEnvConfig;
 // UartScoreboard uartScoreboard;

  extern function void new(string name = "Uart_Env" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvmp_phase phase);
endclass : Uart_Env

function void Uart_Env :: new(string name = "UartEnv" , uvm_component parent);
  super.new(name,this);
endfunction : new

function void UartEnv :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(UartEnvConfig) :: get(this,"","uartEnvConfig",this.uartEnvConfig)))
    `uvm_fatal("FATAL ENV CONFIG", $sformat("Failed to get environment config in environment"))

  if(uartEnvConfig.hasvirtualsequencer) 
  begin 
    uartVirtualSequencer = UartVirtualSequencer :: type_id :: create("uartVirtualSequencer",this);
  end 

  if(uartEnvConfig.hasscoreboard)
  begin 
  //  uartScoreboard = UartScoreboard :: type_id :: create("uartScoreboard",this);
  end 

  uartTxAgent = UartTxAgent :: type_id :: create("uartTxAgent",this);
  uartRxAgent = UartRxAgent :: type_id :: create("uartTxAgent",this);
endfunction : build_phase


function void UartEnv ::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  //uartTxAgent.uartTxAgentAnalysisPort.connect(uartScoreboard.uartScoreboardAnalysisExport);
  //uartRxAgent.uartRxAgentAnalysisPort.connect(uartScoreboard.uartScoreboardAnalysisExport);

  if(uartEnvConfig.hasvirtualsequencer==1)
  begin 
   uartVirtualSequencer.uartTxSequencer = uartTxAgent.uartTxSequencer;
   uartVirtualSequencer.uartRxSequencer = uartRxAgent.uartRxSequencer;
  end 
endfunction : connect_phase

