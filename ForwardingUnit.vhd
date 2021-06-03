LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Forwarding_Unit IS
	PORT(
		ID_EX_RdstRead : in std_logic;
		ID_EX_HasRsrc : in std_logic;
		ID_EX_SrcImm : in std_logic;
		ID_EX_Rdst : in std_logic_vector(2 downto 0);
		ID_EX_Rsrc : in std_logic_vector(2 downto 0);

		EX_MEM_WB : in std_logic;
		EX_MEM_DstReg : in std_logic_vector(2 downto 0);

		MEM_WB_WB : in std_logic;
		MEM_WB_DstReg : in std_logic_vector(2 downto 0);

		WBdstA : out std_logic;
		MEMdstA : out std_logic;
		WBdstB : out std_logic;
		MEMdstB : out std_logic
	);

END ENTITY Forwarding_Unit;

ARCHITECTURE Forwarding_Unit_Arch OF Forwarding_Unit IS
BEGIN
	MEMdstA <= '1' when (ID_EX_RdstRead = '1' AND EX_MEM_WB = '1' AND (ID_EX_Rdst xnor EX_MEM_DstReg) = "111")  
		or (ID_EX_SrcImm = '1' and EX_MEM_WB = '1' and (ID_EX_Rsrc xnor EX_MEM_DstReg) = "111")
		else '0';
	
	WBdstA <= '1' when (ID_EX_RdstRead = '1' and MEM_WB_WB = '1' and (ID_EX_Rdst xnor MEM_WB_DstReg) = "111")
			or (ID_EX_SrcImm = '1' and MEM_WB_WB = '1' and (ID_EX_Rsrc xnor MEM_WB_DstReg) = "111") 
			else '0';

	MEMdstB <= '1' when (ID_EX_HasRsrc = '1' and ID_EX_SrcImm = '0' and EX_MEM_WB = '1' and (ID_EX_Rsrc xnor EX_MEM_DstReg) = "111")
		else '0';

	WBdstB <= '1' when (ID_EX_HasRsrc = '1' and ID_EX_SrcImm = '0' and MEM_WB_WB = '1' and (ID_EX_Rsrc xnor MEM_WB_DstReg) = "111")
		else '0';
END Forwarding_Unit_Arch;