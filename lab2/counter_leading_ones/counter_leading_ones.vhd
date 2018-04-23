----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all; -- is this kosher?
----------------------------


ENTITY counter_leading_ones IS 
	GENERIC (
		BITS: INTEGER := 8
		); -- number of input bits
	PORT (
		x: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
		y: OUT STD_LOGIC_VECTOR((integer(log2(real(BITS)))) DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE counter_leading_ones OF counter_leading_ones IS
	TYPE output_array IS ARRAY(NATURAL RANGE <>) OF UNSIGNED(integer(log2(real(BITS))) DOWNTO 0);
	SIGNAL output: output_array(BITS-1 DOWNTO 0) := (others => 4b"0");
	TYPE zero_found_array IS ARRAY(NATURAL RANGE <>) OF BOOLEAN;
	SIGNAL zero_found: zero_found_array(BITS-1 DOWNTO 0) := (others => FALSE);
BEGIN
	output(BITS-1)(0) <= x(BITS-1); 
	zero_found(BITS-1) <= FALSE;
	
	gen: FOR i IN BITS-2 DOWNTO 0 GENERATE
	BEGIN
		zero_found(i) <= 	TRUE WHEN x(i) = '0' ELSE
								FALSE WHEN (zero_found(i+1) = FALSE) AND (x(i) = '1') ELSE
								TRUE;
		
		output(i) <= 	(unsigned(output(i)) + 1) WHEN (x(i) = '1') AND zero_found(i) = FALSE ELSE
							output(i+1);
							
	END GENERATE;
	y <= std_logic_vector(output(0));

END;
	