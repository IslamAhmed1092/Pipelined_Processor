
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
Use work.MyPackage.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE testbench_b OF ALU_tb IS
	
	COMPONENT ALU is 
	 port (	A, B : in std_logic_vector(31 downto 0);
		CCR_IN : in std_logic_vector(2 downto 0); 	-- (2) carry, (1) negative, (0) zero 
            	OPERATION: in std_logic_vector(4 downto 0); 
            	CCR_OUT: out std_logic_vector(2 downto 0);
		ALU_OUT: out std_logic_vector(31 downto 0));
	END COMPONENT;
	
	SIGNAL A, B : std_logic_vector(31 downto 0);
	SIGNAL operation: std_logic_vector(4 downto 0);
	SIGNAL ALU_OUT: std_logic_vector(31 downto 0);
	SIGNAL CCR_OUT: std_logic_vector(2 downto 0);
	SIGNAL CCR_IN: std_logic_vector(2 downto 0);

	-- new array type
	Type operands is array (0 TO 19) of std_logic_vector(31 downto 0);
	Type operations is array (0 TO 19) of std_logic_vector(4 downto 0);
	Type carrys is array (0 TO 19) of std_logic_vector(2 downto 0);

	-- create test cases
	CONSTANT As : operands :=
        ("01100000000000000000000000000110",
	"10000000000000000000000000000000",
	"00000000000000000000000000001111",
	"00000000000000000000000000000110",
	"01100000000000000000000000000110",
	"01100000000000000000000000000110",
	"00000000000000000000000000000100",
	"01100000000000000000000000000000",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111",
	"11111111111111111111111111111111");

	CONSTANT Bs : operands :=
        ("01100000000000000000000000000110",
	"01100000000000000000000000000110",
	"01000000000000000000000000000010",
	"00000000000000000000000000000111",
	"01100000000000000000000000000000",
	"01100000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000101",
	"00000000000000000000000000000011",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000");

	CONSTANT ops : operations :=
        ("00000",
	"00001",
	"00010",
	"00011",
	"00100",
	"00101",
	"01000",
	"01001",
	"01010",
	"01011",
	"01100",
	"00110",
	"00111",
	"01101",
	"01110",
	"01111",
	"10000",
	"01100",
	"01100",
	"01100");

	CONSTANT ALU_OUTs : operands :=
        ("01100000000000000000000000000110",
	"01100000000000000000000000000110",
	"01000000000000000000000000010001",
	"11111111111111111111111111111111",
	"01100000000000000000000000000000",
	"01100000000000000000000000000110",
	"00000000000000000000000000000000",
	"10011111111111111111111111111111",
	"00000000000000000000000000000000",
	"11111111111111111111111111111110",
	"00000000000000000000000000000001",
	"11111111111111111111111111100000",
	"00011111111111111111111111111111",
	"11111111111111111111111111111111",
	"01111111111111111111111111111111",
	"00000000000000000000000000000001",
	"00000000000000000000000000000001",
	"00000000000000000000000000000001",
	"00000000000000000000000000000001",
	"00000000000000000000000000000001");
	
	CONSTANT Couts : carrys :=
        ("000",	"000",	"000",	"110",	"000",	"000",	"001",	"010",	"101",	"010",	"000",	"110",
	"100",	"110",	"100",	"100",	"000",	"000",	"000",	"000");

	CONSTANT Cins : carrys :=
        ("000",	"000",	"000",	"000",	"000",	"000",	"000",
	"000",	"000",	"000",	"000",	"100",	"000",	"100",	"000",	"000",	"000",	"000",	"000",	"000");



	BEGIN
		PROCESS
			BEGIN
				for i in As'range Loop
				A <= As(i);
				B <= Bs(i);
				operation <= ops(i);
				CCR_IN <= Cins(i);
				WAIT FOR 100 ps;
				ASSERT(ALU_OUT = ALU_OUTs(i))
				REPORT  "Error in ALU out"
				SEVERITY ERROR;

				ASSERT(CCR_OUT = Couts(i))
				REPORT  "Error in Couts"
				SEVERITY ERROR;
				
				end loop;
				-- Stop Simulation
				WAIT;
		END PROCESS;

		ALU_I: ALU PORT MAP (A => A, B => B, OPERATION => OPERATION, ALU_OUT => ALU_OUT, CCR_OUT => CCR_OUT, CCR_IN => CCR_IN);
		
END testbench_b;