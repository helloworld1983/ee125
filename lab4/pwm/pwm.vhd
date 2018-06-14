library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity pulse_width_modulator is
    generic(
        F_CLK        : INTEGER := 50_000_000;
        T_CLK_PWM    : INTEGER := 120;  --time in ms, 120 ns
        BITS_DEFAULT : integer := 4);   -- number of bit of PWM counter
    port(
        clk  : in  std_logic                                   := '1';
        rst  : in  std_logic                                   := '1';
        duty : in  std_logic_vector(BITS_DEFAULT - 1 downto 0) := (others => '0');
        pwm  : out std_logic                                   := '0');
end pulse_width_modulator;

architecture rtl of pulse_width_modulator is
    constant duty_max_count : UNSIGNED(duty'range) := to_unsigned((((F_CLK / 10E6 * T_CLK_PWM / 10E2)) + 1), duty'length);
    signal counter          : unsigned(duty'range) := to_unsigned(0, duty'length);
    signal pwm_width        : unsigned(duty'range) := to_unsigned(0, duty'length);
    --    signal r_pwm_end        : unsigned(duty'range) := to_unsigned(0, duty'length);
    signal toggle           : std_logic            := '0';
begin
    toggle <= '0' when (counter < duty_max_count) else '1';

    --------------------------------------------------------------------
    p_state_out : process(clk, rst)
        variable pwm_end : unsigned(duty'range) := to_unsigned(0, duty'length);
    begin
        if (rst = '0') then
            pwm_width <= (others => '0');
            counter   <= (others => '0');
            pwm       <= '0';
        elsif rising_edge(clk) then
            pwm_end := duty_max_count;
            if (counter = 0) and (pwm_width /= pwm_end) then
                pwm <= '0';
            elsif (counter <= pwm_width) then
                pwm <= '1';
            else
                pwm <= '0';
            end if;

            if (toggle = '1') then
                pwm_width <= unsigned(duty);
            end if;

            if counter = pwm_end then
                counter <= to_unsigned(0, BITS_DEFAULT);
            else
                counter <= counter + 1;
            end if;
        end if;
    end process p_state_out;
end rtl;
