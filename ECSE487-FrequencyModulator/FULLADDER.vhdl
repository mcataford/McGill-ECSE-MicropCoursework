library IEEE;

use ieee.std_logic_1164.all;

entity FULLADDER is

port(
	Cin,A,B: in std_logic;
	Cout,S: out std_logic
);

end entity;

architecture FULLADDER_IMPL of FULLADDER is

begin

	S <= Cin xor A xor B;
	Cout <= (Cin and (A or B)) or (A and B);

end architecture;