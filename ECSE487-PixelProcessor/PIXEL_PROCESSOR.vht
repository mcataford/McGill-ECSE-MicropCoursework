-- Copyright (C) 2016  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "01/26/2017 23:10:21"
                                                            
-- Vhdl Test Bench template for design  :  PIXEL_PROCESSOR
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;   
USE std.textio.all;                             

ENTITY PIXEL_PROCESSOR_vhd_tst IS
END PIXEL_PROCESSOR_vhd_tst;
ARCHITECTURE PIXEL_PROCESSOR_arch OF PIXEL_PROCESSOR_vhd_tst IS
-- constants  
constant clock_period : time := 1 ns;                                               
-- signals                                                   
SIGNAL CLOCK : STD_LOGIC;
SIGNAL DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL DATA_VALID : STD_LOGIC;
SIGNAL ENABLE : STD_LOGIC;
SIGNAL ERROR : STD_LOGIC;
SIGNAL OPERATION : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL PIXEL_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL PIXEL_OPERAND : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL RESET : STD_LOGIC;

signal EOF: bit := '0';
signal DATAREAD, DATASAVE: real;
signal LINENUMBER: integer := 1;

COMPONENT PIXEL_PROCESSOR
	PORT (
	CLOCK : IN STD_LOGIC;
	DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	DATA_VALID : OUT STD_LOGIC;
	ENABLE : IN STD_LOGIC;
	ERROR : OUT STD_LOGIC;
	OPERATION : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	PIXEL_DATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	PIXEL_OPERAND : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	RESET : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : PIXEL_PROCESSOR
	PORT MAP (
-- list connections between master ports and signals
	CLOCK => CLOCK,
	DATA_OUT => DATA_OUT,
	DATA_VALID => DATA_VALID,
	ENABLE => ENABLE,
	ERROR => ERROR,
	OPERATION => OPERATION,
	PIXEL_DATA => PIXEL_DATA,
	PIXEL_OPERAND => PIXEL_OPERAND,
	RESET => RESET
	);


-- Clock signal process
clock_signal : process
begin

	CLOCK <= '0';
	wait for clock_period / 2;
	CLOCK <= '1';
	wait for clock_period / 2; 

end process;   

reading: process(CLOCK)

file INFILE: text is in "test.txt";
variable INLINE: line;
variable DATAREAD1: real;

begin
	if rising_edge(CLOCK) then

		if not endfile(INFILE) then
			readline(INFILE, INLINE);
			read(INLINE, DATAREAD1);
			DATAREAD <= DATAREAD1;
			
		else
			EOF <= '1';
			
		end if;

	end if;
end process reading;

writing: process(CLOCK)

file OUTFILE: text is out "testout.txt";
variable OUTLINE: line;

begin

	if falling_edge(CLOCK) then
	
		if EOF = '0' then
		
			write(OUTLINE, DATAREAD, right, 16, 12);
			writeline(OUTFILE, OUTLINE);
			LINENUMBER <= LINENUMBER + 1;
		
		else
		
			null;
		
		end if;
	
	end if;

end process writing;


                                    
END PIXEL_PROCESSOR_arch;
