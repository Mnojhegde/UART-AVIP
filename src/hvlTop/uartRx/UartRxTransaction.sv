
`ifndef UARTRXTRANSACTION_INLCLUDED_ 
`define UARTRXTRANSACTION_INCLUDED_

class UartRxTransaction extends uvm_sequence_item;
  `uvm_object_utils(UartRxTransaction)

  bit[3 : 0]receiving_data[];
  bit parity;

  extern function new(string name = "UartRxTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function void do_print(uvm_printer printer);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer = null);
endclass : UartRxTransaction

function UartRxTransaction :: new(string name = "UartRxTransaction");
  super.new(name);
endfunction : new

function void UartRxTransaction :: do_copy(uvm_object rhs);
  UartRxTransaction rhs1;

  if(! $cast(rhs1,rhs))
   `uvm_fatal("do_copy","casting failed during copying");

  super.copy(rhs);
  this.receiving_data = rhs1.receiving_data;
  this.parity = rhs1.parity;
endfunction : do_copy
  
function bit UartRxTransaction :: do_compare(uvm_object rhs, uvm_comparer comparer = null);
  UartRxTransaction rhs1;
  if(! $cast(rhs1,rhs))
   `uvm_fatal("do_compare","Casting failed during comparing");
  return (super.compare(rhs,comparer) && (this.receiving_data == rhs1.receiving_data) && (this.parity && rhs1.parity));
endfunction : do_compare

function void UartRxTransaction :: do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(this.receiving_data[i])
   printer.print_field($sformatf("receiving_data[%0d]",i),receiving_data[i],$bits(receiving_data[i]),UVM_BIN);
endfunction : do_print

`endif
