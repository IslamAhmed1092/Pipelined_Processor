
library ieee; 
use ieee.std_logic_1164.all; 
USE IEEE.numeric_std.all;

entity PLA is 
port (IR_reg:IN std_logic_vector(15 downto 0);
    out_data: out std_logic_vector(8 downto 0));
end PLA; 

architecture PLA_arc of PLA is 
begin 
	out_data<=	o"270" when  IR_reg(15 downto 13) ="110"--branch
		    else o"010" when IR_reg(15 downto 11) ="11111"--jump sub-routine
            else o"140" when IR_reg(15 downto 11) = "11110"--no oprand
	    else o"470" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 5 ) ="000" --one oprand direct reg
            else o"500" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 5 ) ="001" --one oprand indirect reg
            else o"510" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 6 ) ="01" --one oprand auto increment and indirect auto increment
            else o"520" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 6 ) ="10" --one oprand auto decrement and indirect auto decrement
            else o"530" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 6 ) ="11" --one oprand indexed and indexed indirect
            else o"420" when  IR_reg(11 downto 9 ) ="000" --two oprand direct reg
            else o"430" when  IR_reg(11 downto 9 ) ="001" --two oprand indirect reg
            else o"440" when  IR_reg(11 downto 10 ) ="01" --two oprand auto increment and indirect auto increment
            else o"450" when  IR_reg(11 downto 10 ) ="10"  --two oprand auto decrement and indirect auto decrement
            else o"460";  --two oprand indexed and indexed indirect
    end PLA_arc; 
