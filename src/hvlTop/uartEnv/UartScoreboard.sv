`ifndef UARTSCOREBOARD_INCLUDED_
`define UARTSCOREBOARD_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: uart_scoreboard
// Scoreboard the data getting from monitor port that goes into the implementation port
//--------------------------------------------------------------------------------------------
class UartScoreboard extends uvm_scoreboard;
  `uvm_component_utils(UartScoreboard)

  //Analysis ports
  uvm_analysis_export #(UartTxTransaction) uartScoreboardTxAnalysisExport;
  uvm_analysis_export #(UartRxTransaction) uartScoreboardRxAnalysisExport;
  uvm_tlm_analysis_fifo #(UartTxTransaction) uartScoreboardTxAnalysisFifo;
  uvm_tlm_analysis_fifo #(UartRxTransaction) uartScoreboardRxAnalysisFifo;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new( string name = "UartScoreboard" , uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : UartScoreboard
    
//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - uart_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function UartScoreboard :: new(string name = "UartScoreboard" , uvm_component parent = null);
  super.new(name, parent);
endfunction : new
    
//--------------------------------------------------------------------------------------------
// Function: build_phase
// Build device0 and device1 analysis fifo
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void UartScoreboard :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  uartScoreboardTxAnalysisExport = new("uartScoreboardTxAnalysisExport",this);
  uartScoreboardRxAnalysisExport = new("uartScoreboardRxAnalysisExport",this);
  uartScoreboardTxAnalysisFifo = new("uartScoreboardTxAnalysisFifo",this);
  uartScoreboardRxAnalysisFifo = new("uartScoreboardRxAnalysisFifo",this);
endfunction : build_phase
    
//--------------------------------------------------------------------------------------------
// Function: connect_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void UartScoreboard :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  uartScoreboardTxAnalysisExport.connect(uartScoreboardTxAnalysisFifo.analysis_export);
  uartScoreboardRxAnalysisExport.connect(uartScoreboardRxAnalysisFifo.analysis_export);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task UartScoreboard :: run_phase(uvm_phase phase);


endtask : run_phase

`endif
