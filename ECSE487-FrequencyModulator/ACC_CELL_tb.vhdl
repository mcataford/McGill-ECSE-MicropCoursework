library IEEE;

use ieee.std_logic_1164.all;

entity ACC_CELL_tb is
end entity;

architecture ACC_CELL_tst of ACC_CELL_tb is

constant clk_period: time := 1 ns;

signal CLOCK, DELAY_IN, Cin, Cout,R: std_logic;

component ACCUMULATOR_CELL

port(
	CLOCK, DELAY_IN, Cin, R: in std_logic;
	Cout: out std_logic
);

end component;

begin

ACC_C: ACCUMULATOR_CELL port map(CLOCK, DELAY_IN, Cin, R, Cout);

process

begin

R <= '1';
wait for 1 * clk_period;
R <= '0';

wait;

end process;

process

begin

CLOCK <= '0';
wait for 0.5 * clk_period;
CLOCK <= '1';
wait for 0.5 * clk_period;

end process;

process 

begin

DELAY_IN <= '0';
Cin <= '0';

wait for 1 * clk_period;

DELAY_IN <= '1';

wait for 1 * clk_period;

DELAY_IN <= '0';

wait for 1 * clk_period;

Cin <= '1';

wait for 1 * clk_period;

Cin <= '0';

wait for 1 * clk_period;

DELAY_IN <= '1';
Cin <= '1';

wait for 1 * clk_period;

DELAY_IN <= '0';

wait;

end process;

end architecture;
