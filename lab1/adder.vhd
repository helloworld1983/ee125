library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port(
        a, b, cin : in  std_logic;
        sum, cout : out std_logic
    );
end entity adder;

architecture RTL of adder is
begin
    sum  <= a XOR b XOR cin;
    cout <= (a and b) or (cin and a) or (cin and b);
end architecture RTL;
