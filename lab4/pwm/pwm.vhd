library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity pwm is
    generic(
        F_CLK        : INTEGER := 50_000_000;
        T_CLK_PWM    : INTEGER := 120;  --time in ms, 120 ns
        BITS_DEFAULT : integer := 4);   -- number of bit of PWM counter
    port(
        clk   : in  std_logic                                   := '1';
        rst   : in  std_logic                                   := '1';
        -- PWM Freq  = clock freq/ (i_pwm_module+1); max value = 2^N-1
        duty  : in  std_logic_vector(BITS_DEFAULT - 1 downto 0) := (others => '0'); -- PWM width = (others=>0)=> OFF; i_pwm_module => MAX ON 
        o_pwm : out std_logic                                   := '0');
end pwm;

architecture rtl of pwm is
    constant duty_max_count : UNSIGNED(duty'range) := to_unsigned((((F_CLK / 10E6 * T_CLK_PWM / 10)) + 1), duty'length);
    signal r_pwm_counter    : unsigned(duty'range) := to_unsigned(0, duty'length);
    signal r_pwm_width      : unsigned(duty'range) := to_unsigned(0, duty'length);
    --    signal r_pwm_end        : unsigned(duty'range) := to_unsigned(0, duty'length);
    signal w_tc_pwm_counter : std_logic            := '0';
begin
    w_tc_pwm_counter <= '0' when (r_pwm_counter < duty_max_count) else '1'; -- use to strobe new word

    --------------------------------------------------------------------
    p_state_out : process(clk, rst)
        variable r_pwm_end : unsigned(duty'range) := to_unsigned(0, duty'length);
    begin
        if (rst = '0') then
            r_pwm_width   <= (others => '0');
            r_pwm_counter <= (others => '0');
            o_pwm         <= '0';
        elsif rising_edge(clk) then
            r_pwm_end := duty_max_count;
            if (r_pwm_counter = 0) and (r_pwm_width /= r_pwm_end) then
                o_pwm <= '0';
            elsif (r_pwm_counter <= r_pwm_width) then
                o_pwm <= '1';
            else
                o_pwm <= '0';
            end if;

            if (w_tc_pwm_counter = '1') then
                r_pwm_width <= unsigned(duty);
            end if;

            if r_pwm_counter = r_pwm_end then
                r_pwm_counter <= to_unsigned(0, BITS_DEFAULT);
            else
                r_pwm_counter <= r_pwm_counter + 1;
            end if;
        end if;
    end process p_state_out;
end rtl;
