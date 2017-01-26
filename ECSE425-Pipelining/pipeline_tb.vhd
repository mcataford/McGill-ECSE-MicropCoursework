LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

ENTITY pipeline_tb IS
END pipeline_tb;

ARCHITECTURE behaviour OF pipeline_tb IS

COMPONENT pipeline IS
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk: STD_LOGIC := '0';
SIGNAL s_a, s_b, s_c, s_d, s_e : INTEGER := 0;
SIGNAL s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output : INTEGER := 0;

CONSTANT clk_period : time := 1 ns;

BEGIN
dut: pipeline
PORT MAP(clk, s_a, s_b, s_c, s_d, s_e, s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;
 

stim_process: PROCESS
BEGIN   
	
	-- Testing for exactitude using the given input and asserting for correct output at each stage.
	s_a <= 1;
	s_b <= 2;
	s_c <= 3;
	s_d <= 4;
	s_e <= 5;
	wait for 1 * clk_period;

	--Flushing the pipeline with zero'ed input to pad the results we're looking for.
	s_a <= 0;
	s_b <= 0;
	s_c <= 0;
	s_d <= 0;
	s_e <= 0;

	-- Asserting the first stage.
	assert(s_op1 = 3) report "op1 should = 3 after 1 CC, but was " & integer'image(s_op1) severity ERROR;
	wait for 1 * clk_period;
	-- Asserting the second stage.
	assert(s_op2 = 126) report "op2 should = 126 after 2 CC, but was " & integer'image(s_op2) severity ERROR;
	wait for 1 * clk_period;
	-- Asserting the third stage.
	assert(s_op3 = 12) report "op3 should = 12 after 3 CC, but was " & integer'image(s_op3) severity ERROR;
	wait for 1 * clk_period;
	-- Asserting the fourth stage.
	assert(s_op4 = -4) report "op4 should = -4 after 4 CC, but was " & integer'image(s_op4) severity ERROR;
	wait for 1 * clk_period;
	-- Asserting the fifth stage and the final output.
	assert(s_op5 = -48) report "op5 should = 12 after 5 CC, but was " & integer'image(s_op5) severity ERROR;
	assert(s_final_output = 174) report "final_output should = 174 after 5 CC, but was " & integer'image(s_final_output) severity ERROR;
	wait for 1 * clk_period;
	-- Asserting that the zero'ed output flushed all of the previous input after one full pipeline cycle.
	assert(s_op1 = 0) report "op1 should = 0 after 6 CC, but was " & integer'image(s_op1) severity ERROR;
	assert(s_op2 = 0) report "op2 should = 0 after 6 CC, but was " & integer'image(s_op2) severity ERROR;
	assert(s_op3 = 0) report "op3 should = 0 after 6 CC, but was " & integer'image(s_op3) severity ERROR;
	assert(s_op4 = 0) report "op4 should = 0 after 6 CC, but was " & integer'image(s_op4) severity ERROR;
	assert(s_op5 = 0) report "op5 should = 0 after 6 CC, but was " & integer'image(s_op5) severity ERROR;
	assert(s_final_output = 0) report "final_output should = 0 after 6 CC, but was " & integer'image(s_final_output) severity ERROR;

	-- Filling the pipeline with 10 cycles of input to fill it up, have it full and then let it drain out.

	s_a <= 1;
	s_b <= 2;
	s_c <= 3;
	s_d <= 4;
	s_e <= 5;
	wait for 1 * clk_period;

	s_a <= 2;
	s_b <= 3;
	s_c <= 4;
	s_d <= 5;
	s_e <= 6;
	wait for 1 * clk_period;

	-- Asserting that the pipeline is filling (2/5 full)
	assert(s_op1 /= 0) report "op1 should /= 0 after 2 CC, but was " & integer'image(s_op1) severity ERROR;
	assert(s_op2 /= 0) report "op2 should /= 0 after 2 CC, but was " & integer'image(s_op2) severity ERROR;
	assert(s_op3 = 0) report "op3 should = 0 after 2 CC, but was " & integer'image(s_op3) severity ERROR;
	assert(s_op4 = 0) report "op4 should = 0 after 2 CC, but was " & integer'image(s_op4) severity ERROR;
	assert(s_op5 = 0) report "op5 should = 0 after 2 CC, but was " & integer'image(s_op5) severity ERROR;
	assert(s_final_output = 0) report "final_output should = 0 after 2 CC, but was " & integer'image(s_final_output) severity ERROR;

	s_a <= 3;
	s_b <= 4;
	s_c <= 5;
	s_d <= 6;
	s_e <= 7;
	wait for 1 * clk_period;

	s_a <= 4;
	s_b <= 5;
	s_c <= 6;
	s_d <= 7;
	s_e <= 8;
	wait for 1 * clk_period;

	s_a <= 5;
	s_b <= 6;
	s_c <= 7;
	s_d <= 8;
	s_e <= 9;
	wait for 1 * clk_period;

	-- Asserting that the pipeline is full, i.e. all the outputs are active at once.
	assert(s_op1 /= 0) report "op1 should /= 0 after 6 CC, but was " & integer'image(s_op1) severity ERROR;
	assert(s_op2 /= 0) report "op2 should /= 0 after 6 CC, but was " & integer'image(s_op2) severity ERROR;
	assert(s_op3 /= 0) report "op3 should /= 0 after 6 CC, but was " & integer'image(s_op3) severity ERROR;
	assert(s_op4 /= 0) report "op4 should /= 0 after 6 CC, but was " & integer'image(s_op4) severity ERROR;
	assert(s_op5 /= 0) report "op5 should /= 0 after 6 CC, but was " & integer'image(s_op5) severity ERROR;
	assert(s_final_output /= 0) report "final_output should /= 0 after 6 CC, but was " & integer'image(s_final_output) severity ERROR;

	s_a <= 1;
	s_b <= 2;
	s_c <= 3;
	s_d <= 4;
	s_e <= 5;
	wait for 1 * clk_period;

	s_a <= 2;
	s_b <= 3;
	s_c <= 4;
	s_d <= 5;
	s_e <= 6;
	wait for 1 * clk_period;

	s_a <= 3;
	s_b <= 4;
	s_c <= 5;
	s_d <= 6;
	s_e <= 7;
	wait for 1 * clk_period;

	s_a <= 4;
	s_b <= 5;
	s_c <= 6;
	s_d <= 7;
	s_e <= 8;
	wait for 1 * clk_period;

	s_a <= 5;
	s_b <= 6;
	s_c <= 7;
	s_d <= 8;
	s_e <= 9;
	wait for 1 * clk_period;

	-- Flushing the pipeline with zero input.

	s_a <= 0;
	s_b <= 0;
	s_c <= 0;
	s_d <= 0;
	s_e <= 0;
	wait for 5 * clk_period;

	-- Asserting that the zero'ed output flushed all of the previous input after one full pipeline cycle.
	assert(s_op1 = 0) report "op1 should = 0 after 11 CC, but was " & integer'image(s_op1) severity ERROR;
	assert(s_op2 = 0) report "op2 should = 0 after 11 CC, but was " & integer'image(s_op2) severity ERROR;
	assert(s_op3 = 0) report "op3 should = 0 after 11 CC, but was " & integer'image(s_op3) severity ERROR;
	assert(s_op4 = 0) report "op4 should = 0 after 11 CC, but was " & integer'image(s_op4) severity ERROR;
	assert(s_op5 = 0) report "op5 should = 0 after 11 CC, but was " & integer'image(s_op5) severity ERROR;
	assert(s_final_output = 0) report "final_output should = 0 after 6 CC, but was " & integer'image(s_final_output) severity ERROR;

	WAIT;
END PROCESS stim_process;
END;
