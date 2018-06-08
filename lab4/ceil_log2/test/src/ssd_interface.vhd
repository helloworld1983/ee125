LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all;

ENTITY ssd_interface IS
	GENERIC (
	-- number of input bits
		BITS: INTEGER := 8
	);
	PORT(
		ssd_input: IN STD_LOGIC_VECTOR((integer(log2(real(BITS)))) DOWNTO 0);
		ssd_output: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ENTITY ssd_interface;
	
ARCHITECTURE ssd_driver OF ssd_interface IS
BEGIN
	-- the ssd table from example 6.6 converted to a when table
	-- When a bit/pin is set low/0 it turns that LED on, if its set high/1 its turned off on the ssd
   ssd_output <=	"0000001" WHEN unsigned(ssd_input) = to_unsigned(0, ssd_input'LENGTH) ELSE
						"1001111" WHEN unsigned(ssd_input) = to_unsigned(1, ssd_input'LENGTH) ELSE
						"0010010" WHEN unsigned(ssd_input) = to_unsigned(2, ssd_input'LENGTH) ELSE
						"0000110" WHEN unsigned(ssd_input) = to_unsigned(3, ssd_input'LENGTH) ELSE
						"1001100" WHEN unsigned(ssd_input) = to_unsigned(4, ssd_input'LENGTH) ELSE
						"0100100" WHEN unsigned(ssd_input) = to_unsigned(5, ssd_input'LENGTH) ELSE
						"0100000" WHEN unsigned(ssd_input) = to_unsigned(6, ssd_input'LENGTH) ELSE
						"0001111" WHEN unsigned(ssd_input) = to_unsigned(7, ssd_input'LENGTH) ELSE
						"0000000" WHEN unsigned(ssd_input) = to_unsigned(8, ssd_input'LENGTH) ELSE
						"0000100" WHEN unsigned(ssd_input) = to_unsigned(9, ssd_input'LENGTH) ELSE
						"0110000";   
END ARCHITECTURE ssd_driver;