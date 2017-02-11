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

------------------------ TEST CASES DEFINITION ----------------------------
-- Test cases are implemented using arrays of 8-bit vectors.
-- Arrays of 10 characters are used as it allows for all the possible transition
-- scenarios.
type test_case is array (0 to 9) of std_logic_vector(7 downto 0);

-- Case 1: "a/a*b\ncode"
-- Transition from state A to A (starting character A doesn't start a comment)
-- Transition from state A to B (detection of / to start a comment open sequence)
-- Transition from state B to A (failure to finish comment opening sequence // or /*)

signal test_case1: test_case := ("01100001","00101111","01100001","00101010","01100010","00001010","01100011","01101111","01100100","01100101");

-- Case 2: "//code\nabc"
-- Transition from state A to B (First char. of comment opening sequence)
-- Transition from state B to C (Second char of comment opening sequence)
-- Transition from state C to C (Content of a comment that isn't the start of a closing sequence)
-- Transition from state C to A (End of a // comment using \n)

signal test_case2: test_case := ("00101111","00101111","01100011","01101111","01100100","01100101","00001010","01100001","01100010","01100011");

-- Case 3: "/*code\na*/"
-- Transition from state A to B, opening of a comment using /
-- Transition from state B to C, opening of a comment 2 using *
-- Transition from state C to A, end of a /* comment using \n

signal test_case3: test_case := ("00101111","00101010","01100011","01101111","01100100","01100101","00001010","01100001","00101010","00101111");


-------------------END OF TEST CASES DEFINITION --------------------------

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
	--REPORT "Example case, reading a meaningless character";
	--s_input <= "00101111";
	--WAIT FOR 1 * clk_period;
    --ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0'" SEVERITY ERROR;
	--REPORT "_______________________";

    report "Test case 1: abcdefgh";
    for i in test_case1' range loop
      s_input <= test_case1(i);
      wait for 1 * clk_period;
    end loop;

    report "Test case 2: /abcdefg";
    for i in test_case2' range loop
      s_input <= test_case2(i);
      wait for 1 * clk_period;
    end loop;

    report "Test case 3: /abcdefg";
    for i in test_case3' range loop
      s_input <= test_case3(i);
      wait for 1 * clk_period;
    end loop;

    report "Test case 3: /abcdefg";
    s_reset <= '1';
    for i in test_case3' range loop
      s_input <= test_case3(i);
      wait for 1 * clk_period;
    end loop;
    s_reset <= '0';

	WAIT;
END PROCESS stim_process;
END;
