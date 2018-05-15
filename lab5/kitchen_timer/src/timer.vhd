LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.ALL;

ENTITY timer IS 
	GENERIC (
		-- our clock frequency
		fclk : INTEGER := 50_000_000;
		-- number of input bits
		BITS : INTEGER := 8
	);
	PORT (
		clk : IN STD_LOGIC;
		start, clear, set_time : IN STD_LOGIC := '1';
		t2 : IN STD_LOGIC_VECTOR(BITS-1 DOWNTO 0) := (OTHERS => '0');
		-- an uint of BITS bits
		out_time: OUT STD_LOGIC_VECTOR(BITS-1 DOWNTO 0) := (OTHERS => '0');
		led: OUT STD_LOGIC := '0'
	);
END ENTITY timer;

ARCHITECTURE arch OF timer IS 
	SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL start_flipflop : BOOLEAN := FALSE;
	SIGNAL x : UNSIGNED(out_time'RANGE)       := to_unsigned(0, out_time'LENGTH);
BEGIN	
	PROCESS (clk, clear, start, t2, set_time, x)
		VARIABLE counter1 : NATURAL RANGE 0 TO fclk := 0;
	BEGIN
		IF (clear = '0') THEN
			counter1 := 0;
			x <= to_unsigned(0, x'LENGTH);
			led <= '0';
			start_flipflop <= FALSE;
		ELSIF (set_time = '0') THEN
			x <= unsigned(t2);
		ELSIF rising_edge(clk) THEN
			flipflops(0) <= start;
			flipflops(1) <= flipflops(0);
			if (flipflops(0) = '0') and start = '1' then  --- Rise edge
				start_flipflop <= not start_flipflop;
			end if;
			
			if (start_flipflop = true) and (x /= to_unsigned(0, x'LENGTH)) then
				counter1 := counter1 + 1;
				IF (counter1 = fclk) THEN
					counter1 := 0;
					-- if x reaches 0, stop. 
					IF x - 1 = to_unsigned(0, x'LENGTH) THEN
						led <= '1';
						start_flipflop <= FALSE;
					ELSE
						led <= '0';
					END IF;
					x <= x - 1;
				END IF;
			end if;
			
		END IF;
		out_time <= STD_LOGIC_VECTOR(x);
	END PROCESS;
END ARCHITECTURE arch;