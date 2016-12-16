module encode_corrupt_decode (audio_in, aclk, clk, switch, audio_out);
	input [4:0] audio_in;
	input aclk;
	input clk;
	input [2:0] switch;
	output [4:0] audio_out;

	wire [15:0] ec;
	wire [15:0] cd;

	encode	e	(	.message(audio_in), .codeword(ec)			);
	corrupt	c	(	.in(ec),	.clk(aclk), .switch(switch), .out(cd)			);
	decode	d	(	.r(cd),	.clk(aclk), .message(audio_out)	);

endmodule