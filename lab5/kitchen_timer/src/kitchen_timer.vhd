LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.ALL;

ENTITY kitchen_timer IS
	GENERIC (
		-- our clock frequency
		fclk : INTEGER := 50_000_000;
		-- number of input bits
		BITS : INTEGER := 8;
		-- time to debounce in ms
		t_deb : INTEGER := 20;
		MAXIMUM : INTEGER := 61
	);
	PORT (
		clk : IN STD_LOGIC;
		set_time, clear, start : IN STD_LOGIC := '1';
		ssd_out_1, ssd_out_2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		led: OUT STD_LOGIC := '1'
	);
END ENTITY kitchen_timer;

ARCHITECTURE toplevel_arch OF kitchen_timer IS
	SIGNAL time_counter_temp, t2: STD_LOGIC_VECTOR(BITS-1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL clear_deb, set_time_deb, start_deb : STD_LOGIC := '1';
	SIGNAL counter_1, counter_10 : STD_LOGIC_VECTOR((integer(log2(real(BITS)))) DOWNTO 0) := (OTHERS => '0');
BEGIN
	clear_debouncer : ENTITY work.switch_debouncer
		GENERIC MAP(fclk, t_deb)
		PORT MAP(clk, clear, clear_deb);
	
	set_time_debouncer : ENTITY work.switch_debouncer
		GENERIC MAP(fclk, t_deb)
		PORT MAP(clk, set_time, set_time_deb);
		
	start_debouncer : ENTITY work.switch_debouncer
		GENERIC MAP(fclk, t_deb)
		PORT MAP(clk, start, start_deb);
		
	set_time_counter : ENTITY work.counter(on_falling)
		GENERIC MAP(BITS, MAXIMUM)
		PORT MAP(clk => set_time_deb, rst => clear_deb, y => t2);
		
	timer : ENTITY work.timer(arch)
		GENERIC MAP(fclk, BITS)
		PORT MAP(clk => clk, set_time => set_time_deb, t2 => t2, start => start_deb, clear => clear_deb, led => led, out_time => time_counter_temp);
		
	counter_1 <= STD_LOGIC_VECTOR(unsigned(time_counter_temp) mod 10)(3 DOWNTO 0);
	counter_10 <= STD_LOGIC_VECTOR((unsigned(time_counter_temp) - (unsigned(time_counter_temp) mod 10)) / 10)(3 DOWNTO 0);
	
	ssd_1 : ENTITY work.ssd_interface
		GENERIC MAP(BITS)
		PORT MAP(counter_1, ssd_out_1);
		
	ssd_2 : ENTITY work.ssd_interface
		GENERIC MAP(BITS)
		PORT MAP(counter_10, ssd_out_2);
END ARCHITECTURE toplevel_arch;