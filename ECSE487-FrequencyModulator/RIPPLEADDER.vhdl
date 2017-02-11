library IEEE;

use ieee.std_logic_1164.all;

entity RIPPLEADDER is

port(
	A,B: in std_logic_vector(4 downto 0);
	S: out std_logic_vector(4 downto 0);
	Cout: out std_logic
);

end entity;

architecture RIPPLEADDER_IMPL of RIPPLEADDER is

signal S1,S2,S3,S4,S5: std_logic := '0';
signal C1,C2,C3,C4,C5: std_logic := '0';

component FULLADDER

port(
A,B,Cin: in std_logic;
S,Cout: out std_logic
);

end component;

begin

FA1: FULLADDER port map(A(4),B(4),'0',S1,C1);
FA2: FULLADDER port map(A(3),B(3),C1,S2,C2);
FA3: FULLADDER port map(A(2),B(2),C2,S3,C3);
FA4: FULLADDER port map(A(1),B(1),C3,S4,C4);
FA5: FULLADDER port map(A(0),B(0),C4,S5,C5);

Cout <= C5;
S <= S1 & S2 & s3 & S4 & S5;

end architecture;