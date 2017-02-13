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

--Intermediate signals for inter-FA communication.
signal S1,S2,S3,S4,S5: std_logic;
signal C1,C2,C3,C4: std_logic;

begin

--Each adder is modeled on the following provided equations:
--S = A xor B xor Cin
--Cout = Cin and (A or B) or A and B
--
--Each FA being 1-bit, the carry-out is used as the carry-in
--of the next FA in line, the last carry-out is reported as output.
--
--It is assumed that the first carry-in is 0, hence why the first FA 
--has different equations than the rest.

--Full adder #1
S1 <= A(0) xor B(0);
C1 <= A(0) and B(0);

--Full adder #2
S2 <= A(1) xor B(1) xor C1;
C2 <= (C1 and (A(1) or B(1))) or (A(1) and B(1));

--Full adder #3
S3 <= A(2) xor B(2) xor C2;
C3 <= (C2 and (A(2) or B(2))) or (A(2) and B(2));

--Full adder #4
S4 <= A(3) xor B(3) xor C3;
C4 <= (C3 and (A(3) or B(3))) or (A(3) and B(3));

--Full adder #5
S5 <= A(4) xor B(4) xor C4;
Cout <= (C4 and (A(4) or B(4))) or (A(4) and B(4));

--The bits of the sum are collected and concatenated into
--a 5-bit vector.
S <= S5 & S4 & S3 & S2 & S1;

end architecture;