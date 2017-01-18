LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY fsm_tb IS
END fsm_tb;

ARCHITECTURE behaviour OF fsm_tb IS

COMPONENT comments_fsm IS
PORT (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk, s_reset, s_output: STD_LOGIC := '0';
SIGNAL s_input: std_logic_vector(7 downto 0) := (others => '0');

CONSTANT clk_period : time := 1 ns;
CONSTANT SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
CONSTANT STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
CONSTANT NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

-- Test cases are implemented using arrays of 8-bit vectors.
-- Arrays of 16 characters are used as it is assumed that
-- 16-bits is enough to have a variety of transitions
-- representative of all useful test cases.
type test_case is array (0 to 15) of std_logic_vector(7 downto 0);

-- Case 1: "//comment\n code"
signal test_case1: test_case := ("00101111","00101111","01100011","01101111","01101101","01101101","01100101","01101110","01110100","00001010","00100000","01100011","01101111","01100100","01100101","00001010");

BEGIN
dut: comments_fsm
PORT MAP(clk, s_reset, s_input, s_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;

--TODO: Thoroughly test your FSM
stim_process: PROCESS

BEGIN
	REPORT "Example case, reading a meaningless character";
	--s_input <= "00101111";
	--WAIT FOR 1 * clk_period;
    ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0'" SEVERITY ERROR;
	REPORT "_______________________";

    report "Test case 1: h// tes*\n";
    for i in test_case1' range loop
      s_input <= test_case1(i);
      wait for 1 * clk_period;
    end loop;

	WAIT;
END PROCESS stim_process;
END;
