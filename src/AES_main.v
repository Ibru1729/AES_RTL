`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 01:15:46 PM
// Design Name: 
// Module Name: AES_main
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


module AES_main(
    input clk,
    input data_active,
    input [127:0] key,
    input [127:0] data_in,
    output [127:0] data_out
    );

    wire [127:0] key_s;
    wire [127:0] key_s0;
    wire [127:0] key_s1;
    wire [127:0] key_s2;
    wire [127:0] key_s3;
    wire [127:0] key_s4;
    wire [127:0] key_s5;
    wire [127:0] key_s6;
    wire [127:0] key_s7;
    wire [127:0] key_s8;
    wire [127:0] key_s9;

    key_expand key_expand_i0 (.clk(clk),
	    			.key_active(data_active),
	    			.key(key),
	    			.key_s(key_s),
	    			.key_s0(key_s0),
	    			.key_s1(key_s1),
	    			.key_s2(key_s2),
	    			.key_s3(key_s3),
	    			.key_s4(key_s4),
	    			.key_s5(key_s5),
	    			.key_s6(key_s6),
	    			.key_s7(key_s7),
	    			.key_s8(key_s8),
	    			.key_s9(key_s9)
			);

	
    wire [127:0] data_out_s;
    reg [127:0] data_out_s0;
    reg data_active_s0;
    wire [127:0] data_out_s1;
    wire [127:0] data_out_s2;
    wire [127:0] data_out_s3;
    wire [127:0] data_out_s4;
    wire [127:0] data_out_s5;
    wire [127:0] data_out_s6;
    wire [127:0] data_out_s7;
    wire [127:0] data_out_s8;
    wire [127:0] data_out_s9;

    always @(posedge clk) begin
    	data_out_s0 = data_in ^ key_s;
	data_active_s0 = data_active;
    end

    aes_round aes_round_i1 (.clk(clk), .data_out(data_out_s1), .data_in(data_out_s0), .key_in(key_s0), .data_active_out(data_active_s1), .data_active_in(data_active_s0));
    aes_round aes_round_i2 (.clk(clk), .data_out(data_out_s2), .data_in(data_out_s1), .key_in(key_s1), .data_active_out(data_active_s2), .data_active_in(data_active_s1));
    aes_round aes_round_i3 (.clk(clk), .data_out(data_out_s3), .data_in(data_out_s2), .key_in(key_s2), .data_active_out(data_active_s3), .data_active_in(data_active_s2));
    aes_round aes_round_i4 (.clk(clk), .data_out(data_out_s4), .data_in(data_out_s3), .key_in(key_s3), .data_active_out(data_active_s4), .data_active_in(data_active_s3));
    aes_round aes_round_i5 (.clk(clk), .data_out(data_out_s5), .data_in(data_out_s4), .key_in(key_s4), .data_active_out(data_active_s5), .data_active_in(data_active_s4));
    aes_round aes_round_i6 (.clk(clk), .data_out(data_out_s6), .data_in(data_out_s5), .key_in(key_s5), .data_active_out(data_active_s6), .data_active_in(data_active_s5));
    aes_round aes_round_i7 (.clk(clk), .data_out(data_out_s7), .data_in(data_out_s6), .key_in(key_s6), .data_active_out(data_active_s7), .data_active_in(data_active_s6));
    aes_round aes_round_i8 (.clk(clk), .data_out(data_out_s8), .data_in(data_out_s7), .key_in(key_s7), .data_active_out(data_active_s8), .data_active_in(data_active_s7)); 
    aes_round aes_round_i9 (.clk(clk), .data_out(data_out_s9), .data_in(data_out_s8), .key_in(key_s8), .data_active_out(data_active_s9), .data_active_in(data_active_s8)); 
	    			
    last_round last_round_i0 (.clk(clk), .data_out(data_out), .data_in(data_out_s9), .key_in(key_s9), .data_active_out(data_out_active), .data_active_in(data_active_s9));    

endmodule
