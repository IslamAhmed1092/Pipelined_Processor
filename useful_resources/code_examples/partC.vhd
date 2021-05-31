
library ieee; 
use ieee.std_logic_1164.all; 

ENTITY partC IS 
	PORT( 	A : In std_logic_vector(15 DownTO 0);
			S : IN std_logic_vector( 4 DOWNTO 0); 
			CIN : IN std_logic; 	
			F : out std_logic_vector(15 DOWNTO 0);
			Cout : OUT std_logic); 
END partC; 

architecture archC of partC is 
begin 
		Cout <= A(0);
		F(14 DownTO 0) <= A(15 DownTO 1);
	with S select F(15) <=
	    '0' when "01101", -- LSR
		A(0) when "01110", -- ROR
		A(15) when "01111", -- ASR
		'0' when others;  -- default LSR
end archC;