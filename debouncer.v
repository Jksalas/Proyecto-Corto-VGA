`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:56 08/21/2016 
// Design Name: 
// Module Name:    debouncer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
 module debouncer(
	input clk,
	input [2:0] sw,
	output [2:0] sw_out,
	input wire reset
    );

   reg [2:0] register1,register2,register3;

   always @ (posedge clk)
      if (reset == 1) begin
         register1 <= 3'b000;
			register2 <= 3'b000;
			register3 <= 3'b000;
		end
      else begin
         register1 <= {register1[1:0], sw[0]};
			register2 <= {register2[1:0], sw[1]};
			register3 <= {register3[1:0], sw[2]};
		end
			
	//and final que decide cuando se le da el valor de 1 logico al pulsador
   assign sw_out[0] = register1[0] & register1[1] & register1[2];
	assign sw_out[1] = register2[0] & register2[1] & register2[2];
	assign sw_out[2] = register3[0] & register3[1] & register3[2];
	

endmodule
