library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tff_sync is
    port(
        clk : in  std_logic := '0';
        rst : in  std_logic := '1';
        a   : in  std_logic := '0';
        q   : out std_logic := '0'
    );
end entity tff_sync;

architecture RTL of tff_sync is
begin
    process(all)
        variable temp : std_logic := '0';
    begin
        if rising_edge(clk) then
            if rst = '0' then
                temp := '0';
            elsif a = '1' then
                temp := not temp;
            else
                temp := temp;
            end if;
        end if;
        q <= temp;
    end process;
end architecture RTL;
