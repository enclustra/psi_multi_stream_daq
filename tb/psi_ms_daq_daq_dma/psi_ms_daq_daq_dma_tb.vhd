------------------------------------------------------------------------------
--  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
--  All rights reserved.
--  Authors: Oliver Bruendler
------------------------------------------------------------------------------

------------------------------------------------------------
-- Testbench generated by TbGen.py
------------------------------------------------------------
-- see Library/Python/TbGenerator

------------------------------------------------------------
-- Libraries
------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

library work;
	use work.psi_common_math_pkg.all;
	use work.psi_common_logic_pkg.all;
	use work.psi_common_array_pkg.all;
	use work.psi_ms_daq_pkg.all;

library work;
	use work.psi_tb_txt_util.all;
	use work.psi_tb_compare_pkg.all;
	use work.psi_tb_activity_pkg.all;

library work;
	use work.psi_ms_daq_daq_dma_tb_pkg.all;

library work;
	use work.psi_ms_daq_daq_dma_tb_case_aligned.all;
	use work.psi_ms_daq_daq_dma_tb_case_unaligned.all;
	use work.psi_ms_daq_daq_dma_tb_case_no_data_read.all;
	use work.psi_ms_daq_daq_dma_tb_case_input_empty.all;
	use work.psi_ms_daq_daq_dma_tb_case_empty_timeout.all;
	use work.psi_ms_daq_daq_dma_tb_case_cmd_full.all;
	use work.psi_ms_daq_daq_dma_tb_case_data_full.all;
	use work.psi_ms_daq_daq_dma_tb_case_errors.all;

------------------------------------------------------------
-- Entity Declaration
------------------------------------------------------------
entity psi_ms_daq_daq_dma_tb is
end entity;

------------------------------------------------------------
-- Architecture
------------------------------------------------------------
architecture sim of psi_ms_daq_daq_dma_tb is
	-- *** Fixed Generics ***
	constant Streams_g : positive := 4;
	
	-- *** Not Assigned Generics (default values) ***
	
	-- *** Exported Generics ***
	constant Generics_c : Generics_t := (
		Dummy => true);
	
	-- *** TB Control ***
	signal TbRunning : boolean := True;
	signal NextCase : integer := -1;
	signal ProcessDone : std_logic_vector(0 to 3) := (others => '0');
	constant AllProcessesDone_c : std_logic_vector(0 to 3) := (others => '1');
	constant TbProcNr_control_c : integer := 0;
	constant TbProcNr_input_c : integer := 1;
	constant TbProcNr_mem_cmd_c : integer := 2;
	constant TbProcNr_mem_dat_c : integer := 3;
	
	-- *** DUT Signals ***
	signal Clk : std_logic := '1';
	signal Rst : std_logic := '1';
	signal DaqSm_Cmd : DaqSm2DaqDma_Cmd_t;
	signal DaqSm_Cmd_Vld : std_logic := '0';
	signal DaqSm_Resp : DaqDma2DaqSm_Resp_t;
	signal DaqSm_Resp_Vld : std_logic := '0';
	signal DaqSm_Resp_Rdy : std_logic := '0';
	signal DaqSm_HasLast : std_logic_vector(Streams_g-1 downto 0) := (others => '0');
	signal Inp_Vld : std_logic_vector(Streams_g-1 downto 0) := (others => '0');
	signal Inp_Rdy : std_logic_vector(Streams_g-1 downto 0) := (others => '0');
	signal Inp_Data : Input2Daq_Data_a(Streams_g-1 downto 0);
	signal Mem_CmdAddr : std_logic_vector(31 downto 0) := (others => '0');
	signal Mem_CmdSize : std_logic_vector(31 downto 0) := (others => '0');
	signal Mem_CmdVld : std_logic := '0';
	signal Mem_CmdRdy : std_logic := '0';
	signal Mem_DatData : std_logic_vector(63 downto 0) := (others => '0');
	signal Mem_DatVld : std_logic := '0';
	signal Mem_DatRdy : std_logic := '0';
	
