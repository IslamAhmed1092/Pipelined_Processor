LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
Use work.MyPackage.ALL;

ENTITY shift_rot_tb IS
END shift_rot_tb;

ARCHITECTURE testbench_b OF shift_rot_tb IS
	
	COMPONENT shift_rot is 
	Port(
        A, B : in std_logic_vector(31 downto 0);  
        operation:in std_logic_vector(4 downto 0);
        S: out std_logic_vector(31 downto 0);
	cin : in std_logic ;
        cout: out std_logic);
	END COMPONENT;
	
	SIGNAL A, B : std_logic_vector(31 downto 0);
	SIGNAL operation: std_logic_vector(4 downto 0);
	SIGNAL S: std_logic_vector(31 downto 0);
	SIGNAL cin: std_logic;
	SIGNAL cout: std_logic;

	-- new array type
	Type operands is array (0 TO 7) of std_logic_vector(31 downto 0);
	Type operations is array (0 TO 7) of std_logic_vector(4 downto 0);
	Type carrys is array (0 TO 7) of std_logic;

	-- create test cases
	CONSTANT As : operands :=
        ("10000000001100000000000000000000",
	"10000000000000000000000000000000",
	"00000000000000000000000000100011",
	"00000000000000000000000000000001",
	"10000000000000000000000000000000",
	"00010000000000000000000001000001",
	"00000000000000000000000000000100",
	"00000000000000000000000000000001");

	CONSTANT Bs : operands :=
        ("00000100101100001000000000000010",
	"10000000000000000000000000000001",
	"00000000000000000000000000000101",
	"00000000000000000000000000000010",
	"01000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000",
	"00000000000000000000000000000000");

	CONSTANT ops : operations :=
        ("00010",
		"00010",
		"00011",
		"00011",
		"00011",
		"01010",
		"01011",
		"01100");

	CONSTANT Ss : operands :=
        ("10000100111000001000000000000010",
	"00000000000000000000000000000001",
	"00000000000000000000000000011110",
	"11111111111111111111111111111111",
	"01000000000000000000000000000000",
	"00010000000000000000000001000010",
	"00000000000000000000000000000011",
	"11111111111111111111111111111111");
	
	CONSTANT Couts : carrys :=
        ('0','1','1','0','1','0','1','0');

	CONSTANT Cins : carrys :=
        ('0','1','1','0','1','0','1','0');


	BEGIN
		PROCESS
			BEGIN
				for i in As'range Loop
				A <= As(i);
				B <= Bs(i);
				cin <= Cins(i);
				operation <= ops(i);
				WAIT FOR 100 ps;
				ASSERT(S = Ss(i) and cout = Couts(i))
				REPORT  "Error"
				SEVERITY ERROR;
				
				end loop;
				-- Stop Simulation
				WAIT;
		END PROCESS;

		S_O: shift_rot PORT MAP (A => A, B => B, operation => operation,cin <= cin, S => S, cout => cout);
		
END testbench_b;