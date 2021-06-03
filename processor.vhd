LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity processor is 
	PORT(
		clk, reset: IN std_logic;
		in_port: IN std_logic_vector(31 downto 0)
	);
end entity processor; 

architecture processor_arch of processor is 

component fetch_stage IS
	PORT(
		clk, reset, pc_disable: IN std_logic;
		instruction: OUT std_logic_vector(31 downto 0)
	);
end component;
 
component reg is 
generic (n:INTEGER:= 32); 
port (clk, rst ,en, edge :IN std_logic; 
        d:In std_logic_vector(n-1 downto 0); 
        q:out std_logic_vector(n-1 downto 0 )); 
END component; 


component decode_stage IS
	PORT(
		clk, reset, writeBackNow: IN std_logic;
		instruction, in_port: IN std_logic_vector(31 downto 0);
		writeReg : IN std_logic_vector(2 downto 0);
		writeData : IN std_logic_vector (31 downto 0);
		RdstRead, hasRsrc, Push, Pop, outPortEnable, writeBackNext, hasImm, SrcAndImm, memWrite,
		memRead, stdEnable: OUT std_logic;
		ALU_operation : OUT std_logic_vector (4 downto 0);
		imm, src, dst : OUT std_logic_vector (31 downto 0);
		SrcRead, DstRead : OUT std_logic_vector (2 downto 0)
	);
end component;


-- Fetch Stage
signal fetch_instruction_out: std_logic_vector(31 downto 0);

signal IFID_INPUT: std_logic_vector(63 downto 0);
signal IFID_OUT: std_logic_vector(63 downto 0);



-- Decode Stage
signal IFID_RdstRead, IFID_hasRsrc, IFID_Push, IFID_Pop, IFID_outPortEnable, 
	IFID_writeBackNext, IFID_hasImm, IFID_SrcAndImm, IFID_memWrite, IFID_memRead, IFID_stdEnable : std_logic;

signal IFID_ALU_operation : std_logic_vector (4 downto 0);
signal IFID_imm, IFID_src, IFID_dst : std_logic_vector (31 downto 0);
signal IFID_SrcNum, IFID_DstNum :std_logic_vector (2 downto 0);

signal IDEX_INPUT: std_logic_vector(117 downto 0);
signal IDEX_OUT: std_logic_vector(117 downto 0);

constant IFID_RdstRead_IDX 					: integer := 0;
constant IFID_hasRsrc_IDX 					: integer := 1;
constant IFID_Push_IDX 						: integer := 2;
constant IFID_Pop_IDX 						: integer := 3;
constant IFID_outPortEnable_IDX 			: integer := 4;
constant IFID_writeBackNext_IDX 			: integer := 5;
constant IFID_hasImm_IDX 					: integer := 6;
constant IFID_SrcAndImm_IDX 				: integer := 7;
constant IFID_memWrite_IDX 					: integer := 8;
constant IFID_memRead_IDX 					: integer := 9;
constant IFID_stdEnable_IDX 				: integer := 10;
constant IFID_ALU_operation_ST_IDX 			: integer := 11; 
constant IFID_ALU_operation_END_IDX 		: integer := 15;
constant IFID_imm_ST_IDX 					: integer := 16; 
constant IFID_imm_END_IDX 					: integer := 47;
constant IFID_src_ST_IDX 					: integer := 48; 
constant IFID_src_END_IDX 					: integer := 79;
constant IFID_dst_ST_IDX 					: integer := 80; 
constant IFID_dst_END_IDX 					: integer := 111;
constant IFID_SrcNum_ST_IDX 				: integer := 112; 
constant IFID_SrcNum_END_IDX 				: integer := 114;
constant IFID_DstNum_ST_IDX 				: integer := 115; 
constant IFID_DstNum_END_IDX 				: integer := 117;

begin
	-- fetch
	fs: fetch_stage PORT MAP(clk, reset, '0', fetch_instruction_out);
	IFID: reg GENERIC MAP (64) port map(clk, reset, '1', '1', IFID_INPUT, IFID_OUT);
	
	IFID_INPUT(63 downto 32) <= fetch_instruction_out;
	IFID_INPUT(31 downto 0) <= in_port;
	
	-- decode
	ds: decode_stage PORT MAP(clk, reset, '0', IFID_OUT(63 downto 32), IFID_OUT(31 downto 0), "000", (others => '0'), IFID_RdstRead, 
	IFID_hasRsrc, IFID_Push, IFID_Pop, IFID_outPortEnable, IFID_writeBackNext, IFID_hasImm, 
	IFID_SrcAndImm, IFID_memWrite, IFID_memRead, IFID_stdEnable, IFID_ALU_operation, IFID_imm,
	IFID_src, IFID_dst, IFID_SrcNum, IFID_DstNum);

	IDEX: reg GENERIC MAP (118) port map(clk, reset, '1', '1', IDEX_INPUT, IDEX_OUT);



	IDEX_INPUT(IFID_RdstRead_IDX) <= IFID_RdstRead;		
	IDEX_INPUT(IFID_hasRsrc_IDX) <= IFID_hasRsrc;			
	IDEX_INPUT(IFID_Push_IDX) <= IFID_Push;			
	IDEX_INPUT(IFID_Pop_IDX) <= IFID_Pop;				
	IDEX_INPUT(IFID_outPortEnable_IDX) <= IFID_outPortEnable; 	
	IDEX_INPUT(IFID_writeBackNext_IDX) <= IFID_writeBackNext;	
	IDEX_INPUT(IFID_hasImm_IDX) <= IFID_hasImm;	
	IDEX_INPUT(IFID_SrcAndImm_IDX) <= IFID_SrcAndImm; 		
	IDEX_INPUT(IFID_memWrite_IDX) <= IFID_memWrite;			
	IDEX_INPUT(IFID_memRead_IDX) <= IFID_memRead;			
	IDEX_INPUT(IFID_stdEnable_IDX) <= IFID_stdEnable; 		
	IDEX_INPUT(IFID_ALU_operation_END_IDX downto IFID_ALU_operation_ST_IDX) <= IFID_ALU_operation; 	
	IDEX_INPUT(IFID_imm_END_IDX downto IFID_imm_ST_IDX) <= IFID_imm;			
	IDEX_INPUT(IFID_src_END_IDX downto IFID_src_ST_IDX) <= IFID_src; 			
	IDEX_INPUT(IFID_dst_END_IDX downto IFID_dst_ST_IDX) <= IFID_dst;			
	IDEX_INPUT(IFID_SrcNum_END_IDX downto IFID_SrcNum_ST_IDX) <= IFID_SrcNum; 		
	IDEX_INPUT(IFID_DstNum_END_IDX downto IFID_DstNum_ST_IDX) <= IFID_DstNum;


	-- execute

	
end processor_arch;
