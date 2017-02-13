library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PIPELINED_FS_tb is
end entity;

architecture FREQSYNTH_tst of PIPELINED_FS_tb is

constant clk_period: time := 15.625 ns;

signal FREQ_CONTROL: integer;
signal CLOCK, R, UPDATE, OUTPUT: std_logic;

component PIPELINED_FREQ_SYNTH

port(
	FREQ_CONTROL: in integer;
	CLOCK: in std_logic;
	R: in std_logic;
	UPDATE: in std_logic;
	OUTPUT: out std_logic
);

end component;

begin

FS: PIPELINED_FREQ_SYNTH port map(FREQ_CONTROL,CLOCK,R,UPDATE,OUTPUT);

process
begin

CLOCK <= '0';
wait for 0.5 * clk_period;
CLOCK <= '1';
wait for 0.5 * clk_period;

end process;

process
begin

R <= '1';
wait for 1 * clk_period;
R <= '0';
wait;

end process;

process

begin

wait for 1 * clk_period;

FREQ_CONTROL <= 16;
UPDATE <= '1';

wait for 1 * clk_period;

UPDATE <= '0';

wait;

end process;
end architecture;