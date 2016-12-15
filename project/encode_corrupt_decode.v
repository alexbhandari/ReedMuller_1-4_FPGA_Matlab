module encode_corrupt_decode (audio_in, aclk, clk, audio_out);
	input [5:0] audio_in;
	input aclk;
	input clk;
	output [5:0] audio_out;

	wire [5:0] ec;
	wire [5:0] cd;

	encode	e	(	.message(audio_in), .codeword(ec)			);
	corrupt	c	(	.in(ec),	.out(de)			);
	decode	d	(	.r(de),	.clk(aclk), .message(audio_out)	);

endmodule