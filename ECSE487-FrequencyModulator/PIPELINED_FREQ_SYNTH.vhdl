library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PIPELINED_FREQ_SYNTH is

port(
	FREQ_CONTROL: in integer;
	CLOCK: in std_logic;
	R: in std_logic;
	UPDATE: in std_logic;
	OUTPUT: out std_logic
);

end entity;

architecture FREQ_SYNTH_IMPL of PIPELINED_FREQ_SYNTH is

signal FREQ_CONTROL_CONV: std_logic_vector(4 downto 0) := "00000";
signal UP1,UP2,UP3,UP4,UP5: std_logic;
signal C1,C2,C3,C4: std_logic;

component BITSLICE

port(
	FREQ_CTRL, CLOCK, Cin, R, UP_IN: in std_logic;
	Cout,UP_OUT: out std_logic
);

end component;

begin

FREQ_CONTROL_CONV <= std_logic_vector(to_unsigned(FREQ_CONTROL,5));

B1: BITSLICE port map(FREQ_CONTROL_CONV(0),CLOCK,'0',R,UPDATE,C1,UP1);
B2: BITSLICE port map(FREQ_CONTROL_CONV(1),CLOCK,C1,R,UP1,C2,UP2);
B3: BITSLICE port map(FREQ_CONTROL_CONV(2),CLOCK,C2,R,UP2,C3,UP3);
B4: BITSLICE port map(FREQ_CONTROL_CONV(3),CLOCK,C3,R,UP3,C4,UP4);
B5: BITSLICE port map(FREQ_CONTROL_CONV(4),CLOCK,C4,R,UP4,OUTPUT,UP5);

end architecture;