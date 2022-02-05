`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 12:10:00 PM
// Design Name: 
// Module Name: key_subword
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module key_subword(
	input clk,
	input [127:0] key_in,
	input [7:0] rcon,
	output reg [127:0] key_out
);

	reg [31:0] word0;
	wire [31:0] word0_prereg;
	wire [31:0] previous_last_word;
	assign previous_last_word = key_in[127:96];
    	sbox sbox_i3 (.data_out(word0_prereg[7:0]), .data_in(previous_last_word[15:8]));
    	sbox sbox_i0 (.data_out(word0_prereg[15:8]), .data_in(previous_last_word[23:16]));
    	sbox sbox_i1 (.data_out(word0_prereg[23:16]), .data_in(previous_last_word[31:24]));
    	sbox sbox_i2 (.data_out(word0_prereg[31:24]), .data_in(previous_last_word[7:0]));

	reg [127:0] key_in_reg;
	wire [31:0] tmp_word0;
	assign tmp_word0 = word0;

	wire [31:0] tmp_word1;
	assign tmp_word1 = word0 ^ key_in_reg[63:32];

	wire [31:0] tmp_word2;
	assign tmp_word2 = word0 ^ key_in_reg[63:32] ^ key_in_reg[95:64];

	wire [31:0] tmp_word3;
	assign tmp_word3 = word0 ^ key_in_reg[63:32] ^ key_in_reg[95:64] ^ key_in_reg[127:96];


	wire [127:0] key_out_prereg;
	assign key_out_prereg = {tmp_word3, tmp_word2, tmp_word1, tmp_word0};

	always @(posedge clk) begin
		word0 <= word0_prereg ^ key_in[31:0] ^ {24'h0, rcon};
		key_in_reg <= key_in;
		key_out <= key_out_prereg;
	end


endmodule
