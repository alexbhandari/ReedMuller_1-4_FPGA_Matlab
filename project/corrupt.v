module corrupt (in, out);
	input [5:0] in;
	output [15:0] out;

	wire noise;

	assign out = in;
	//noise_block	gn	(	.rst(rst), .clk(clk), .out(noise)			);
	//add32 a (	.a(in), .b(noise), .y(out)	);

endmodule