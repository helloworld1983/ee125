LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY pulse_width_modulator IS
    GENERIC(
        F_CLK        : INTEGER := 50_000_000;
        T_CLK_PWM    : INTEGER := 120;  --time in ns, 120 ns
        BITS_DEFAULT : INTEGER := 3);   -- number of bit of PWM counter
    PORT(
        clk       : IN  std_logic                                   := '1';
        rst       : IN  std_logic                                   := '1';
        new_cycle : IN  STD_LOGIC                                   := '1';
        duty      : IN  std_logic_vector(BITS_DEFAULT - 1 DOWNTO 0) := (OTHERS => '0');
        pwm       : OUT std_logic                                   := '0');
END pulse_width_modulator;

ARCHITECTURE rtl OF pulse_width_modulator IS
    -- need to do these divisions to avoid an overflow
    -- number of system clock cycles in a pwm period
    CONSTANT pwm_max_count : integer                              := (((F_CLK / 10E6 * T_CLK_PWM / 10E1)) + 1);
    SIGNAL counter         : integer range 0 to pwm_max_count - 1 := 0;
    signal half_cycle      : integer range 0 to pwm_max_count / 2 := pwm_max_count / 2;
    signal half_cycle_temp : integer range 0 to pwm_max_count / 2 := pwm_max_count / 2;
BEGIN

    p_state_out : PROCESS(clk, rst)
        --        variable half_cycle      : integer range 0 to pwm_max_count / 2 := pwm_max_count / 2;
        --        variable half_cycle_temp : integer range 0 to pwm_max_count / 2 := pwm_max_count / 2;
    BEGIN
        IF (rst = '0') THEN
            counter <= 0;
            pwm     <= '0';
        ELSIF rising_edge(clk) THEN
            if (new_cycle = '1') then
                half_cycle_temp <= (to_integer(unsigned(duty)) * pwm_max_count) / (2 ** BITS_DEFAULT) / 2;
            end if;

            IF (counter = pwm_max_count - 1) THEN
                counter    <= 0;
                half_cycle <= half_cycle_temp;
            ELSE
                counter <= counter + 1;
            end if;

            --            IF (counter = half_cycle and counter /= 0) THEN
            --                pwm <= '0';
            --            ELSIF (counter = pwm_max_count - half_cycle) THEN
            --                pwm <= '1';
            --            else
            --                pwm <= '0';
            --            END IF;
            if (counter < half_cycle - 1) then
                pwm <= '1';
            elsif (counter = 0) and (half_cycle /= pwm_max_count) then
                pwm <= '0';
            elsif (counter = half_cycle) then

                pwm <= '0';
            end if;
        END IF;
    END PROCESS p_state_out;
END rtl;
