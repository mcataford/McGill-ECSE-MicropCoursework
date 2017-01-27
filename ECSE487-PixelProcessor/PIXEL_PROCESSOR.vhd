library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PIXEL_PROCESSOR is

port(
	PIXEL_DATA, PIXEL_OPERAND: in std_logic_vector(7 downto 0);
	OPERATION: in std_logic_vector(2 downto 0);
	RESET, CLOCK, ENABLE: in std_logic;
	DATA_OUT: out std_logic_vector(7 downto 0);
	DATA_VALID, ERROR: out std_logic
);

end PIXEL_PROCESSOR;

architecture PIXEL_PROCESSOR_IMPL of PIXEL_PROCESSOR is

signal MAXVAL: integer := 255;

begin

	process(CLOCK)
	begin

		--Only act on the rising edge for synchronous processing.
		if rising_edge(CLOCK) then
		
			case OPERATION is
			
				-- SET: set pixel to a specified value (DATA_OUT = PIXEL_OPERAND)
				when "000" =>
					DATA_OUT <= PIXEL_OPERAND;
					
				-- ADD: add a value to the pixel. (DATA_OUT = PIXEL_DATA + PIXEL_OPERAND)
				when "001" =>
					DATA_OUT <= std_logic_vector(to_unsigned(to_integer(unsigned(PIXEL_DATA)) + to_integer(unsigned(PIXEL_OPERAND)),8));
					
				-- SUB: Subtract a value from the pixel (DATA_OUT = PIXEL_DATA - PIXEL_OPERAND)
				when "010" =>
					DATA_OUT <= std_logic_vector(to_unsigned(to_integer(unsigned(PIXEL_DATA)) - to_integer(unsigned(PIXEL_OPERAND)),8));
				
				-- AND: AND a value to the pixel (DATA_OUT = PIXEL_DATA & PIXEL_OPERAND)
				when "011" => 
					DATA_OUT <= PIXEL_DATA and PIXEL_OPERAND;
					
				-- OR: OR a value to the pixel (DATA_OUT = PIXEL_DATA | PIXEL_OPERAND)
				when "100" =>
					DATA_OUT <= PIXEL_DATA or PIXEL_OPERAND;
					
				-- XOR: XOR a value with the pixel (DATA_OUT = PIXEL_DATA XOR PIXEL_OPERAND)
				when "101" =>
					DATA_OUT <= PIXEL_DATA xor PIXEL_OPERAND;
					
				-- INVERT: Invert a pixel (Subtract from MAXVAL)
				when "110" =>
					DATA_OUT <= std_logic_vector(to_unsigned(MAXVAL - to_integer(unsigned(PIXEL_DATA)),8));
					
				-- THRESH: Threshold pixel (output is MAXVAL if PIXEL_DATA > PIXEL_OPERAND)
				when "111" => 
					if to_integer(unsigned(PIXEL_DATA)) > to_integer(unsigned(PIXEL_OPERAND)) then
						DATA_OUT <= std_logic_vector(to_unsigned(MAXVAL,8));
					else
						DATA_OUT <= PIXEL_DATA;
					end if;
				when others =>
					ERROR <= '1';
			
			end case;
		
		
		
		end if;
	end process;



end PIXEL_PROCESSOR_IMPL;