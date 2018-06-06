LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY timed_counter IS
    GENERIC(
        --50MHz
        fclk      : INTEGER := 50_000_000;
        -- number of input bits
        BITS      : INTEGER := 8;
        INCREMENT : INTEGER := -1);
    PORT(
        clk, rst : IN  STD_LOGIC;
        run      : IN  STD_LOGIC := '0';
        -- our unsigned int
        x        : IN  STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0);
        --num of bits, take the log base 2, then convert to an int. we redefine this because vhdl sucks
        y        : OUT STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0));
END ENTITY;

ARCHITECTURE arch OF timed_counter IS
BEGIN

    PROCESS(clk, rst, run, x)
        VARIABLE counter1 : NATURAL RANGE 0 TO fclk := 0;
        VARIABLE counter2 : UNSIGNED(y'RANGE)       := to_unsigned(0, y'LENGTH);
    BEGIN
        IF (rst = '0') THEN
            counter1 := 0;
            counter2 := unsigned(x);
        ELSIF rising_edge(clk) AND (run = '1') THEN

            counter1 := counter1 + 1;
            IF (counter1 = fclk) THEN
                counter1 := 0;
                counter2 := counter2 + INCREMENT;
                -- if counter2 reaches its max value, reset
                IF counter2 = to_unsigned(0, y'LENGTH) THEN
                    counter2 := to_unsigned(0, y'LENGTH);
                END IF;
            END IF;
        END IF;
        y <= STD_LOGIC_VECTOR(counter2);
    END PROCESS;
END ARCHITECTURE;
