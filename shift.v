module shift_32 (in, switch, clk, out);
		input [31:0]	in;
		input [2:0] switch;
		input clk;
		output [31:0]	out;
		
		reg val;
		
	always @ (posedge clk) begin
   case(switch)
		3'b000:  out = in >>> 10; //-10dB
   	3'b001:  out = in >>> 8;
   	3'b010:  out = in >>> 6; 
   	3'b100:  out = in >>> 4; 
   	3'b101:  out = in >>> 2; 
   	3'b111:  out = in;		//50dB
		default: out = in;
   endcase
	end
		
endmodule