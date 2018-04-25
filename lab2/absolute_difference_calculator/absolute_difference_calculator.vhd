----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all; -- is this kosher?
----------------------------
PACKAGE bus_arrays IS
        TYPE bus_array IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
END PACKAGE;
--------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all; -- is this kosher?
USE work.bus_arrays.all;

ENTITY absolute_difference_calculator IS
	GENERIC (
		SIZE: INTEGER := 6;
		BITS: INTEGER := 5;
		EXTRA_BITS: INTEGER := INTEGER(CEIL(LOG2(REAL(6+1))))
	);
	PORT (
		a: IN bus_array(SIZE-1 DOWNTO 0)(BITS-1 DOWNTO 0);
		b: IN bus_array(SIZE-1 DOWNTO 0)(BITS-1 DOWNTO 0);
--		a5: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		a4: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		a3: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		a2: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		a1: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		a0: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		b5: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		b4: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		b3: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		b2: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		b1: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
--		b0: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
		abs_diff: OUT STD_LOGIC_VECTOR((BITS-1 + EXTRA_BITS) DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE abs_diff_calculator OF absolute_difference_calculator IS
--	TYPE bus_array is array(SIZE-1 DOWNTO 0) OF std_logic_vector(BITS-1 DOWNTO 0);
	TYPE output_array IS ARRAY(NATURAL RANGE <>) OF UNSIGNED((BITS-1 + EXTRA_BITS) DOWNTO 0);
--	SIGNAL a: bus_array := (a5, a4, a3, a2, a1, a0);
--	SIGNAL b: bus_array := (b5, b4, b3, b2, b1, b0);
	SIGNAL abs_differences: output_array(SIZE-1 DOWNTO 0);
	SIGNAL output: output_array(SIZE-2 DOWNTO 0);
BEGIN
		--resize(a(i), BITS + EXTRA_BITS)
		gen: FOR i IN SIZE-1 DOWNTO 0 GENERATE
		BEGIN
			abs_differences(i) <= unsigned(abs(resize(signed(a(i)), BITS + EXTRA_BITS) - resize(signed(b(i)), BITS + EXTRA_BITS)));
		END GENERATE;
		
		output(SIZE-2) <= abs_differences(SIZE-1) + abs_differences(SIZE-2);
		final_add: FOR i IN SIZE-3 DOWNTO 0 GENERATE
		BEGIN
			output(i) <= abs_differences(i) + output(i+1);
		END GENERATE;
		
		abs_diff <= std_logic_vector(output(0));
END;