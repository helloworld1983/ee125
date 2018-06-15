LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.lab4.all;

ENTITY top_natural_to_thermometer IS
    GENERIC(
        -- number of input bits
        BITS : INTEGER := 7
    );
    PORT(
        -- input in stl format
        x : IN  STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0)        := (OTHERS => '0');
        --num of bits, take the log base 2, then convert to an int. we redefine this because vhdl sucks
        y : OUT STD_LOGIC_VECTOR((2 ** BITS) - 1 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY top_natural_to_thermometer;

ARCHITECTURE arch OF top_natural_to_thermometer IS
BEGIN
    y <= to_stdlogicvector(natural_to_thermometer(UNSIGNED(x)));
END ARCHITECTURE arch;
