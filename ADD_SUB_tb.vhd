LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
Use work.MyPackage.ALL;

ENTITY ADD_SUB_tb IS
END ADD_SUB_tb;

ARCHITECTURE testbench_b OF ADD_SUB_tb IS
	
	COMPONENT ADD_SUB is 
	Port(
        	A, B : in std_logic_vector(31 downto 0);  
        	isSUB:in std_logic;		-- 1 if sub and 0 if add
        	S: out std_logic_vector(31 downto 0);
        	cout: out std_logic);
	END COMPONENT;
	
	SIGNAL A, B : std_logic_vector(31 downto 0);
	SIGNAL isSUB: std_logic;
	SIGNAL S: std_logic_vector(31 downto 0);
	SIGNAL cout: std_logic;

	-- new array type
	Type inputtypes is array (0 TO 4) of std_logic_vector(31 downto 0);
	Type operations is array (0 TO 4) of std_logic;
	Type couts is array (0 TO 4) of std_logic;

	-- create test cases
	CONSTANT As : inputtypes :=
        ("10000000001100000000000000000000",
	"10000000000000000000000000000000",
	"00000000000000000000000000100011",
	"00000000000000000000000000000001",
	"10000000000000000000000000000000");

	CONSTANT Bs : inputtypes :=
        ("00000100101100001000000000000010",
	"10000000000000000000000000000001",
	"00000000000000000000000000000101",
	"00000000000000000000000000000010",
	"01000000000000000000000000000000");

	CONSTANT ops : operations :=
        ('0','0','1','1','1');

	CONSTANT Ss : inputtypes :=
        ("10000100111000001000000000000010",
	"00000000000000000000000000000001",
	"00000000000000000000000000011110",
	"11111111111111111111111111111111",
	"01000000000000000000000000000000");
	
	CONSTANT Cs : couts :=
        ('0','1','0','0','1');


	BEGIN
		PROCESS
			BEGIN
				for i in As'range Loop
				A <= As(i);
				B <= Bs(i);
				isSUB <= ops(i);
				WAIT FOR 10 ns;
				ASSERT(S = Ss(i))
				REPORT  "Error"
				SEVERITY ERROR;
				
				end loop;
				-- Stop Simulation
				WAIT;
		END PROCESS;

		A_S: ADD_SUB PORT MAP (A => A, B => B, isSUB => isSUB, S => S, cout => cout);
		
END testbench_b;
