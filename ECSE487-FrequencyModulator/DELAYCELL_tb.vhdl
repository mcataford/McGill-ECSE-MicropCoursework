library IEEE;

use ieee.std_logic_1164.all;

entity DELAYCELL_tb is
end entity;

architecture DELAYCELL_tst of DELAYCELL_tb is

constant clk_period: time := 1 ns;

signal HOLDING, UPDATE_IN, UPDATE_OUT, DELAY_OUT,R: std_logic;
signal CLOCK: std_logic;

component DELAYCELL

port (

HOLDING, UPDATE_IN,CLOCK,R: in std_logic;
UPDATE_OUT,DELAY_OUT: out std_logic

);

end component;

begin

DC: DELAYCELL port map(HOLDING, UPDATE_IN, CLOCK,R, UPDATE_OUT, DELAY_OUT);

process

begin

R <= '1';
wait for 1 * clk_period;
R <='0';
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

UPDATE_IN <= '0';
HOLDING <= '0';

wait for 1 * clk_period;

UPDATE_IN <= '1';

wait for 1 * clk_period;

UPDATE_IN <= '0';

wait for 1 * clk_period;

HOLDING <= '1';

wait for 1 * clk_period;

HOLDING <= '0';

wait for 1 * clk_period;

HOLDING <= '1';
UPDATE_IN <= '1';

wait for 1 * clk_period;

wait;

end process;

end architecture;
