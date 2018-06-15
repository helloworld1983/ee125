-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "06/14/2018 13:13:51"

-- Vhdl Test Bench(with test vectors) for design  :          top_natural_to_thermometer
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

ENTITY top_natural_to_thermometer_vhd_vec_tst IS
    generic(BITS : INTEGER := 7);
END top_natural_to_thermometer_vhd_vec_tst;

ARCHITECTURE top_natural_to_thermometer_arch OF top_natural_to_thermometer_vhd_vec_tst IS
    SIGNAL x : STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0);
    SIGNAL y : STD_LOGIC_VECTOR((2 ** BITS) - 1 DOWNTO 0);

BEGIN
    thermometer_encoder : entity work.top_natural_to_thermometer
        generic map(
            BITS => BITS
        )
        port map(
            x => x,
            y => y
        );

    numbers : PROCESS
    BEGIN
        x <= std_logic_vector(to_unsigned(11, x'length));
        WAIT for 20 ns;
        x <= std_logic_vector(to_unsigned(3, x'length));
        wait for 20 ns;
        x <= std_logic_vector(to_unsigned(13, x'length));
        wait for 20 ns;
        x <= std_logic_vector(to_unsigned(17, x'length));
        wait for 20 ns;
        x <= std_logic_vector(to_unsigned(24, x'length));
        wait for 20 ns;
        x <= std_logic_vector(to_unsigned(0, x'length));
    END PROCESS numbers;
END top_natural_to_thermometer_arch;
