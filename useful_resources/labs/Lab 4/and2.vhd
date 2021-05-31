LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY and2 IS
	PORT( a,b : IN std_logic;
		  z : OUT std_logic);
END and2;

ARCHITECTURE and_a OF and2 IS
	BEGIN
		z <= a or b;
END and_a;