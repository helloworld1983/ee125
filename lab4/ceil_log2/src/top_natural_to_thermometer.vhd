LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.ALL;
USE work.lab4;

ENTITY top_natural_to_thermometer IS
	GENERIC (
		-- our clock frequency
		fclk : INTEGER := 50_000_000;
		-- number of input bits
		BITS : INTEGER := 8;
		-- time to debounce in ms
		t_deb : INTEGER := 20
	);
	PORT (
        -- input in stl format
        x : IN STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0');
        --num of bits, take the log base 2, then convert to an int. we redefine this because vhdl sucks
        y : OUT STD_LOGIC_VECTOR(x'HIGH - 1 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY top_natural_to_thermometer;

ARCHITECTURE arch OF top_natural_to_thermometer IS
BEGIN
	y <= to_stdlogicvector(lab4.natural_to_thermometer(to_integer(UNSIGNED(x))));
END ARCHITECTURE arch;