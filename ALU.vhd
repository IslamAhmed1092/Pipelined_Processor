library ieee; 
use ieee.std_logic_1164.all;

entity ALU is
    port (	ALU_A, ALU_B : in std_logic_vector(31 downto 0);
		CCR_IN : in std_logic_vector(2 downto 0); 	-- (2) carry, (1) negative, (0) zero 
            	OPERATION: in std_logic_vector(4 downto 0); 
            	CCR_OUT: out std_logic_vector(2 downto 0);
		ALU_OUT: out std_logic_vector(31 downto 0));
end ALU;

architecture arch of AlU IS 
begin 
		
end arch; 
