module set;
 int x;
 int y;
 bit clk;
 always #5 clk=~clk;

 always @(posedge clk)
  x=10;

always@(posedge clk)
 y =x;

 initial begin 
 #20;
 $finish;
end 


always@(posedge clk)
 $display("THE VALUE OF X IS %0d and y is%0d @%t",x,y,$time);

endmodule 
