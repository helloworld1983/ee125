
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all;
----------------------------

ENTITY counter_leading_ones IS 
	GENERIC (
		-- number of input bits
		BITS: INTEGER := 8
		);
	PORT (
		-- input in stl format
		x: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
		--num of bits, take the log base 2, then convert to an int. we redefine this because vhdl sucks
		y: OUT STD_LOGIC_VECTOR((integer(log2(real(BITS)))) DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE sequential OF counter_leading_ones IS 
BEGIN
	counter: PROCESS(x)
		variable count: UNSIGNED(y'RANGE);-- := to_unsigned(0, y'LENGTH);
	BEGIN
		count := to_unsigned(0, y'LENGTH);
		FOR i IN x'RANGE LOOP
         CASE x(i) IS
            WHEN '1' => count := count + 1;
            WHEN OTHERS => EXIT;
			END CASE;
		END LOOP;
		y <= std_logic_vector(count);
	END PROCESS counter;
END ARCHITECTURE;