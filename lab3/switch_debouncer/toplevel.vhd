LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.ALL;

ENTITY toplevel IS
	GENERIC (
		-- our clock frequency
		fclk : INTEGER := 50_000_000;
		-- number of input bits
		BITS : INTEGER := 8;
		-- time to debounce in ms
		t_deb : INTEGER := 20
	);
	PORT (
		clk, rst, pb : IN STD_LOGIC;
		ssd_out_1, ssd_out_2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ENTITY toplevel;

ARCHITECTURE toplevel_arch OF toplevel IS
	SIGNAL counter_output_1, counter_output_2 : STD_LOGIC_VECTOR((INTEGER(log2(real(BITS)))) DOWNTO 0);
	SIGNAL pb_deb : STD_LOGIC;
BEGIN
	debouncer : ENTITY work.switch_debouncer
		GENERIC MAP(fclk, t_deb)
		PORT MAP(clk, pb, pb_deb);
		
	counter_1 : ENTITY work.counter
		GENERIC MAP(BITS)
		PORT MAP(clk => pb_deb, rst => rst, y => counter_output_1);
		
	counter_2 : ENTITY work.counter
		GENERIC MAP(BITS)
		PORT MAP(clk => pb, rst => rst, y => counter_output_2);
		
	ssd_1 : ENTITY work.ssd_interface
		GENERIC MAP(BITS)
		PORT MAP(counter_output_1, ssd_out_1);
		
	ssd_2 : ENTITY work.ssd_interface
		GENERIC MAP(BITS)
		PORT MAP(counter_output_2, ssd_out_2);
END ARCHITECTURE toplevel_arch;