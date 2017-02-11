library IEEE;

use ieee.std_logic_1164.all;

entity FIVEBREGISTER is

port(
	DATA: in std_logic_vector(4 downto 0);
	CLK, ENABLE, RESET, REGWRITE: in std_logic;
	DATA_OUT: out std_logic_vector(4 downto 0)
);

end entity;

architecture FIVEBREGISTER_IMPL of FIVEBREGISTER is

signal MEM: std_logic_vector(4 downto 0);

begin

process(CLK)

begin

	if rising_edge(CLK) then

		if ENABLE = '1' then


			if RESET = '1' then
				MEM <= (others => '0');
			elsif REGWRITE = '1' then
				MEM <= DATA;		
			end if;

			DATA_OUT <= MEM;
			
		end if;

	end if;

end process;

end architecture;
