`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:06 08/18/2016 
// Design Name: 
// Module Name:    TopVGA 
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
module TopVGA(
	input wire clk, reset,
	input wire [2:0] rgbswitches,
	output wire [2:0] rgbtext,
	output wire hsync, vsync,
	output wire [9:0] pixel_x, pixel_y
   );
	//llamada al modulo sincronizador
	 
	wire video_activado, instante_pulso; //salidas del sincronizador
	
	wire [2:0] switches;
	
	debouncer dut0(
	.clk(clk),
	.sw(rgbswitches),
	.sw_out(switches),
	.reset(reset)
	);

	
	sincronizador dut1(
	.clk(clk),
	.reset(reset),
	.hsync(hsync),
	.vsync(vsync),
	.video_activado(video_activado),
	.instante_pulso(instante_pulso),
	.pixel_x(pixel_x),
	.pixel_y(pixel_y)
	);
	
	//llamado al modulo generador de caracter
	
	GeneradorLetras dut2(
	.videoon(video_activado),
	.rgbswitches(switches),
	.pixelx(pixel_x),
	.pixely(pixel_y),
	.rgbtext(rgbtext)
	);
	

endmodule
