`ifndef UARTTXTRANSACTION_INLCLUDED_ 
`define UARTTXTRANSACTION_INCLUDED_

class UartTxTransaction extends uvm_sequence_item;
  `uvm_object_utils(UartTxTransaction)

  rand bit[DATA_WIDTH-1 : 0]transmission_data[];
  bit pairty;

  constraint set_number_of_transmissionn_range{ soft transmission_data.size() inside {[1:10]};}
  constraint set_transmission_data_range{ soft foreach(transmission_data[i]) transmission_data[i] inside{[1:$]};}

  extern function void new(string name = "UartTxTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function void do_print(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs);
endclass : UartTxTransaction

function UartTxTransaction :: new(string name = "UartTxTransaction");
  super.new(name);
endfunction : new

function void UartTxTransaction :: do_copy(uvm_object rhs);
  UartTxTransaction rhs1;

  if(! $cast(rhs1,rhs))
   `uvm_fatal("do_copy","casting failed during copying");

  super.copy(rhs);
  this.transmission_data = rhs1.transmission_data;
  this.parity = rhs1.parity;
endfunction : do_copy
  
function bit UartTxTransaction :: do_compare(uvm_object rhs, uvm_comparer comparer);
  UartTxTransaction rhs1;
  if(! $cast(rhs1,rhs))
   `uvm_fatal("do_compare","Casting failed during comparing");

  return (super.compare(rhs,comparer) && this.transaction_data == rhs1.transaction_data && this.parity == rhs1.parity);
endfunction : do_compare

function void UartTxTransaction :: do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(this.transaction_data[i])
   printer.print_field($sformatf("Transaction_data[%0d]",i),transaction_data[i],$bits(transaction_data[i]),UVM_BIN);
  printer.print_field("parity",parity,$bits(parity),UVM_BIN);
endfunction : do_print

`endif
