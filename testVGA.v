`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:59 08/21/2016 
// Design Name: 
// Module Name:    testVGA 
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
module testVGA;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] rgbswitches;

	// Outputs
	wire [2:0] rgbtext;
	wire hsync;
	wire vsync;
	wire [9:0] pixel_x, pixel_y;

	// Instantiate the Unit Under Test (UUT)
	TopVGA uut (
		.clk(clk), 
		.reset(reset), 
		.rgbswitches(rgbswitches), 
		.rgbtext(rgbtext), 
		.hsync(hsync), 
		.vsync(vsync),
		.pixel_x(pixel_x),
		.pixel_y(pixel_y)
		);
		
	integer i;
	integer j;
	
	initial
	begin
		clk = 0;
	forever
		begin
		 #10 clk = ~clk; 
		end
	end
	
		
	
	initial
		begin
			clk = 0;
			reset = 1;
			j=0;
			#50
			reset = 0; 
			
			rgbswitches[0] = 0;
			rgbswitches[1] = 0;
			rgbswitches[2] = 1;
			
			//archivo txt para observar los bits, simulando una pantalla
			i= $fopen("Test1.txt","w");
			for(j=0;j<27200;j=j+1) begin
				#40
				if( (pixel_x > 1'b0) & (pixel_x < 10'b1100011111))
					$fwrite(i,"%d",rgbtext[2]);
				else
					$fwrite(i,"\n");
			end
				
			
			#16800000
			reset=0;
			$fclose(i);
			$stop;
	end
      
endmodule