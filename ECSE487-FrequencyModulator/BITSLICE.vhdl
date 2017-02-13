library IEEE;

use ieee.std_logic_1164.all;

entity BITSLICE is

port(
	FREQ_CTRL, CLOCK, Cin, R, UP_IN: in std_logic;
	Cout,UP_OUT: out std_logic
);

end entity;

architecture BITSLICE_IMPL of BITSLICE is

signal DELAY_OUT, HOLDING_OUT: std_logic;

component DELAYCELL

port (

HOLDING, UPDATE_IN,CLOCK,R: in std_logic;
UPDATE_OUT,DELAY_OUT: out std_logic

);

end component;

component ACCUMULATOR_CELL

port(
	CLOCK, DELAY_IN, Cin, R: in std_logic;
	Cout: out std_logic
);

end component;

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

HOLDING_REG: D_FF_VHDL port map(CLOCK,R,'0','1',FREQ_CTRL,HOLDING_OUT);
ACC: ACCUMULATOR_CELL port map(CLOCK, DELAY_OUT, Cin, R, Cout);
DELAY: DELAYCELL port map(HOLDING_OUT, UP_IN, CLOCK,R, UP_OUT,DELAY_OUT);

end architecture;