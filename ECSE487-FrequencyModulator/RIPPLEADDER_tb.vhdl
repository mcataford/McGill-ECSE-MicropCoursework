library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RIPPLEADDER_tb is
end entity;

architecture RIPPLADDER_tst of RIPPLEADDER_tb is

signal A,B,S: std_logic_vector(4 downto 0);
signal Cout: std_logic;

component RIPPLEADDER

port(
	A: in std_logic_vector(4 downto 0);
	B: in std_logic_vector(4 downto 0);
	S: out std_logic_vector(4 downto 0);
	Cout: out std_logic
);

end component;

begin

RA: RIPPLEADDER port map(A,B,S,Cout);

process

begin

--The range of possible numbers is a 5-bit unsigned

for i in 0 to 31 loop

for j in 0 to 31 loop

A <= std_logic_vector(to_unsigned(i,5));
B <= std_logic_vector(to_unsigned(j,5));

wait for 1 ns;

end loop;

end loop;

wait;

end process;

end architecture;