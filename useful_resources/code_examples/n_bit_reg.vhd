library ieee; 
use ieee.std_logic_1164.all; 

entity N_BIT_REG is 
generic (n:INTEGER:= 32); 
port (clk, rst ,en :IN std_logic; 
        d:In std_logic_vector(n-1 downto 0); 
        q:out std_logic_vector(n-1 downto 0 )); 
end N_BIT_REG; 

architecture N_BIT_REG_Arch of N_BIT_REG is
begin 
    process (clk,rst)
    begin 
    if rst = '1' then 
        q <= (others=>'0'); 
    elsif clk'event and clk = '1' and en = '1' then 
        q <= d; 
    end if;  
    end process; 
end N_BIT_REG_Arch; 