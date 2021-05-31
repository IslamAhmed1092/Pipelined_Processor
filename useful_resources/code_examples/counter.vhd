library ieee; 
use ieee.std_logic_1164.all; 
USE IEEE.numeric_std.all;

entity counter is 
generic (n: integer := 6);
port (rst, clk, enable : IN std_logic; 
        op : out std_logic_vector(n-1 downto 0)); 
end counter ; 

architecture counter_arch of counter is
    signal q : std_logic_vector(n-1 downto 0); 
begin
    process(clk,rst)
    begin 
        if rst = '1' then 
            q <= "001010"; 
        elsif clk'event and clk = '1' and enable = '1' then 
            q <= std_logic_vector(to_unsigned(to_integer(unsigned(q))-1,n));
        end if; 
    end process; 
    op <= q; 
end counter_arch ; -- counter_arch