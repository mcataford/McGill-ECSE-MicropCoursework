library IEEE;

use ieee.std_logic_1164.all;

entity ACCUMULATOR_CELL is

port(
	CLOCK, DELAY_IN, Cin,R: in std_logic;
	Cout: out std_logic
);

end entity;

architecture ACCUMULATOR_CELL_IMPL of ACCUMULATOR_CELL is

signal D1_IN: std_logic := '0';
signal D1_OUT: std_logic := '0';
signal D2_IN: std_logic := '0';
signal D2_OUT: std_logic := '0';

component D_FF_VHDL

   port
   (
      clk : in std_logic;

      rst : in std_logic;
      pre : in std_logic;
      ce  : in std_logic;
      
      d : in std_logic;

      q : out std_logic
   );

end component;

begin

D1_IN <= Cin xor DELAY_IN xor D1_OUT;
D2_IN <= (Cin and DELAY_IN) or (Cin and D1_OUT) or (D1_OUT and DELAY_IN);

D1: D_FF_VHDL port map(CLOCK,R,'0','1', D1_IN, D1_OUT);
D2: D_FF_VHDL port map(CLOCK,R,'0','1', D2_IN, Cout);

end architecture;