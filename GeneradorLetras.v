`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:15 08/18/2016 
// Design Name: 
// Module Name:    GeneradorLetras 
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
module GeneradorLetras(
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

reg [2:0] letter_rgb;


wire [7:0] Data;
reg [1:0] AD;

// x , y coordinates (0.0) to (639,479)
localparam maxx = 640;
localparam maxy = 480;

// Letter boundaries
localparam jaxl = 1;
localparam jaxr = 7;
localparam dxl = 16;
localparam dxr = 23;
localparam jbxl = 32;
localparam jbxr = 39;

localparam yt = 1;
localparam yb = 16;


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

reg pixelbit;
always @*
case (lsbx)
3'h0: pixelbit <= Data[7];
3'h1: pixelbit <= Data[6];
3'h2: pixelbit <= Data[5];
3'h3: pixelbit <= Data[4];
3'h4: pixelbit <= Data[3];
3'h5: pixelbit <= Data[2];
3'h6: pixelbit <= Data[1];
3'h7: pixelbit <= Data[0];
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