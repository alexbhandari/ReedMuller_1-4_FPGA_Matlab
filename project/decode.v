module decode (r, message);
	input [15:0] r;
	output [5:0] message;

	assign message = codeword[4:0];

	reg [10:0] het;
	reg [15:0] codeword;
	
	//r*transpose(H)
	genvar i,j;
	generate 
		for(i=0; i<=4; i=i+1) begin : row_sum_mult//loop through r's index
			for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute het[i] by summing each element of the r (G's column) times r[i]
				assign het[i] = het[i] + r[i]*project.H[j][i];
			end
		end
	endgenerate

endmodule