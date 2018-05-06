--------Praise Harambe--------
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
		--used to output to the ssd without another entity. 
		ssd: OUT BIT_VECTOR(6 DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE counter_leading_ones OF counter_leading_ones IS
	 --sets the output unsigned to be the log2 of the number of bits
	TYPE output_array IS ARRAY(NATURAL RANGE <>) OF UNSIGNED(integer(log2(real(BITS))) DOWNTO 0);
	 --constructs a 1dx1d array to store our output signal, sets the outputs to 4bits of 0 at the start
	SIGNAL output: output_array(BITS-1 DOWNTO 0) := (others => 4b"0");
	-- a 1dx1d array to track if we found a zero
	TYPE zero_found_array IS ARRAY(NATURAL RANGE <>) OF BOOLEAN; 
	--the actual sized array to track the zero
	SIGNAL zero_found: zero_found_array(BITS-1 DOWNTO 0) := (others => FALSE); 
BEGIN
	--stores the first bit of x in our 1dX1d array. 
	output(BITS-1)(0)		<= 	x(BITS-1);
	--checks the first bit in x if its a zero and sets zero_found to true
	zero_found(BITS-1) 	<= 	TRUE WHEN x(BITS-1) = '0' ELSE
										FALSE;
	
	-- A for loop that checks if the next bit in x is a 0 and updates zero_found for that iteration
	-- Then it assigns the updated to count to our output 1dx1d array. 
	gen: FOR i IN BITS-2 DOWNTO 0 GENERATE
	BEGIN
		-- Sets true when it finds a 0 in the current bit of x,
		-- sets false if and only if the previous value of zero_found is also false and x's current bit is 1
		zero_found(i) 	<= TRUE WHEN x(i) = '0' ELSE
								FALSE WHEN (zero_found(i+1) = FALSE) AND (x(i) = '1') ELSE
								TRUE;
		-- if the current bit of x is 1 and we havent found a zero, 
		-- set the current output in the array to the previous value plus 1
		output(i) 		<=	(unsigned(output(i+1)) + 1) WHEN (x(i) = '1') AND zero_found(i) = FALSE ELSE
								output(i+1);
							
	END GENERATE;
	--the output signal of y as an unsigned in stl format. unused right now as we output to the ssd directly
	y <= std_logic_vector(output(0));
	-- the ssd table from example 6.6 converted to a when table
	-- When a bit/pin is set low/0 it turns that LED on, if its set high/1 its turned off on the ssd
	ssd <=	"0000001" WHEN output(0) = to_unsigned(0, output(0)'LENGTH) ELSE
				"1001111" WHEN output(0) = to_unsigned(1, output(0)'LENGTH) ELSE
				"0010010" WHEN output(0) = to_unsigned(2, output(0)'LENGTH) ELSE
				"0000110" WHEN output(0) = to_unsigned(3, output(0)'LENGTH) ELSE
				"1001100" WHEN output(0) = to_unsigned(4, output(0)'LENGTH) ELSE
				"0100100" WHEN output(0) = to_unsigned(5, output(0)'LENGTH) ELSE
				"0100000" WHEN output(0) = to_unsigned(6, output(0)'LENGTH) ELSE
				"0001111" WHEN output(0) = to_unsigned(7, output(0)'LENGTH) ELSE
				"0000000" WHEN output(0) = to_unsigned(8, output(0)'LENGTH) ELSE
				"0000100" WHEN output(0) = to_unsigned(9, output(0)'LENGTH) ELSE
				"0110000";

END;
