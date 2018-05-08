LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.all;
USE work.all;

ENTITY toplevel IS
	GENERIC (
	-- number of input bits
		BITS: INTEGER := 8
	);
	PORT (
		clk: IN std_logic;
		counter_in_top: IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0);
		ssd_out_top: OUT BIT_VECTOR(6 DOWNTO 0)
	);
END ENTITY toplevel;
	
ARCHITECTURE toplevel_arch OF toplevel IS
	SIGNAL counter_output : STD_LOGIC_VECTOR((integer(log2(real(BITS)))) DOWNTO 0); 
BEGIN
	m_counter_1: entity work.counter_leading_ones(sequential)
		GENERIC MAP (BITS => BITS)
		PORT MAP(x => counter_in_top, y => counter_output);
	m_ssd_1: entity work.ssd_interface
		GENERIC MAP (BITS => BITS)
		PORT MAP(ssd_input => counter_output, ssd_output => ssd_out_top);
END ARCHITECTURE toplevel_arch;