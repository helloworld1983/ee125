----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all; -- is this kosher?
----------------------------
package bus_arrays is
        type bus_array is array(natural range <>) of std_logic_vector;
end package;
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
		EXTRA_BITS: INTEGER := INTEGER(CEIL(LOG2(REAL(6))))
	);
	PORT (
		a: IN bus_array(SIZE-1 DOWNTO 0)(BITS-1 DOWNTO 0);
		b: IN bus_array(SIZE-1 DOWNTO 0)(BITS-1 DOWNTO 0);
		abs_diff: OUT STD_LOGIC_VECTOR((BITS-1 + EXTRA_BITS) DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE abs_diff_calculator OF absolute_difference_calculator IS
	TYPE output_array IS ARRAY(NATURAL RANGE <>) OF UNSIGNED((BITS-1 + EXTRA_BITS) DOWNTO 0);
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