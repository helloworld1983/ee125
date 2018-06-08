LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

PACKAGE testing_utils IS
	-- Procedure for clock generation
	PROCEDURE clk_gen(SIGNAL clk : OUT std_logic; CONSTANT FREQ : real);
	-- Advanced procedure for clock generation, with period adjust to match frequency over time, and run control by signal
	PROCEDURE clk_gen_adv(SIGNAL clk : OUT std_logic; CONSTANT FREQ : real; PHASE : TIME := 0 fs; SIGNAL run : std_logic);
END PACKAGE testing_utils;

PACKAGE BODY testing_utils IS
	-- Procedure for clock generation
	-- from https://stackoverflow.com/a/17924556
	PROCEDURE clk_gen(SIGNAL clk : OUT STD_LOGIC; CONSTANT FREQ : REAL) IS
		CONSTANT PERIOD    : TIME := 1 sec / FREQ; -- Full period
		CONSTANT HIGH_TIME : TIME := PERIOD / 2; -- High time
		CONSTANT LOW_TIME  : TIME := PERIOD - HIGH_TIME; -- Low time; always >= HIGH_TIME
	BEGIN
		-- Check the arguments
		ASSERT (HIGH_TIME /= 0 fs) REPORT "clk_plain: High time is zero; time resolution to large for frequency" SEVERITY FAILURE;
		-- Generate a clock cycle
		LOOP
			clk <= '1';
			WAIT FOR HIGH_TIME;
			clk <= '0';
			WAIT FOR LOW_TIME;
		END LOOP;
	END PROCEDURE clk_gen;

	-- Advanced procedure for clock generation, with period adjust to match frequency over time, and run control by signal
	-- from https://stackoverflow.com/a/17924556
	PROCEDURE clk_gen_adv(SIGNAL clk : OUT std_logic; CONSTANT FREQ : real; PHASE : TIME := 0 fs; SIGNAL run : std_logic) IS
		CONSTANT HIGH_TIME   : TIME                                                                              := 0.5 sec / FREQ; -- High time as fixed value
		VARIABLE low_time_v  : TIME; -- Low time calculated per cycle; always >= HIGH_TIME
		VARIABLE cycles_v    : real := 0.0; -- Number of cycles
		VARIABLE freq_time_v : TIME := 0 fs; -- Time used for generation of cycles
	BEGIN
		-- Check the arguments
		ASSERT (HIGH_TIME /= 0 fs) REPORT "clk_gen: High time is zero; time resolution to large for frequency" SEVERITY FAILURE;
		-- Initial phase shift
		clk <= '0';
		WAIT FOR PHASE;
		-- Generate cycles
		LOOP
			-- Only high pulse if run is '1' or 'H'
			IF (run = '1') OR (run = 'H') THEN
				clk <= run;
			END IF;
			WAIT FOR HIGH_TIME;
			-- Low part of cycle
			clk <= '0';
			low_time_v := 1 sec * ((cycles_v + 1.0) / FREQ) - freq_time_v - HIGH_TIME; -- + 1.0 for cycle after current
			WAIT FOR low_time_v;
			-- Cycle counter and time passed update
			cycles_v    := cycles_v + 1.0;
			freq_time_v := freq_time_v + HIGH_TIME + low_time_v;
		END LOOP;
	END PROCEDURE clk_gen_adv;
END PACKAGE BODY testing_utils;