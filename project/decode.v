module decode (r, clk, message, het);
	input [15:0] r;
	input clk;
	output [5:0] message;
	output [10:0] het;

	reg [10:0] het;
	reg [10:0] e_het = 11'b00000000000;
	reg [15:0] codeword;
	reg [10:0] error;
	

	//het = r*transpose(H)
	genvar i,j,k;
//	generate 
//		for(i=0; i<=4; i=i+1) begin : row_sum_mult//loop through r's index
//			for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute het[i] by summing each element of the r (G's column) times r[i]
//				assign het[i] = het[i] + r[i]*project.H[j][i];
//			end
//		end
//	endgenerate
always@(r) begin
	het[0]  <=r[0]^r[1]^r[2]^r[5];
	het[1]  <=r[0]^r[1]^r[3]^r[6];
	het[2]  <=r[0]^r[1]^r[4]^r[7];
	het[3]  <=r[0]^r[2]^r[3]^r[8];
	het[4]  <=r[0]^r[2]^r[4]^r[9];
	het[5]  <=r[0]^r[3]^r[4]^r[10];
	het[6]  <=r[1]^r[2]^r[3]^r[11];
	het[7]  <=r[1]^r[2]^r[4]^r[12];
	het[8]  <=r[1]^r[3]^r[4]^r[13];
	het[9]  <=r[2]^r[3]^r[4]^r[14];
	het[10] <=r[0]^r[1]^r[2]^r[3]^r[4]^r[15];
end	

	always@(het) begin
		if(het == project.eb[0]) begin
			error = project.e[1];
			//break;
		end
	end

	// search for match
	generate
		for (i=0; i<=696; i=i+1) begin : compare // loop through error book
	
			// compute e_het for each e[i]
			//assign e_het = 11'b00000000000;
			//for(k=0; k<=4; k=k+1) begin : row_sum_mult//loop through r's index //(1,16)*(16,11)=(1,11)
			//	for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute het[i] by summing each element of the r (G's column) times r[i]
			//		assign e_het[k] = e_het[k] + project.e[i][k]*project.H[j][k];
			//	end
			//end
			//--solution pre-stored in eb--
			
			// at clk edge: seach through all e_het[i] and compute the message at the match
			always@(het) begin
				error = project.e[i];
				if(het == project.eb[i]) begin
					error = project.e[i];
					//break;
				end
			end
			
		end
	endgenerate
	//if no error is found e remains 0 and the corrupted message is returned
	
	assign codeword = r ^ error;
	assign message = codeword[15:11];
	
endmodule