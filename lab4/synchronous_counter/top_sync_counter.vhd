LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.ALL;

ENTITY top_sync_counter IS
    GENERIC(
        -- our clock frequency
        --        fclk : INTEGER := 50_000_000;
        -- number of input bits
        BITS : INTEGER := 4
    );
    PORT(
        -- input in stl format
        clk, rst : IN  std_logic                           := '0';
        y        : OUT STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY top_sync_counter;

ARCHITECTURE arch OF top_sync_counter IS
    signal q : std_logic_vector(BITS - 1 downto 0);
    signal a : std_logic_vector(BITS - 1 downto 0);
BEGIN

    input : for j in BITS - 1 downto 1 generate
        a(j) <= a(j - 1) and q(j - 1);
    end generate input;

    a(0) <= '1';

    syncs : for i in 0 to BITS - 1 generate
        tff : entity work.tff_sync(RTL)
            port map(clk, rst, a(i), q(i));
    end generate syncs;
    y <= q;

END ARCHITECTURE arch;
