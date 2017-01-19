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

-- fsm_state has four possible states.
-- State A: Detection of the first part of the comment opening (/) Output=0
-- State B: Detection of the second part of the comment opening (* or /) Output=0
-- State C: Detection of the first part of the comment closing (* or \n) Output=1
-- State D: Detection of the second part of the comment closing (/) Output=1

--It is assumed that if a comment is opened, the FSM will remain in State C or D until a full closing sequence is detected.
signal fsm_state: std_logic_vector(1 downto 0) := "00";

-- Comment type, 0 if initiated by //, 1 for /*
signal comment_type: std_logic := '0';

begin

process (clk, reset)
begin

  -- Since unspecified, an asynchronous reset has been implemented.
  -- This decision is supported by the inclusion of the reset signal in the sensitivity list.
  if reset = '1' then

  	fsm_state <= "00";

  end if;

  -- State change and state behaviour only happens on rising edge events.
  if rising_edge(clk) then
	-- Switch based on the current state.
    case fsm_state is

	-- State A: Detect the start of a comment, output 0.
    when "00" =>
      -- Start of a comment is always /
      if input = SLASH_CHARACTER then
		-- If detected, go to State B, otherwise remain A.
        fsm_state <= "01";

      end if;

      output <= '0';

	-- State B: Detect the second char. of the start of a comment, output 0.
    when "01" =>
      -- Second stage of starting a comment is either / or *
      if input = SLASH_CHARACTER then
		  -- If detected, go the state C, otherwise back to A.
        fsm_state <= "10";
        comment_type <= '0';

      elsif input = STAR_CHARACTER then
        fsm_state <= "10";
        comment_type <= '1';

      else
        fsm_state <= "00";

      end if;

      output <= '0';

	-- State C: Detect the end of a comment, output 1 since presently inside a comment.
	when "10" =>
      -- If \n, the comment ends now, back to state A for comment opening detection.
	  if (input = NEW_LINE_CHARACTER) and (comment_type = '0') then

		  fsm_state <= "00";

	  -- If *, start of the end-comment sequence */, go to state D.
	  elsif (input = STAR_CHARACTER) and (comment_type = '1') then

	    fsm_state <= "11";

	  end if;

	  output <= '1';

	-- State D: Detect the end of a comment of the form /* */, output 1 since inside comment.
    when "11" =>
      -- If /, end of the comment end sequence for /* */ comments, back to state A.
      if input = SLASH_CHARACTER then

        fsm_state <= "00";

      -- Else, back to the detection of the start of the comment end sequence, state C.
      else

        fsm_state <= "10";

      end if;

      output <= '1';

	-- If unrecognized state, reset to state A.
    when others =>
      fsm_state <= "00";

    end case;

  end if;

end process;

end behavioral;
