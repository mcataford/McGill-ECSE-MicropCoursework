library IEEE;

use ieee.std_logic_1164.all;

entity RIPPLEADDER_tb is
end entity;

architecture RIPPLADDER_tst of RIPPLEADDER_tb is

signal A,B,S: std_logic_vector(4 downto 0);
signal Cout: std_logic;

component RIPPLEADDER

port(
	A,B: in std_logic_vector(4 downto 0);
	S: out std_logic_vector(4 downto 0);
	Cout: out std_logic
);

end component;

begin

RA: RIPPLEADDER port map(A,B,S,Cout);

process

begin



end process;


end architecture;