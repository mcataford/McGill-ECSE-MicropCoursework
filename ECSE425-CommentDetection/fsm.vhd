library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

-- Signal that handles the current state of the FSM.
signal fsm_state: std_logic_vector(1 downto 0) := "00";

begin

-- Insert your processes here
process (clk, reset)
begin
  -- The change in state happens on the rising edge of the clock signal.
	if rising_edge(clk) then

    	case fsm_state is

        when "00" =>
        	if input = SLASH_CHARACTER then

            fsm_state <= "01";

            end if;

            output <= '0';

        when "01" =>
        	if (input = SLASH_CHARACTER) or (input = STAR_CHARACTER) then

            fsm_state <= "10";

            end if;

            output <= '0';

        when "10" =>
        	if input = NEW_LINE_CHARACTER then

            fsm_state <= "00";

            elsif input = STAR_CHARACTER then

            fsm_state <= "11";

            end if;

            output <= '1';

        when "11" =>
        	if input = SLASH_CHARACTER then

            fsm_state <= "00";

            end if;

            output <= '1';

        when others =>
        	fsm_state <= "00";

        end case;

    end if;

end process;

end behavioral;
