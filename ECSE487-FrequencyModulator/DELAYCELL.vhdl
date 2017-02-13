library IEEE;

use ieee.std_logic_1164.all;


entity DELAYCELL is

port (

HOLDING, UPDATE_IN,CLOCK,R: in std_logic;
UPDATE_OUT,DELAY_OUT: out std_logic

);

end entity;

architecture DELAYCELL_IMPL of DELAYCELL is

signal D1_IN, D2_IN, D1_OUT, D2_OUT: std_logic;

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

D2_IN <= ((not D1_OUT) and D2_OUT) or (D1_OUT and HOLDING);

D1: D_FF_VHDL port map(CLOCK,R,'0','1',UPDATE_IN,D1_OUT);
D2: D_FF_VHDL port map(CLOCK,R,'0','1',D2_IN,D2_OUT);

DELAY_OUT <= D2_OUT;
UPDATE_OUT <= D1_OUT;



end architecture;