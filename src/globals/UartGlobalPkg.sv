`ifndef UARTGLOBALPKG_INCLUDED_
`define UARTGLOBALPKG_INCLUDED_

package UartGlobalPkg;

  parameter DATA_WIDTH=5;
  parameter NO_OF_PACKETS = 50;
  //parameter  DUTY = 60;
  //parameter FREQUENCY = 0.5; // in GHz
  //parameter PERIOD = 1/f ;//frequency;

  parameter PARITY_ENABLED = 1'b 0;

  typedef enum{ EVEN_PARITY , ODD_PARITY} PARITY_TYPE;
  
  typedef struct packed { bit[NO_OF_PACKETS -1 :0][DATA_WIDTH-1:0] transmissionData; bit parity;} UartTxPacketStruct;
  typedef struct packed { bit[NO_OF_PACKETS -1 :0][DATA_WIDTH-1:0] receivingData; bit parity;} UartRxPacketStruct;

  typedef enum bit[31:0]{ BAUD_4800 = 32'd4800,
                          BAUD_9600 = 32'd9600,
                         BAUD_19200 = 32'd19200 }baud_rate_e;

  typedef enum bit[4:0]{ X16 = 5'd16,
                        X13 = 5'd13}over_sampling_e;


  typedef enum bit[1:0]{ ONE_BIT = 1,
                        TWO_BIT = 2 } stop_bit_e;

  typedef enum bit[3:0]{ FIVE_BIT = 5,
                         SIX_BIT = 6,
                         SEVEN_BIT=7,
                        EIGHT_BIT=8} data_type_e;

endpackage : UartGlobalPkg
`endif
