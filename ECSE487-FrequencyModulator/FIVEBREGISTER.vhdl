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

--The data is stored in a 5-bit wide signal.
signal MEM: std_logic_vector(4 downto 0) := "00000";

begin

--The register is sync'd with the clock signal.
process(CLK)

begin
	--Clock sync
	if rising_edge(CLK) then
		--Only operate if enabled.
		if ENABLE = '1' then
			--Reset is synchronous.
			if RESET = '1' then
				MEM <= (others => '0');
			--The REGWRITE signal gates the register writing.
			elsif REGWRITE = '1' then
				MEM <= DATA;		
			end if;
			--If the register is enabled, its output is always its content.
			
		end if;

	end if;

	DATA_OUT <= MEM;

end process;

end architecture;
