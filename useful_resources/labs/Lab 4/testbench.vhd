LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
Use work.MyPackage.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_a OF testbench IS
	
	COMPONENT and2 IS
		PORT ( a,b : IN std_logic;
			   z : OUT std_logic);
	END COMPONENT;
	
	SIGNAL testa, testb, testz : std_logic;
	
	BEGIN
		PROCESS
			BEGIN
				-- Test Case 1
				testa <= '0';
				testb <= '0';
				WAIT FOR 10 ns;
				ASSERT(testz = '0')
				REPORT  " Z is not zero for all 00"
				SEVERITY ERROR;
				
				-- Test Case 2
				testa <= '0';
				testb <= '1';
				WAIT FOR 10 ns;
				ASSERT(testz = '0')
				REPORT " Z is not zero for 01 "
				SEVERITY ERROR;
				
				-- Test Case 3
				testa <= '1';
				testb <= '0';
				WAIT FOR 10 ns;
				ASSERT(testz = '0')
				REPORT " Z is not zero for 10 "
				SEVERITY ERROR;
				
				-- Test Case 4
				testa <= '1';
				testb <= '1';
				WAIT FOR 10 ns;
				ASSERT(testz = '1')
				REPORT " Z is not 1 for 11 "
				SEVERITY ERROR;
				
				-- Stop Simulation
				WAIT;
		END PROCESS;

		uut: and2 PORT MAP (a => testa, b => testb, z =>testz);
		
END testbench_a;


ARCHITECTURE testbench_b OF testbench IS
	
	COMPONENT and2 IS
		PORT ( a,b : IN std_logic;
			   z : OUT std_logic);
	END COMPONENT;
	
	SIGNAL testa, testb, testz : std_logic;
	-- new array type
	Type inputtypes is array (0 TO 3) of std_logic_vector(2 downto 0);
	-- create test cases
	CONSTANT inputcases : inputtypes :=
           ("000","010","100","111");
	BEGIN
		PROCESS
			BEGIN
				for i in inputcases'range Loop
				testa <= inputcases(i)(2);
				testb <= inputcases(i)(1);
				WAIT FOR 10 ns;
				ASSERT(testz = inputcases(i)(0))
				REPORT  " Z is not"&std_logic'image(inputcases(i)(0))&" zero for "&to_string(inputcases(i)(2 downto 1))
				SEVERITY ERROR;
				
				end loop;
				-- Stop Simulation
				WAIT;
		END PROCESS;

		uut: and2 PORT MAP (a => testa, b => testb, z =>testz);
		
END testbench_b;


ARCHITECTURE testbench_c OF testbench IS
	
	COMPONENT and2 IS
		PORT ( a,b : IN std_logic;
			   z : OUT std_logic);
	END COMPONENT;
	
	SIGNAL test : std_logic_vector(2 downto 0);
	

	
	BEGIN
		PROCESS
		CONSTANT outCases : std_logic_vector(0 to 3) :="0001";
			BEGIN
				for i in 0 to 3 Loop
				test(2 downto 1) <= std_logic_vector(to_unsigned(i,2));
				
				WAIT FOR 10 ns;
				ASSERT(test(0) = outCases(i))
				REPORT  " Z is not"&std_logic'image(outCases(i))&" zero for "&integer'image(i)
				SEVERITY ERROR;
				
				end loop;
				-- Stop Simulation
				WAIT;
		END PROCESS;

		uut: and2 PORT MAP (a => test(2), b => test(1), z =>test(0));
		
END testbench_c;
