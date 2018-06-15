LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY pulse_width_modulator IS
    GENERIC(
        F_CLK        : INTEGER := 50_000_000;
        T_CLK_PWM    : INTEGER := 120;  --time in ns, 120 ns
        BITS_DEFAULT : INTEGER := 4);   -- number of bit of PWM counter
    PORT(
        clk  : IN  std_logic                                   := '1';
        rst  : IN  std_logic                                   := '1';
        duty : IN  std_logic_vector(BITS_DEFAULT - 1 DOWNTO 0) := (OTHERS => '0');
        pwm  : OUT std_logic                                   := '0');
END pulse_width_modulator;

ARCHITECTURE rtl OF pulse_width_modulator IS
    -- need to do these divisions to avoid an overflow
    CONSTANT pwm_max_count : UNSIGNED(duty'RANGE) := to_unsigned((((F_CLK / 10E6 * T_CLK_PWM / 10E2)) + 1), duty'length);
    SIGNAL counter         : unsigned(duty'RANGE) := to_unsigned(0, duty'length);
    SIGNAL pwm_width       : unsigned(duty'RANGE) := to_unsigned(0, duty'length);
    signal pwm_end         : unsigned(duty'RANGE) := to_unsigned(0, duty'length);
    SIGNAL toggle          : std_logic            := '0';
BEGIN
    -- allow the pwm width to be changed 
    toggle <= '0' WHEN (counter < pwm_max_count and counter /= 0) ELSE '1';

    p_state_out : PROCESS(clk, rst)
    BEGIN
        IF (rst = '0') THEN
            pwm_width <= (OTHERS => '0');
            counter   <= (OTHERS => '0');
            pwm       <= '0';
        ELSIF rising_edge(clk) THEN
            pwm_end <= pwm_max_count;
            IF (counter = 0) AND (pwm_width /= pwm_end) THEN
                pwm <= '0';
            ELSIF (counter <= pwm_width) THEN
                pwm <= '1';
            ELSE
                pwm <= '0';
            END IF;

            IF (toggle = '1') THEN
                pwm_width <= unsigned(duty);
            END IF;

            IF counter = pwm_end THEN
                counter <= to_unsigned(0, BITS_DEFAULT);
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS p_state_out;
END rtl;
