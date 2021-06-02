library ieee; 
use ieee.std_logic_1164.all; 
--------------------------------------ADDer And SUBtractor-----------
ENTITY ADD_SUB IS 
    Port(
        A, B : in std_logic_vector(31 downto 0);  
        isSUB:in std_logic;		-- 1 if sub and 0 if add
        S: out std_logic_vector(31 downto 0);
        cout: out std_logic);
end ADD_SUB; 
architecture arch of ADD_SUB is
    component my_adder is
        PORT (a, b : IN std_logic_vector(31 DOWNTO 0) ;
	cin : IN std_logic;
        s : OUT std_logic_vector(31 DOWNTO 0);
        cout : OUT std_logic);
    end component;

    signal Btemp: std_logic_vector(31 downto 0);
    signal cin :std_logic; 
begin   
	u0: my_adder port map(A , Btemp , cin , s , cout);
    	Btemp <= B when isSub = '0' 
	else  not B;		-- A - B + 1
    	
    	cin <= '1' when isSUB = '1' 
	else '0';

end arch; 

