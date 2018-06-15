-- Copyright (C) 2017  Intel Corporation. All rights reserved.
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
-- Generated on "05/16/2018 05:40:25"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          top_natural_to_thermometer
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY top_natural_to_thermometer_vhd_vec_tst IS
END top_natural_to_thermometer_vhd_vec_tst;
ARCHITECTURE top_natural_to_thermometer_arch OF top_natural_to_thermometer_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL x : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR(127 DOWNTO 0);
COMPONENT top_natural_to_thermometer
	PORT (
	x : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : top_natural_to_thermometer
	PORT MAP (
-- list connections between master ports and signals
	x => x,
	y => y
	);
-- x[6]
t_prcs_x_6: PROCESS
BEGIN
	x(6) <= '0';
	WAIT FOR 10000 ps;
	x(6) <= '1';
	WAIT FOR 10000 ps;
	x(6) <= '0';
	WAIT FOR 30000 ps;
	x(6) <= '1';
	WAIT FOR 10000 ps;
	x(6) <= 'X';
WAIT;
END PROCESS t_prcs_x_6;
-- x[5]
t_prcs_x_5: PROCESS
BEGIN
	x(5) <= '0';
	WAIT FOR 10000 ps;
	x(5) <= '1';
	WAIT FOR 10000 ps;
	x(5) <= '0';
	WAIT FOR 40000 ps;
	x(5) <= 'X';
WAIT;
END PROCESS t_prcs_x_5;
-- x[4]
t_prcs_x_4: PROCESS
BEGIN
	x(4) <= '0';
	WAIT FOR 10000 ps;
	x(4) <= '1';
	WAIT FOR 20000 ps;
	x(4) <= '0';
	WAIT FOR 30000 ps;
	x(4) <= 'X';
WAIT;
END PROCESS t_prcs_x_4;
-- x[3]
t_prcs_x_3: PROCESS
BEGIN
	x(3) <= '0';
	WAIT FOR 10000 ps;
	x(3) <= '1';
	WAIT FOR 10000 ps;
	x(3) <= '0';
	WAIT FOR 40000 ps;
	x(3) <= 'X';
WAIT;
END PROCESS t_prcs_x_3;
-- x[2]
t_prcs_x_2: PROCESS
BEGIN
	x(2) <= '0';
	WAIT FOR 20000 ps;
	x(2) <= '1';
	WAIT FOR 10000 ps;
	x(2) <= '0';
	WAIT FOR 20000 ps;
	x(2) <= '1';
	WAIT FOR 10000 ps;
	x(2) <= 'X';
WAIT;
END PROCESS t_prcs_x_2;
-- x[1]
t_prcs_x_1: PROCESS
BEGIN
	x(1) <= '0';
	WAIT FOR 60000 ps;
	x(1) <= 'X';
WAIT;
END PROCESS t_prcs_x_1;
-- x[0]
t_prcs_x_0: PROCESS
BEGIN
	x(0) <= '0';
	WAIT FOR 40000 ps;
	x(0) <= '1';
	WAIT FOR 20000 ps;
	x(0) <= 'X';
WAIT;
END PROCESS t_prcs_x_0;
END top_natural_to_thermometer_arch;
