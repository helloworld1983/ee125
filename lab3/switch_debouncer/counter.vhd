LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY counter IS
	GENERIC (
		-- number of input bits
		BITS : INTEGER := 8);
	PORT (
		clk, rst : IN STD_LOGIC;
		--num of bits, take the log base 2, then convert to an int. we redefine this because vhdl sucks
		y        : OUT STD_LOGIC_VECTOR((INTEGER(log2(real(BITS)))) DOWNTO 0));
END ENTITY;

ARCHITECTURE on_falling OF counter IS
BEGIN
	PROCESS (clk, rst)
		VARIABLE temp : UNSIGNED(y'RANGE) := to_unsigned(0, y'LENGTH);
	BEGIN
		IF (rst = '0') THEN
			temp := to_unsigned(0, y'LENGTH);
		ELSIF falling_edge(clk) THEN
			temp := temp + 1;
			-- if temp reaches its max value, reset
			IF temp = to_unsigned(2 ** BITS, y'LENGTH) THEN
				temp := to_unsigned(0, y'LENGTH);
			END IF;
		END IF;
		y <= STD_LOGIC_VECTOR(temp);
	END PROCESS;
END ARCHITECTURE;

ARCHITECTURE on_rising OF counter IS
BEGIN
	PROCESS (clk, rst)
		VARIABLE temp : UNSIGNED(y'RANGE) := to_unsigned(0, y'LENGTH);
	BEGIN
		IF (rst = '1') THEN
			temp := to_unsigned(0, y'LENGTH);
		ELSIF rising_edge(clk) THEN
			temp := temp + 1;
			-- if temp reaches its max value, reset
			IF temp = to_unsigned(2 ** BITS, y'LENGTH) THEN
				temp := to_unsigned(0, y'LENGTH);
			END IF;
		END IF;
		y <= STD_LOGIC_VECTOR(temp);
	END PROCESS;
END ARCHITECTURE;