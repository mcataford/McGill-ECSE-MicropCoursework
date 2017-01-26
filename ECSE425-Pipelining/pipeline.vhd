library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
end pipeline;

architecture behavioral of pipeline is

-- Signals used to define values at present time, used for calculation of next step.
signal current_op1, current_op2, current_op3, current_op4, current_op5: integer;

-- Signals used to store the result that will be pushed to the current state at the next step.
signal next_op1, next_op2, next_op3, next_op4, next_op5, next_final: integer;

-- Intermediate signals used to delay inputs that need to be preserved for future steps.
signal a_1, a_2, a_3, e_1, e_2, e_3, c_1, c_2, d_1, d_2, op2_1, op2_2, op2_3, op2_4, op3_1, op3_2 : integer;

begin
process (clk)
begin
	-- Act on the rising edge
	if rising_edge(clk) then

		-- Setting the new values for the outputs.

		current_op1 <= next_op1;
		current_op2 <= next_op2;
		current_op3 <= next_op3;
		current_op4 <= next_op4;
		current_op5 <= next_op5;

		-- The intermediates are advanced by one step.

		a_1 <= a;
		a_2 <= a_1;
		a_3 <= a_2;
		e_1 <= e;
		e_2 <= e_1;
		e_3 <= e_2;
		c_1 <= c;
		c_2 <= c_1;
		d_1 <= d;
		d_2 <= d_1;

		op2_2 <= op2_1;
		op2_3 <= op2_2;
		op3_1 <= current_op3;
		op2_1 <= current_op2;	
	end if;

end process;

-- Calculation of the next cycle's values.
next_op1 <= a + b;
next_op2 <= current_op1 * 42;
next_op3 <= c_2 * d_2;
next_op4 <= a_3 - e_3;
next_op5 <= op3_1 * current_op4;
next_final <= op2_3 - current_op5;

-- Assign. of the output values based on the current value of each intermediate.
op1 <= current_op1;
op2 <= current_op2;
op3 <= current_op3;
op4 <= current_op4;
op5 <= current_op5;
final_output <= next_final;


end behavioral;