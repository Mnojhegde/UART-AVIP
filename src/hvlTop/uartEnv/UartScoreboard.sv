`ifndef UARTSCOREBOARD_INCLUDED_
`define UARTSCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: UartScoreboard
// Used to compare the data sent/received by the master with the slave's data sent/received
//--------------------------------------------------------------------------------------------
class UartScoreboard extends uvm_scoreboard;
  `uvm_component_utils(UartScoreboard)
  
  //Variable: uartScoreboardTxAnalysisExport
  //Declaring analysis export for transmitting  Tx transaction object to scoreboard
  uvm_analysis_export #(UartTxTransaction) uartScoreboardTxAnalysisExport;

  
  //Variable: uartScoreboardRxAnalysisExport
  //Declaring analysis export for transmitting  Rx transaction object to scoreboard
  uvm_analysis_export #(UartRxTransaction) uartScoreboardRxAnalysisExport;

  //Variable: uartScoreboardTxAnalysisFifo
  //Used to store the uart Tx transaction
  uvm_tlm_analysis_fifo #(UartTxTransaction) uartScoreboardTxAnalysisFifo;

  //Variable: uartScoreboardRxAnalysisFifo
  //Used to store the uart Rx transaction
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
// Initialization of new memory
//
// Parameters:
//  name - UartScoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------   
function UartScoreboard :: new(string name = "UartScoreboard" , uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
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
// used to connect the analysis ports
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
// Used to give delays and check the transmitted and recieved data are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task UartScoreboard :: run_phase(uvm_phase phase);
super.run_phase(phase);
  
  forever begin
    `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_HIGH)
    fork 
      begin
        uartScoreboardTxAnalysisExport.get(uartTxTransaction);
        foreach(uartTxTransaction.txData[i]) begin
          txData.push_back(uartTxTransaction.txData[i]);
          `uvm_info(get_type_name(),$sformatf("Printing txData[%p]= %p", i, txData[i]),UVM_HIGH)
        end
        uartScoreboardRxAnalysisFifo.get(uartRxTransaction);
        foreach(uartRxTransaction.rxData[i]) begin
          rxData.push_back(uartRxTransaction.rxData[i]);
          `uvm_info(get_type_name(),$sformatf("printing rxData[%p]=%p", i, rxData[i]),UVM_HIGH)
        end
        endtask

endtask : run_phase

`endif
