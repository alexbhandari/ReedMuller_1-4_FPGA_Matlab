module encode (message, codeword);
	input [5:0] message;
	output [15:0] codeword;
	
	reg [15:0] codeword;

	//m*G
	//integer i,j;
	always@(message) begin
		//i=0;
		//j=0;
		//for(i=0; i<=4; i=i+1) begin : row_sum_mult//loop through m's index
			//for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute c[i] by summing each element of the codeword (G's column) times m[i]
				//codeword[i] = codeword[i] ^ message[i] ^ project.G[i][j];
			//end
			codeword[0]  = message[0];
			codeword[1]  = message[1];
			codeword[2]  = message[2];
			codeword[3]  = message[3];
			codeword[4]  = message[4];
			codeword[5]  = message[0] ^ message[1] ^ message[2];
			codeword[6]  = message[0] ^ message[1] ^ message[3];
			codeword[7]  = message[0] ^ message[1] ^ message[4];
			codeword[8]  = message[0] ^ message[2] ^ message[3];
			codeword[9]  = message[0] ^ message[2] ^ message[4];
			codeword[10] = message[0] ^ message[3] ^ message[4];
			codeword[11] = message[1] ^ message[2] ^ message[3];
			codeword[12] = message[1] ^ message[2] ^ message[4];
			codeword[13] = message[1] ^ message[3] ^ message[4];
			codeword[14] = message[2] ^ message[3] ^ message[4];
			codeword[15] = message[0] ^ message[1] ^ message[2] ^ message[3] ^ message[4];
		//end
	end

endmodule