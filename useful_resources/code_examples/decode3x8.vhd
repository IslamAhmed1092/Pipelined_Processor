library ieee; 
use ieee.std_logic_1164.all; 
USE IEEE.numeric_std.all;

entity decode3x8 is 
port ( sel : std_logic_vector(2 downto 0 );
        regs : out std_logic_vector(7 downto 0)
        ); 
end decode3x8;

architecture decode3x8_arch of decode3x8 is 
begin 
    regs <= x"01" when sel = "000"
    else x"02" when sel = "001"
    else x"04" when sel = "010"
    else x"08" when sel = "011"
    else x"10" when sel = "100"
    else x"20" when sel = "101"
    else x"40" when sel = "110"
    else x"80" when sel = "111";

end  decode3x8_arch;
