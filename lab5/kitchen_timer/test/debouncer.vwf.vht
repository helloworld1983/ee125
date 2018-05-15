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
-- Generated on "05/08/2018 15:07:51"

-- Vhdl Test Bench(with test vectors) for design  :          toplevel
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.testing_utils;

ENTITY toplevel_vhd_vec_tst IS
END toplevel_vhd_vec_tst;
ARCHITECTURE toplevel_arch OF toplevel_vhd_vec_tst IS
	-- constants                                                 
	-- signals                                                   
	SIGNAL clk       : STD_LOGIC := '0';
	SIGNAL pb        : STD_LOGIC := '1';
	SIGNAL rst       : STD_LOGIC := '1';
	SIGNAL ssd_out_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL ssd_out_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL run      : STD_LOGIC := '1';
	COMPONENT toplevel
		PORT (
			clk       : IN STD_LOGIC;
			pb        : IN STD_LOGIC;
			rst       : IN STD_LOGIC;
			ssd_out_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			ssd_out_2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	i1 : toplevel
	PORT MAP(
		-- list connections between master ports and signals
		clk       => clk,
		pb        => pb,
		rst       => rst,
		ssd_out_1 => ssd_out_1,
		ssd_out_2 => ssd_out_2
	);

	-- concurrent clock generator 
	testing_utils.clk_gen_adv(clk, 50.000E6, 0 fs, run); --50MHz
	
	-- rst
	t_prcs_rst : PROCESS
	BEGIN
		rst <= '1';
		WAIT FOR 55 ms;
	END PROCESS t_prcs_rst;

	-- pb
	t_prcs_pb : PROCESS
	BEGIN
		pb <= '1';
		WAIT FOR 20 ns;
		pb <= '0';
		WAIT FOR 50 ms;
		pb <= '1';
		WAIT FOR 10 ms;
		pb <= '0';
		WAIT FOR 1 ms;
		run <= '0';
		WAIT;
	END PROCESS t_prcs_pb;
	
	-- Time resolution show
  assert FALSE report "Time resolution: " & time'image(time'succ(0 fs)) severity NOTE;
END toplevel_arch;