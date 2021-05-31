library ieee; 
use ieee.std_logic_1164.all; 

entity tristate is 
generic (n:integer := 16);
port (ip:in std_logic_vector(n-1 downto 0);
      op:out std_logic_vector(n-1 downto 0); 
     en: std_logic); 
end  tristate;

architecture tristate_arch of tristate is 
begin 
    op <= ip when en = '1'
    else (others => 'Z'); 
end tristate_arch; 