`ifndef UARTVIRTUALBASESEQUENCE_INCLUDED_
`define UARTVIRTUALBASESEQUENCE_INCLUDED_

class UartVirtualBaseSequence extends uvm_sequence;
  `uvm_object_utils(UartVirtualBaseSequence)
  `uvm_declare_p_sequencer(UartVirtualSequencer)

  extern function new(string name = "UartVirtualBaseSequence");
  extern virtual task body();

endclass : UartVirtualBaseSequence

function UartVirtualBaseSequence :: new(string name = "UartVirtualBaseSequence" );
  super.new(name);
endfunction : new


task UartVirtualBaseSequence :: body();
  super.body();

  if( !($cast(p_sequencer , m_sequencer)))
    `uvm_error(get_type_name(),"FAILED TO CASTE TO SEQUENCER SUBPOINTER");

endtask : body

`endif

