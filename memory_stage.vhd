LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY memory_stage IS
	PORT(
		clk, pop, push, Memory_Write, Memory_Read, STD_Enable: IN std_logic;
		Rsrc_Data: in std_logic_vector(31 DOWNTO 0);
		Rdst_Data: in std_logic_vector(31 DOWNTO 0);
		ALU_Result: in std_logic_vector(31 DOWNTO 0);
		SP_Addr_In: in std_logic_vector(31 DOWNTO 0);
		SP_Addr_Out: out std_logic_vector(31 DOWNTO 0);
		dataout : out std_logic_vector(31 DOWNTO 0)
	);

END ENTITY memory_stage;

ARCHITECTURE memory_stage_Arch OF memory_stage IS

component Data_Memory IS
	PORT(
		clk : IN std_logic;
		writeEnable  : IN std_logic;
		address : IN  std_logic_vector(19 DOWNTO 0); 
		datain  : IN  std_logic_vector(31 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END component; 

signal SP_Addr: std_logic_vector(31 DOWNTO 0);
signal memory_out: std_logic_vector(31 DOWNTO 0);
signal memory_in: std_logic_vector(31 DOWNTO 0);
signal memory_addr: std_logic_vector(31 DOWNTO 0);

BEGIN
	dm : Data_Memory port map (clk, Memory_Write, memory_addr(19 downto 0), memory_in, memory_out);

	SP_Addr <= std_logic_vector(to_unsigned(to_integer(unsigned(SP_Addr_In)) + 2, 32)) when pop = '1'
	else SP_Addr_In;
	
	memory_addr <= SP_Addr when push = '1' or pop = '1'
		else ALU_Result;

	memory_in <= Rdst_Data when STD_Enable = '1'
		else Rsrc_Data;
	
	dataout <= memory_out when Memory_Read = '1';
	
	SP_Addr_Out <= SP_Addr;
	

END memory_stage_Arch;