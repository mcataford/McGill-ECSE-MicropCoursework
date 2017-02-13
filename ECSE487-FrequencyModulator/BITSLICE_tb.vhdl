library IEEE;

use ieee.std_logic_1164.all;

entity BITSLICE_tb is
end entity;

architecture BITSLICE_tst of BITSLICE_tb is

constant clk_period: time := 1 ns;

signal FREQ_CTRL, CLOCK, Cin, R, UP_IN, Cout, UP_OUT: std_logic;

component BITSLICE

port(
	FREQ_CTRL, CLOCK, Cin, R, UP_IN: in std_logic;
	Cout,UP_OUT: out std_logic
);

end component;

begin

BS: BITSLICE port map(FREQ_CTRL,CLOCK,Cin,R,UP_IN,Cout,UP_OUT);

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

FREQ_CTRL <= '1';
UP_IN <= '1';
Cin <= '0';
wait for 1 * clk_period;

UP_IN <= '1';

Cin <= '1';

wait for 1 * clk_period;

Cin <= '0';
wait;

end process;

end architecture;