begin
	------------------------------------------------------------
	-- DUT Instantiation
	------------------------------------------------------------
	i_dut : entity work.psi_ms_daq_daq_dma
		generic map (
			Streams_g => Streams_g
		)
		port map (
			Clk => Clk,
			Rst => Rst,
			DaqSm_Cmd => DaqSm_Cmd,
			DaqSm_Cmd_Vld => DaqSm_Cmd_Vld,
			DaqSm_Resp => DaqSm_Resp,
			DaqSm_Resp_Vld => DaqSm_Resp_Vld,
			DaqSm_Resp_Rdy => DaqSm_Resp_Rdy,
			DaqSm_HasLast => DaqSm_HasLast,
			Inp_Vld => Inp_Vld,
			Inp_Rdy => Inp_Rdy,
			Inp_Data => Inp_Data,
			Mem_CmdAddr => Mem_CmdAddr,
			Mem_CmdSize => Mem_CmdSize,
			Mem_CmdVld => Mem_CmdVld,
			Mem_CmdRdy => Mem_CmdRdy,
			Mem_DatData => Mem_DatData,
			Mem_DatVld => Mem_DatVld,
			Mem_DatRdy => Mem_DatRdy
		);
	
	------------------------------------------------------------
	-- Testbench Control !DO NOT EDIT!
	------------------------------------------------------------
	p_tb_control : process
	begin
		-- aligned
		NextCase <= 0;
		wait until ProcessDone = AllProcessesDone_c;
		-- unaligned
		NextCase <= 1;
		wait until ProcessDone = AllProcessesDone_c;
		-- no_data_read
		NextCase <= 2;
		wait until ProcessDone = AllProcessesDone_c;
		-- input_empty
		NextCase <= 3;
		wait until ProcessDone = AllProcessesDone_c;
		-- empty_timeout
		NextCase <= 4;
		wait until ProcessDone = AllProcessesDone_c;
		-- cmd_full
		NextCase <= 5;
		wait until ProcessDone = AllProcessesDone_c;
		-- data_full
		NextCase <= 6;
		wait until ProcessDone = AllProcessesDone_c;
		-- errors
		NextCase <= 7;
		wait until ProcessDone = AllProcessesDone_c;		
		TbRunning <= false;
		wait;
	end process;
	
	------------------------------------------------------------
	-- Clocks !DO NOT EDIT!
	------------------------------------------------------------
	p_clock_Clk : process
		constant Frequency_c : real := real(200e6);
	begin
		while TbRunning loop
			wait for 0.5*(1 sec)/Frequency_c;
			Clk <= not Clk;
		end loop;
		wait;
	end process;
	
	
	------------------------------------------------------------
	-- Resets
	------------------------------------------------------------
	p_rst_Rst : process
	begin
		wait for 1 us;
		-- Wait for two clk edges to ensure reset is active for at least one edge
		wait until rising_edge(Clk);
		wait until rising_edge(Clk);
		wait;
	end process;
	
	
	------------------------------------------------------------
	-- Processes !DO NOT EDIT!
	------------------------------------------------------------
	-- *** control ***
	p_control : process
	begin
		-- aligned
		wait until NextCase = 0;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_aligned.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- unaligned
		wait until NextCase = 1;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_unaligned.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- no_data_read
		wait until NextCase = 2;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_no_data_read.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- input_empty
		wait until NextCase = 3;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_input_empty.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- empty_timeout
		wait until NextCase = 4;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_empty_timeout.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- cmd_full
		wait until NextCase = 5;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_cmd_full.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- data_full
		wait until NextCase = 6;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_data_full.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';
		-- errors
		wait until NextCase = 7;
		ProcessDone(TbProcNr_control_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_errors.control(Clk, Rst, DaqSm_Cmd, DaqSm_Cmd_Vld, DaqSm_Resp, DaqSm_Resp_Vld, DaqSm_Resp_Rdy, DaqSm_HasLast, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_control_c) <= '1';		
		wait;
	end process;
	
	-- *** input ***
	p_input : process
	begin
		-- aligned
		wait until NextCase = 0;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_aligned.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- unaligned
		wait until NextCase = 1;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_unaligned.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- no_data_read
		wait until NextCase = 2;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_no_data_read.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- input_empty
		wait until NextCase = 3;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_input_empty.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- empty_timeout
		wait until NextCase = 4;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_empty_timeout.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- cmd_full
		wait until NextCase = 5;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_cmd_full.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- data_full
		wait until NextCase = 6;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_data_full.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';
		-- errors
		wait until NextCase = 7;
		ProcessDone(TbProcNr_input_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_errors.input(Clk, Inp_Vld, Inp_Rdy, Inp_Data, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_input_c) <= '1';		
		wait;
	end process;
	
	-- *** mem_cmd ***
	p_mem_cmd : process
	begin
		-- aligned
		wait until NextCase = 0;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_aligned.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- unaligned
		wait until NextCase = 1;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_unaligned.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- no_data_read
		wait until NextCase = 2;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_no_data_read.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- input_empty
		wait until NextCase = 3;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_input_empty.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- empty_timeout
		wait until NextCase = 4;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_empty_timeout.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- cmd_full
		wait until NextCase = 5;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_cmd_full.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- data_full
		wait until NextCase = 6;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_data_full.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';
		-- errors
		wait until NextCase = 7;
		ProcessDone(TbProcNr_mem_cmd_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_errors.mem_cmd(Clk, Mem_CmdAddr, Mem_CmdSize, Mem_CmdVld, Mem_CmdRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_cmd_c) <= '1';		
		wait;
	end process;
	
	-- *** mem_dat ***
	p_mem_dat : process
	begin
		-- aligned
		wait until NextCase = 0;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_aligned.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- unaligned
		wait until NextCase = 1;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_unaligned.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- no_data_read
		wait until NextCase = 2;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_no_data_read.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- input_empty
		wait until NextCase = 3;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_input_empty.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- empty_timeout
		wait until NextCase = 4;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_empty_timeout.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- cmd_full
		wait until NextCase = 5;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_cmd_full.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- data_full
		wait until NextCase = 6;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_data_full.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';
		-- errors
		wait until NextCase = 7;
		ProcessDone(TbProcNr_mem_dat_c) <= '0';
		work.psi_ms_daq_daq_dma_tb_case_errors.mem_dat(Clk, Mem_DatData, Mem_DatVld, Mem_DatRdy, Generics_c);
		wait for 1 ps;
		ProcessDone(TbProcNr_mem_dat_c) <= '1';		
		wait;
	end process;
	
	
end;
