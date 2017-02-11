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

type STATE_TYPE is (A, B, C);
type NUMBERS is array (9 downto 0) of std_logic_vector(7 downto 0);

signal MAXVAL: integer := 255;
signal STATE: STATE_TYPE := A;

constant P: std_logic_vector(7 downto 0) := "01010000";
constant ASCII_NUMBERS: NUMBERS := ("00110000","00110001","00110010","00110011","00110100","00110101","00110110","00110111","00111000","00111001");

begin

	process(CLOCK)
	begin

		--Only act on the rising edge for synchronous processing.
		if rising_edge(CLOCK) then
			
			case STATE is

			when A =>
				if PIXEL_DATA = P then
					STATE <= B;
				else
					ERROR <= '1';
				end if;

			when B =>
				if PIXEL_DATA = ASCII_NUMBERS(2) then
					STATE <= C;
				else
					ERROR <= '1';
				end if;

			when C =>
		
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

			end case;

			--Since the design is a single-stage pipeline, the data is valid after 1 clock cycle.
			DATA_VALID <= ENABLE;
				
		end if;
	end process;



end PIXEL_PROCESSOR_IMPL;