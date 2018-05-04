------------Code1--------------
library ieee;
use ieee.std_logic_1164.all;
-----------------------------
entity guess_the_circuit_1 is 
	port(
	clk: in std_logic;
	y: out std_logic);
end entity;
--------------------- 
architecture code1 of guess_the_circuit_1 is
begin
	process(clk)
		variable i: integer range 0 to 7;
	begin
		if rising_edge(clk) then
			if i /= 5 then i := i + 1;
			else i := 0;
			end if;

			if i=0 then y <= '0';
			else y <= '1';
			end if;
		end if;
	end process;
end architecture;