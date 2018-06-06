LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY counter IS
    GENERIC(
        -- number of input bits
        BITS    : INTEGER := 8;
        MAXIMUM : INTEGER := 60);
    PORT(
        clk, rst : IN  STD_LOGIC;
        x        : IN  STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0');
        y        : OUT STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY;

ARCHITECTURE on_falling OF counter IS
BEGIN
    PROCESS(clk, rst)
        VARIABLE temp : UNSIGNED(y'RANGE) := to_unsigned(0, y'LENGTH);
    BEGIN
        -- push button sends low logic ('0') when you press it, when not pressed it sends high ('1')
        IF (rst = '0') THEN
            temp := to_unsigned(0, y'LENGTH);
            -- because of the push button behavior we count when we get low logic instead of high
        ELSIF falling_edge(clk) THEN
            if unsigned(x) /= temp then
                temp := unsigned(x);
            end if;

            temp := temp + 1;
            -- if temp reaches its max value, reset
            IF temp = to_unsigned(MAXIMUM, y'LENGTH) THEN
                temp := to_unsigned(0, y'LENGTH);
            END IF;
        END IF;
        y <= STD_LOGIC_VECTOR(temp);
    END PROCESS;
END ARCHITECTURE;

ARCHITECTURE on_rising OF counter IS
BEGIN
    PROCESS(clk, rst)
        VARIABLE temp : UNSIGNED(y'RANGE) := to_unsigned(0, y'LENGTH);
    BEGIN
        IF (rst = '1') THEN
            temp := to_unsigned(0, y'LENGTH);
        ELSIF rising_edge(clk) THEN
            if unsigned(x) /= temp then
                temp := unsigned(x);
            end if;

            temp := temp + 1;
            -- if temp reaches its max value, reset
            IF temp = to_unsigned(MAXIMUM, y'LENGTH) THEN
                temp := to_unsigned(0, y'LENGTH);
            END IF;
        END IF;
        y <= STD_LOGIC_VECTOR(temp);
    END PROCESS;
END ARCHITECTURE;
