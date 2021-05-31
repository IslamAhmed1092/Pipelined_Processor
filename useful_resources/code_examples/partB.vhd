
library ieee; 
use ieee.std_logic_1164.all; 
ENTITY partB IS 
	PORT( Dest, Src : IN std_logic_vector(15 DOWNTO 0); 
		opcode : IN std_logic_vector ( 4 DOWNTO 0); 
		Z : OUT std_logic_vector(15 DOWNTO 0)); 
END partB; 
architecture archB of partB is
	begin
		with opcode select Z <= 
		Src when "00000",	-- move
		Dest and Src when "00101",  -- AND
		Dest or Src when "00110", -- OR
		Dest xor Src when "00111", -- XOR
		not(Dest) when "01100", -- INV
		x"0000" when others; --Clear
	end archB;