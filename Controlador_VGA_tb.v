`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:24 08/18/2016 
// Design Name: 
// Module Name:    Controlador_VGA_tb 
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
module Controlador_VGA_tb;

//Declaración de entradas
	reg clk_tb;
	reg reset_tb;
	reg [2:0] sw_tb;

//Declaración de salidas
	wire [2:0] rgbtext_tb;
	wire hsync_tb;
	wire vsync_tb;
		
//Instanación del DUT		
	Controlador_VGA dut(
	.clk(clk_tb),
	.reset(reset_tb),
	.sw (sw_tb),
	.rgbtext (rgbtext_tb),
	.hsync (hsync_tb),
	.vsync (vsync_tb)
	);

	initial
	begin
		clk_tb = 0;
	forever
		begin
		 #10 clk_tb = ~clk_tb; 
		end
	end
	
	initial
		begin
			clk_tb = 0;
			reset_tb = 1;
			
			#50
			reset_tb = 0;
			
			#1000
			sw[0] = 0;
			sw[1] = 0;
			sw[2] = 1; //Pinta rojo
			
			#16800000
			sw[0] = 0;
			sw[1] = 1;
			sw[2] = 0; //Pinta verde
			
			#16800000
			sw[0] = 1;
			sw[1] = 0;
			sw[2] = 0; //Pinta azul 
			
			#1000
			$stop;
			
		end



endmodule
