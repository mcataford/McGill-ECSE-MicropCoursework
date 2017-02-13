library IEEE;

use ieee.std_logic_1164.all;

entity FIVEBREGISTER_tb is
end entity;

architecture FIVEBREGISTER_tst of FIVEBREGISTER_tb is

constant clk_period: time := 1 ns;

signal DATA: std_logic_vector(4 downto 0) := "00000";
signal DATA_OUT: std_logic_vector(4 downto 0);
signal CLOCK: std_logic := '0';
signal ENABLE: std_logic := '0';
signal RESET: std_logic := '0';
signal REGWRITE: std_logic := '0';

component FIVEBREGISTER

port(
	DATA: in std_logic_vector(4 downto 0);
	CLK, ENABLE, RESET, REGWRITE: in std_logic;
	DATA_OUT: out std_logic_vector(4 downto 0)
);

end component;

begin

REG: FIVEBREGISTER port map(DATA, CLOCK, ENABLE, RESET, REGWRITE, DATA_OUT);

process

begin

CLOCK <= '1';
wait for 0.5 * clk_period;
CLOCK <= '0';
wait for 0.5 * clk_period;

end process;

process

begin

ENABLE <= '1';

REGWRITE <= '1';
DATA <= "10101";

wait for 1 * clk_period;

REGWRITE <= '0';
DATA <= "01010";

wait for 1 * clk_period;

RESET <= '1';

wait for 1 * clk_period;

RESET <= '0';

wait;

end process;

end architecture;