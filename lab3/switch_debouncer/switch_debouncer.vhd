LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY switch_debouncer IS
	GENERIC (
		--50MHz
		fclk : INTEGER := 50_000_000;
		-- counter size (20 bits gives 20.9ms with 50MHz clock)
		-- 2^20 * 1/(50MHz) ~= 20ms
		-- time to debounce in ms
		t_deb : INTEGER := 20
	);
	PORT (
		clk, pb : IN STD_LOGIC;
		pb_deb  : OUT STD_LOGIC
	);
END ENTITY switch_debouncer;

ARCHITECTURE arch OF switch_debouncer IS
	--input flip flops
	SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0);
	--sync reset to zero
	SIGNAL counter_set : STD_LOGIC;
	-- we need to divide by 1000 after multiplying t_deb by fclk to adjust for t_deb being in ms
	SIGNAL counter_out : UNSIGNED(INTEGER(CEIL(LOG2(REAL(t_deb * fclk / 1000)))) - 1 DOWNTO 0) := to_unsigned(0, INTEGER(CEIL(LOG2(REAL(t_deb * fclk / 1000)))));
BEGIN
	--determine when to start/reset counter
	counter_set <= flipflops(0) XOR flipflops(1);

	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			flipflops(0) <= pb;
			flipflops(1) <= flipflops(0);
			--reset counter because input is changing
			IF (counter_set = '1') THEN
				counter_out <= to_unsigned(0, counter_out'LENGTH);
				--stable input time is not yet met
			ELSIF (counter_out(counter_out'LEFT) = '0') THEN
				counter_out <= counter_out + 1;
				--stable input time is met
			ELSE
				pb_deb <= flipflops(1);
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;