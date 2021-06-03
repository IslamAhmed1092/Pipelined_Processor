LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY execution_stage IS
	PORT(
		clk, reset: IN std_logic;
		ALU_Operation: IN std_logic_vector(4 downto 0);
		SrcAndImm_in, HasImmediate_in: IN std_logic;
		RsrcData_in, RdstData_in, Immediate_in: IN std_logic_vector(31 downto 0);
		MEMdstA, WBdstA: IN std_logic;
		MEMdstB, WBdstB: IN std_logic;
		MEMWBData, WBWBData: IN std_logic_vector(31 downto 0);

		ALU_Result: OUT std_logic_vector(31 downto 0);
		RdstData_out: OUT std_logic_vector(31 downto 0)
		
	);

END ENTITY execution_stage;

ARCHITECTURE execution_stage_Arch OF execution_stage IS

component ALU is
    	port (A, B : in std_logic_vector(31 downto 0);
		CCR_IN : in std_logic_vector(2 downto 0); 	-- (2) carry, (1) negative, (0) zero 
            	OPERATION: in std_logic_vector(4 downto 0); 
            	CCR_OUT: out std_logic_vector(2 downto 0);
		ALU_OUT: out std_logic_vector(31 downto 0));
END component; 


component reg is 
generic (n:INTEGER:= 32); 
port (clk, rst ,en, edge :IN std_logic; 
        d:In std_logic_vector(n-1 downto 0); 
        q:out std_logic_vector(n-1 downto 0 )); 
END component; 

signal ALU_CCR_OUT: std_logic_vector(2 downto 0);
signal CCR_OUT: std_logic_vector(2 downto 0);

signal first_operand, second_operand: std_logic_vector(31 downto 0);
signal A, B: std_logic_vector(31 downto 0);

BEGIN
	alu_com : ALU port map (A, B, CCR_OUT, ALU_Operation, ALU_CCR_OUT, ALU_Result);
	CCR: reg GENERIC MAP (3) port map(clk, reset, '1', '0', ALU_CCR_OUT, CCR_OUT);
	
	first_operand <= RdstData_in when SrcAndImm_in = '0'
	else RsrcData_in;

	second_operand <= RsrcData_in when HasImmediate_in = '0'
	else Immediate_in;

	A <= first_operand when MEMdstA = '0' and WBdstA = '0'
	else WBWBData when MEMdstA = '0' and WBdstA = '1'
	else MEMWBData when MEMdstA = '1';

	B <= second_operand when MEMdstB = '0' and WBdstB = '0'
	else WBWBData when MEMdstB = '0' and WBdstB = '1'
	else MEMWBData when MEMdstB = '1';

	RdstData_out <= RdstData_in when MEMdstA = '0' and WBdstA = '0'
	else WBWBData when MEMdstA = '0' and WBdstA = '1'
	else MEMWBData when MEMdstA = '1';

END execution_stage_Arch;
