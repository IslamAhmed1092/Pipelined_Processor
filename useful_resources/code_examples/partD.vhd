
library ieee; 
use ieee.std_logic_1164.all; 
ENTITY partD IS 
	PORT( A : IN std_logic_vector(15 downto 0); 
	 Cin : IN std_logic; 
		S : IN std_logic_vector( 4 DOWNTO 0); 
		F: out std_logic_vector(15 downto 0); 
		Cout : OUT std_logic); 
END partD; 

architecture archD of partD IS
begin 
		with S select  F  <=
		A(14 DownTO 0) & '0' when "10000", -- LSL
	    A(14 DownTO 0) & A(15) when "10001", -- ROL
		x"0000" when others;
		Cout  <= A(15);
end archD; 
