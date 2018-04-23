------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------
ENTITY unsigned_add_sub IS
  GENERIC (NUM_BITS: INTEGER := 5); --number of input bits
  PORT (a, b: IN STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
		  cin: IN STD_LOGIC;
		  --sum, sub: OUT STD_LOGIC_VECTOR(N DOWNTO 0));
		  sum, sub: OUT STD_LOGIC_VECTOR(NUM_BITS-1 DOWNTO 0);
		  cout_sum, cout_sub: OUT STD_LOGIC);
END ENTITY;
------------------------------------------------------------------------
ARCHITECTURE unsigned_add_sub OF unsigned_add_sub IS
  SIGNAL a_usig, b_usig: UNSIGNED(NUM_BITS-1 DOWNTO 0);
  SIGNAL sum_usig, sub_usig: UNSIGNED(NUM_BITS DOWNTO 0);
BEGIN
	-----convert to signed:--------------
	a_usig <= unsigned(a);
	b_usig <= unsigned(b);
	-----add and subtract:---------------
	sum_usig <= (a_usig(NUM_BITS-1) & a_usig) + (b_usig(NUM_BITS-1) & b_usig) + ('0' & cin);
	sub_usig <= (a_usig(NUM_BITS-1) & a_usig) - (b_usig(NUM_BITS-1) & b_usig) + ('0' & cin);
	-----output option #1:---------------
	--sum <= std_logic_vector(sum_usig);
	--sub <= std_logic_vector(sub_usig);
	-----output option #2:---------------
	sum <= std_logic_vector(sum_usig(NUM_BITS-1 DOWNTO 0));
	cout_sum <= std_logic(sum_usig(NUM_BITS));
	sub <= std_logic_vector(sub_usig(NUM_BITS-1 DOWNTO 0));
	cout_sub <= std_logic(sub_usig(NUM_BITS));
END ARCHITECTURE;
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


