`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo 4
// Engineer: 
// 
// Create Date:    15:03:38 08/16/2016 
// Design Name: 
// Module Name:    ControladorVGA 
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
module ControladorVGA(
	 input wire videoon,
	 input wire [2:0] rgbswitches,
	 input wire [9:0] pixelx, pixely, 
	 output reg [2:0] rgbtext
	     );

// CONSTANTES Y DECLARACIONES

wire [2:0] lsbx;
wire [3:0] lsby;
assign lsbx = pixelx[2:0];
assign lsby = pixely[3:0];

wire [2:0] letter_rgb;


wire [7:0] Data;
wire [1:0] AD;

// x , y coordinates (0.0) to (639,479)
localparam maxx = 640;
localparam maxy = 480;

// Letter boundaries
localparam jaxl = 300;
localparam jaxr = 307;
localparam dxl = 316;
localparam dxr = 323;
localparam jbxl = 332;
localparam jbxr = 339;

localparam yt = 232;
localparam yb = 247;


// letter output signals
wire jaon, don, jbon;


// CUERPO

// pixel within letters 
assign jaon =
(jaxl<=pixelx) && (pixelx<=jaxr) &&
(yt<=pixely) && (pixely<=yb);

assign don =
(dxl<=pixelx) && (pixelx<=dxr) &&
(yt<=pixely) && (pixely<=yb);

assign jbon =
(jbxl<=pixelx) && (pixelx<=jbxr) &&
(yt<=pixely) && (pixely<=yb);

always @* begin
if (jaon)
AD <= 2'h1; 
else if (don)
AD <= 2'h2;
else if (jbon)
AD <= 2'h1;
else
AD <= 2'h0;   
end
 
ROM FONT(AD,lsby,Data); 

wire pixelbit;
always @*
case (lsbx)
3'h0: pixelbit <= Data[0];
3'h1: pixelbit <= Data[1];
3'h2: pixelbit <= Data[2];
3'h3: pixelbit <= Data[3];
3'h4: pixelbit <= Data[4];
3'h5: pixelbit <= Data[5];
3'h6: pixelbit <= Data[6];
3'h7: pixelbit <= Data[7];
endcase

always @*
if (pixelbit)
letter_rgb <= rgbswitches;
else
letter_rgb <= 3'b000;

// rgb multiplexing circuit
always @*
if (~videoon)
rgbtext = 3'b000; // blank 
else if (jaon|don|jbon)  
rgbtext = letter_rgb; 
else
rgbtext = 3'b000; // black background

endmodule

module ROM (
input wire [1:0]AD,
input wire [3:0]lsby,
output wire [7:0]data 
);

reg [5:0]adress;

always @*
adress <= {AD,lsby};

always @*
case (adress)
6'h00: data = 8'b00000000;
6'h01: data = 8'b00000000; 
6'h02: data = 8'b00000000; 
6'h03: data = 8'b00000000; 
6'h04: data = 8'b00000000; 
6'h05: data = 8'b00000000;  
6'h06: data = 8'b00000000;
6'h07: data = 8'b00000000; 
6'h08: data = 8'b00000000; 
6'h09: data = 8'b00000000;
6'h0a: data = 8'b00000000;
6'h0b: data = 8'b00000000; 
6'h0c: data = 8'b00000000; 
6'h0d: data = 8'b00000000;
6'h0e: data = 8'b00000000;
6'h0f: data = 8'b00000000; 

6'h10: data = 8'b00000000;
6'h11: data = 8'b11111111; 
6'h12: data = 8'b11111111; 
6'h13: data = 8'b00011000; 
6'h14: data = 8'b00011000; 
6'h15: data = 8'b00011000;  
6'h16: data = 8'b00011000;
6'h17: data = 8'b00011000; 
6'h18: data = 8'b00011000; 
6'h19: data = 8'b00011000;
6'h1a: data = 8'b10011000;
6'h1b: data = 8'b11011000; 
6'h1c: data = 8'b11111000; 
6'h1d: data = 8'b01110000;
6'h1e: data = 8'b00000000;
6'h1f: data = 8'b00000000; 

6'h20: data = 8'b00000000;
6'h21: data = 8'b11111000; 
6'h22: data = 8'b11111100; 
6'h23: data = 8'b11000110; 
6'h24: data = 8'b11000110; 
6'h25: data = 8'b11000011;  
6'h26: data = 8'b11000011;
6'h27: data = 8'b11000011; 
6'h28: data = 8'b11000011; 
6'h29: data = 8'b11000011;
6'h2a: data = 8'b11000110;
6'h2b: data = 8'b11001110; 
6'h2c: data = 8'b11111100; 
6'h2d: data = 8'b11111000;
6'h2e: data = 8'b00000000;
6'h2f: data = 8'b00000000; 

default : data = 8'b00000000;
endcase 

endmodule


