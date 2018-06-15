library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity sync_tb is
end entity sync_tb;

architecture RTL of sync_tb is
    constant period : time    := 20 ns;
    constant BITS   : INTEGER := 4;
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal y        : STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0);
begin
    clock_driver : process
    begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
    end process clock_driver;

    inst : entity work.top_sync_counter
        generic map(
            BITS => BITS
        )
        port map(
            clk => clk,
            rst => rst,
            y   => y
        );
end architecture RTL;
