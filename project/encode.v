module encode (message, codeword);
	input [5:0] message;
	output [15:0] codeword;

	//m*G
	genvar i,j;
	generate 
		for(i=0; i<=4; i=i+1) begin : row_sum_mult//loop through m's index
			for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute c[i] by summing each element of the codeword (G's column) times m[i]
				assign codeword[i] = codeword[i] + message[i]*project.G[i][j];
			end
		end
	endgenerate

endmodule