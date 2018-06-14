library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity pwm_tb is
    generic(
        F_CLK        : INTEGER := 50_000_000;
        T_CLK_PWM    : INTEGER := 120;  --time in ms, 120 ns
        BITS_DEFAULT : integer := 4;
        DUTY_DEFAULT : integer := 3);
end entity pwm_tb;

architecture RTL of pwm_tb is
    signal clk      : std_logic                                   := '0';
    signal duty     : std_logic_vector(BITS_DEFAULT - 1 downto 0) := (others => '0');
    constant period : time                                        := 20 ns;
    signal rst      : std_logic                                   := '1';
    signal pwm      : std_logic                                   := '0';
begin
    duty <= std_logic_vector(to_unsigned(DUTY_DEFAULT, duty'length));

    clock_driver : process
    begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
    end process clock_driver;

    inst : entity work.pulse_width_modulator
        generic map(
            F_CLK        => F_CLK,
            T_CLK_PWM    => T_CLK_PWM,
            BITS_DEFAULT => BITS_DEFAULT
        )
        port map(
            clk  => clk,
            rst  => rst,
            duty => duty,
            pwm  => pwm
        );

end architecture RTL;
