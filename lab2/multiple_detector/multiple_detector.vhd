------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------
ENTITY multiple_detector IS
	GENERIC (NUM_BITS: INTEGER := 5); --number of input bits
	PORT (a, b: IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
			is_multiple, invalid_inp: OUT STD_LOGIC);
END ENTITY;
-----------------------------
ARCHITECTURE multiple_detector of multiple_detector IS
	
BEGIN
	invalid_inp <= '1' WHEN (UNSIGNED(b) = to_unsigned(0, NUM_BITS)) ELSE
						'0';
	is_multiple <= '0' WHEN (UNSIGNED(b) = to_unsigned(0, NUM_BITS)) OR (UNSIGNED(a) = to_unsigned(0, NUM_BITS)) ELSE
						'1' WHEN (UNSIGNED(a) mod UNSIGNED(b)) = to_unsigned(0, NUM_BITS) ELSE
						'0';
END ARCHITECTURE;


