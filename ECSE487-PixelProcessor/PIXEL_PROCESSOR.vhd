library IEEE;
use ieee.std_logic_1164.all;

entity PIXEL_PROCESSOR is

port(
	PIXEL_DATA, PIXEL_OPERAND: in std_logic_vector(7 downto 0),
	OPERATION: in std_logic_vector(2 downto 0),
	RESET, CLOCK, ENABLE: in std_logic,
	DATA_OUT: out std_logic_vector(7 downto 0),
	DATA_VALID, ERROR: out std_logic
);

end PIXEL_PROCESSOR;

architecture PIXEL_PROCESSOR_IMPL of PIXEL_PROCESSOR is

begin



end PIXEL_PROCESSOR_IMPL;