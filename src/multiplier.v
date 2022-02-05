module mixcolumn(data_in,data_out);

input [127:0] data_in;
output  [127:0] data_out;

wire  [31:0] n1,n2,n3,n4;
wire  [31:0] n_tmp_out1, n_tmp_out2, n_tmp_out3, n_tmp_out4;


wire clk = 1'b0;

assign n1 = data_in[127:96];
assign n2=data_in[95:64];
assign n3=data_in[63:32];
assign n4=data_in[31:0];

mixcolumn_32 m1 (clk,n1,n_tmp_out1);
mixcolumn_32 m2 (clk,n2,n_tmp_out2);
mixcolumn_32 m3 (clk,n3,n_tmp_out3);
mixcolumn_32 m4 (clk,n4,n_tmp_out4);

assign data_out={n_tmp_out1,n_tmp_out2,n_tmp_out3,n_tmp_out4};

endmodule




module mul_2(clk,data_in,data_out);
input[7:0] data_in;
input clk;
output [7:0]data_out;
 
assign data_out ={ data_in[6:0],1'b0} ^ (8'h1b & {8{data_in[7]}});

endmodule


module mixcolumn_32(clk,data_in,data_out);
input clk;
input [31:0] data_in;
output [31:0] data_out;

	// given 1.5 ns delay
	parameter LUT_DELAY = 15;
	reg [31:0] tmp_delay_data [0:LUT_DELAY];
	always @(data_in) begin
		tmp_delay_data[0] = data_in;
	end
	generate
	for (genvar j = 1 ; j <= LUT_DELAY ; j = j + 1) begin : tmp_delay_data_loop
		always @(tmp_delay_data[j-1]) begin
			tmp_delay_data[j] = #0.1 tmp_delay_data[j-1];
		end
	end
	endgenerate

	wire [31:0] m_data_in;
	assign m_data_in = tmp_delay_data[LUT_DELAY];


wire [7:0] tmp1,tmp2,tmp3,tmp0;
wire [7:0] ma0,ma1,ma2,ma3;

// column
assign tmp3=m_data_in[31:24]; //row 3
assign tmp2=m_data_in[23:16];
assign tmp1=m_data_in[15:8];
assign tmp0=m_data_in[7:0]; // row 0

wire [7:0] xtime_01, xtime_12, xtime_23, xtime_30;

wire [7:0] t;
assign t = tmp3 ^ tmp2 ^ tmp1 ^ tmp0;

mul_2 m1 (clk, tmp0 ^ tmp1, xtime_01);
mul_2 m2 (clk, tmp1 ^ tmp2, xtime_12);
mul_2 m3 (clk, tmp2 ^ tmp3, xtime_23);
mul_2 m4 (clk, tmp3 ^ tmp0, xtime_30);

assign ma3 = tmp3 ^ xtime_30 ^ t;
assign ma2 = tmp2 ^ xtime_23 ^ t;
assign ma1 = tmp1 ^ xtime_12 ^ t;
assign ma0 = tmp0 ^ xtime_01 ^ t;

assign data_out = {ma3, ma2, ma1, ma0};
endmodule





