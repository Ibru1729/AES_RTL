`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 11:53:36 AM
// Design Name: 
// Module Name: key_expand
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


module key_expand(
    input clk,
    input key_active,
    input [127:0] key,
    output [127:0] key_s,
    output [127:0] key_s0,
    output [127:0] key_s1,
    output [127:0] key_s2,
    output [127:0] key_s3,
    output [127:0] key_s4,
    output [127:0] key_s5,
    output [127:0] key_s6,
    output [127:0] key_s7,
    output [127:0] key_s8,
    output [127:0] key_s9
    );
	
    wire [127:0] key_s_reg;
    wire [127:0] key_s0_reg;
    wire [127:0] key_s1_reg;
    wire [127:0] key_s2_reg;
    wire [127:0] key_s3_reg;
    wire [127:0] key_s4_reg;
    wire [127:0] key_s5_reg;
    wire [127:0] key_s6_reg;
    wire [127:0] key_s7_reg;
    wire [127:0] key_s8_reg;
    wire [127:0] key_s9_reg;


    wire key_en_s0;
    wire key_en_s1;
    wire key_en_s2;
    wire key_en_s3;
    wire key_en_s4;
    wire key_en_s5;
    wire key_en_s6;
    wire key_en_s7;
    wire key_en_s8;
    wire key_en_s9;

    assign key_s = key;

    key_subword key_subword_i0 (.clk(clk), .key_in(key), .key_out(key_s0_reg), .rcon(8'h01));
    assign key_s0 = key_s0_reg;

    key_subword key_subword_i1 (.clk(clk), .key_in(key_s0_reg), .key_out(key_s1_reg), .rcon(8'h02));
    assign key_s1 = key_s1_reg;
    	
    key_subword key_subword_i2 (.clk(clk), .key_in(key_s1_reg), .key_out(key_s2_reg), .rcon(8'h04));
    assign key_s2 = key_s2_reg;
    	
    key_subword key_subword_i3 (.clk(clk), .key_in(key_s2_reg), .key_out(key_s3_reg), .rcon(8'h08));
    assign key_s3 = key_s3_reg;
    	
    key_subword key_subword_i4 (.clk(clk), .key_in(key_s3_reg), .key_out(key_s4_reg), .rcon(8'h10));
    assign key_s4 = key_s4_reg;
    	
    key_subword key_subword_i5 (.clk(clk), .key_in(key_s4_reg), .key_out(key_s5_reg), .rcon(8'h20));
    assign key_s5 = key_s5_reg;
    	
    key_subword key_subword_i6 (.clk(clk), .key_in(key_s5_reg), .key_out(key_s6_reg), .rcon(8'h40));
    assign key_s6 = key_s6_reg;
    	
    key_subword key_subword_i7 (.clk(clk), .key_in(key_s6_reg), .key_out(key_s7_reg), .rcon(8'h80));
    assign key_s7 = key_s7_reg;
    	
    key_subword key_subword_i8 (.clk(clk), .key_in(key_s7_reg), .key_out(key_s8_reg), .rcon(8'h1b));
    assign key_s8 = key_s8_reg;
    	
    key_subword key_subword_i9 (.clk(clk), .key_in(key_s8_reg), .key_out(key_s9_reg), .rcon(8'h36));
    assign key_s9 = key_s9_reg;
    	

	

endmodule
