LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.lab4.all;
USE work.ALL;

ENTITY top_sync_counter IS
    GENERIC(
        -- our clock frequency
        fclk : INTEGER := 50_000_000;
        -- number of input bits
        BITS : INTEGER := 7
    );
    PORT(
        -- input in stl format
        clk, rst : IN std_logic := '0';
        x : IN  STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0)   := (OTHERS => '0');
        y : OUT STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY top_sync_counter;

ARCHITECTURE arch OF top_sync_counter IS
    signal q, q_bar : std_logic_vector(BITS - 1 downto 0);
BEGIN
    tff0: entity work.tff_sync(RTL) port map (clk, rst, '1', '1', q_bar(BITS-1), q(BITS-1));
    syncs: for i in BITS - 2 downto 0 generate
        tff: entity work.tff_sync(RTL) port map (clk, rst, q(i+1), q(i+1), q_bar(i), q(i));
    end generate syncs; 
    y <= q;
END ARCHITECTURE arch;
