
module MapperVerilogTop (
  dataIn, realOut, imagOut
);
  input [5:0] dataIn;
  output [3:0] realOut;
  output [3:0] imagOut;
  
  MapperVHDL U1(dataIn, realOut,imagOut);
  
endmodule