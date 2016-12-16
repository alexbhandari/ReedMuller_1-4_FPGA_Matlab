module corrupt (in, clk, switch, out);
	input [15:0] in;
	input clk;
	input [2:0] switch;
	output [15:0] out;

	wire [0:31] noise1;
	wire [0:31] noise2;
	wire [0:31] noise3;
	wire [0:15] noise;

	always @ (*)
	case (switch)
	0 : noise = 16'b0000000000000000; //no noise
	1 : noise = noise1[0:15]; //0dB
	2 : noise = noise1[0:15] & noise1[16:31]; //-10dB
	3 : noise = noise1[0:15] & noise1[16:31] & noise2[0:15]; //-20dB
	4 : noise = noise1[0:15] & noise1[16:31] & noise2[0:15] & noise2[16:31]; //-30dB
	5 : noise = noise1[0:15] & noise1[16:31] & noise2[0:15] & noise2[16:31] & noise3[0:15]; //-40dB
	default: noise = 16'b0;
	endcase

	assign out = noise;
	noise_block	gn1	(	.rst(rst), .clk(clk), .out(noise1)			);
	noise_block	gn2	(	.rst(rst), .clk(clk), .out(noise2)			);
	noise_block	gn3	(	.rst(rst), .clk(clk), .out(noise3)			);
	//add32 a (	.a(in), .b(noise), .y(out)	);

endmodule