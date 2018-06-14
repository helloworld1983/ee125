library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity generic_ripple is
    generic(
        N : integer := 8);
    port(
        a, b : in  std_logic_vector(N - 1 downto 0);
        cin  : in  std_logic;
        sum  : out std_logic_vector(N - 1 downto 0);
        cout : out std_logic
    );
end entity generic_ripple;

architecture RTL of generic_ripple is
    signal temp : std_logic_vector(N downto 0);
begin
    temp(0) <= cin;
    cout    <= temp(N);
    signed_adder : for i in 0 to N - 1 generate
        full_adder_i : entity work.adder
            PORT MAP(
                temp(i), a(i), b(i), sum(i), temp(i + 1)
            );
    end generate;
end architecture RTL;
