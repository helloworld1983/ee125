library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tff_sync is
    port(
        clk, rst : in std_logic;
        a, b : in std_logic;
        q_bar, q : out std_logic
    );
end entity tff_sync;

architecture RTL of tff_sync is
    signal temp: std_logic;
begin
    process (rst, clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                temp <= '0';
            elsif a = '1' then
                temp <= b xor temp;
            end if;
        end if;
    end process;
    q <= temp;
    q_bar <= not temp;
end architecture RTL;
