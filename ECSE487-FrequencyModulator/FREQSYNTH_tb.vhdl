library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FREQSYNTH_tb is
end entity;

architecture FREQSYNTH_tst of FREQSYNTH_tb is

--A 32MHz clock has a period of 31.25 ns
--A 64Mhz clock has a period of 15.625 ns
constant clk_period: time := 15.625 ns;

signal FREQ_CONTROL: integer;
signal CLOCK: std_logic;
signal OUTPUT: std_logic := '0';

component FREQSYNTH_ACC

port(
	FREQ_CONTROL: in integer;
	CLOCK: in std_logic;
	OUTPUT: out std_logic
);

end component;

begin

FS: FREQSYNTH_ACC port map(FREQ_CONTROL,CLOCK,OUTPUT);

process

begin

CLOCK <= '0';
wait for 0.5 * clk_period;
CLOCK <= '1';
wait for 0.5 * clk_period;

end process;

process 

begin

--Frequency to generate, in Mhz (1-32)
FREQ_CONTROL <= 20;

wait;

end process;

end architecture;