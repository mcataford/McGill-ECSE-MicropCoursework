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

--We define all of the signals used as current values of the ops.
signal current_op1, current_op2, current_op3, current_op4, current_op5: integer;

--We also define the signals that will be the 'next' value meant for the next cycle.
signal next_op1, next_op2, next_op3, next_op4, next_op5, next_final: integer;

--To force signals to be delayed until the right pipeline stage.
signal a_1, a_2, a_3, e_1, e_2, e_3, c_1, c_2, d_1, d_2, op2_1, op2_2, op2_3, op2_4, op3_1, op3_2 : integer;

begin
-- todo: complete this
process (clk)
begin

	if rising_edge(clk) then


		op1 <= current_op1;
		op2 <= current_op2;
		op2_1 <= current_op2;
		op2_2 <= op2_1;
		op2_3 <= op2_2;
		op2_4 <= op2_3;
		op3 <= current_op3;
		op3_1 <= current_op3;
		op3_2 <= op3_1;
		op4 <= current_op4;
		op5 <= current_op5;
		final_output <= next_final;

		current_op1 <= next_op1;
		current_op2 <= next_op2;
		current_op3 <= next_op3;
		current_op4 <= next_op4;
		current_op5 <= next_op5;

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

	end if;

end process;

next_op1 <= a + b;
next_op2 <= current_op1 * 42;
next_op3 <= c_2 * d_2;
next_op4 <= a_3 - e_3;
next_op5 <= op3_1 * current_op4;
next_final <= op2_3 - current_op5;

end behavioral;