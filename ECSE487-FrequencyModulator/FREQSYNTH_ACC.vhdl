library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FREQSYNTH_ACC is

port(
	FREQ_CONTROL: in integer;
	CLOCK: in std_logic;
	OUTPUT: out std_logic
);

end entity;

architecture FREQSYNTH_IMPL of FREQSYNTH_ACC is

signal REGISTER_OUT: std_logic_vector(4 downto 0);
signal FREQ_CONTROL_CONV: std_logic_vector(4 downto 0);
signal REGISTER_IN: std_logic_vector(4 downto 0);
signal REG_E: std_logic;
signal REG_R: std_logic;
signal REG_W: std_logic;

component RIPPLEADDER

port(
	A,B: in std_logic_vector(4 downto 0);
	S: out std_logic_vector(4 downto 0);
	Cout: out std_logic
);

end component;

component FIVEBREGISTER

port(
	DATA: in std_logic_vector(4 downto 0);
	CLK, ENABLE, RESET, REGWRITE: in std_logic;
	DATA_OUT: out std_logic_vector(4 downto 0)
);

end component;

begin

--Invariants
REG_W <= '1';
REG_E <= '1';
REG_R <= '0';

FREQ_CONTROL_CONV <= std_logic_vector(to_unsigned(FREQ_CONTROL,5));

RCA: RIPPLEADDER port map(FREQ_CONTROL_CONV, REGISTER_OUT, REGISTER_IN, OUTPUT);
REG: FIVEBREGISTER port map(REGISTER_IN, CLOCK, REG_E, REG_R, REG_W, REGISTER_OUT);

end architecture;