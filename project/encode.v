module encode (message, codeword);
	input [5:0] message;
	output [15:0] codeword;
	
	reg [15:0] codeword;

	//m*G
	integer i,j;
	always_comb begin
		for(i=0; i<=4; i=i+1) begin : row_sum_mult//loop through m's index
			//for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute c[i] by summing each element of the codeword (G's column) times m[i]
				//codeword[i] = codeword[i] ^ message[i] ^ project.G[i][j];
			//end
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][0];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][1];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][2];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][3];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][4];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][5];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][6];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][7];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][8];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][9];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][10];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][11];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][12];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][13];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][14];
			codeword[i] = codeword[i] ^ message[i] ^ project.G[i][15];
		end
	end

endmodule