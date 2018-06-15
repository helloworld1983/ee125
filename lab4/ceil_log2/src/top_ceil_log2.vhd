LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.ALL;
USE work.lab4.all;

ENTITY top_ceil_log2 IS
    GENERIC(
        -- number of input bits
        BITS : INTEGER := 8
    );
    PORT(
        -- input in stl format
        x : IN  STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0);
        --num of bits, take the log base 2, then convert to an int. we redefine this because vhdl sucks
        y : OUT STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0)
    );
END ENTITY top_ceil_log2;

ARCHITECTURE arch OF top_ceil_log2 IS
BEGIN
    y <= STD_LOGIC_VECTOR(ceil_log2(UNSIGNED(x)));

END ARCHITECTURE arch;
