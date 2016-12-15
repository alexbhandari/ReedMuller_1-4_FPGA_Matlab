module decode (r, clk, message);
	input [15:0] r;
	input clk;
	output [5:0] message;

	reg [10:0] het = 11'b00000000000;
	reg [10:0] e_het = 11'b00000000000;
	reg [15:0] codeword  = 16'b0000000000000000;
	reg [10:0] error = 11'b00000000000;
	

	//het = r*transpose(H)
	genvar i,j,k;
	generate 
		for(i=0; i<=4; i=i+1) begin : row_sum_mult//loop through r's index
			for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute het[i] by summing each element of the r (G's column) times r[i]
				assign het[i] = het[i] + r[i]*project.H[j][i];
			end
		end
	endgenerate

	// search for match
	generate
		for (i=0; i<=695; i=i+1) begin : match_error // loop through error book
	
			// compute e_het for each e[i]
			assign e_het = 11'b00000000000;
			for(k=0; k<=4; k=k+1) begin : row_sum_mult//loop through r's index //(1,16)*(16,11)=(1,11)
				for(j=0; j<=15; j=j+1) begin : column_sum_mult //compute het[i] by summing each element of the r (G's column) times r[i]
					assign e_het[k] = e_het[k] + project.e[i][k]*project.H[j][k];
				end
			end
			
			// at clk edge: seach through all e_het[i] and compute the message at the match
			always@(posedge clk) begin
				if(het == e_het) begin
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