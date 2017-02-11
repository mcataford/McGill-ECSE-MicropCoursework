library IEEE;

use ieee.std_logic_1164.all;

entity FULLADDER_tb is
end entity;

architecture FULLADDER_tst of FULLADDER_tb is

signal A: std_logic := '0';
signal B: std_logic := '0';
signal Cin: std_logic := '0';
signal S: std_logic := '0';
signal Cout: std_logic := '0';

component FULLADDER

port(
A,B,Cin: in std_logic;
S,Cout: out std_logic
);

end component;

begin

FA: FULLADDER port map(A,B,Cin,S,Cout);

process
begin
	
	A <= '1';
	B <= '0';
	Cin <= '0';

	wait for 1 ns;
	
	assert (S = '1' and Cout = '0') report "1 + 0 + 0 != 1";

	A <= '0';
	B <= '1';
	Cin <= '0';

	wait for 1 ns;

	assert (S = '1' and Cout = '0') report "0 + 1 + 0 != 1";

	A <= '0';	
	B <= '0';
	Cin <= '1';

	wait for 1 ns;

	assert (S = '1' and Cout = '0') report "0 + 0 + 1 != 1";

	A <= '1';
	B <= '1';
	Cin <= '0';

	wait for 1 ns;

	assert (S = '0' and Cout = '1') report "1 + 1 + 0 != 0 (1)";

	A <= '0';
	B <= '1';
	Cin <= '1';

	wait for 1 ns;

	assert (S = '0' and Cout = '1') report "0 + 1 + 1 != 0 (1)";

	A <= '1';
	B <= '0';
	Cin <= '1';

	wait for 1 ns;

	assert (S = '0' and Cout = '1') report "1 + 0 + 1 != 0 (1)";

	A <= '1';
	B <= '1';
	Cin <= '1';
	
	wait for 1 ns;
	
	assert (S = '1' and Cout = '1') report "1 + 1 + 1 != 1 (1)";
	

	wait;
end process;
	
end architecture;
