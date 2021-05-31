
library ieee; 
use ieee.std_logic_1164.all; 
--------------------------------------ADDer And SUBtractor-----------
ENTITY partA IS 
    Port(
        Dest,Src : in std_logic_vector(15 downto 0); 
        c_in: in std_logic; 
        opcode:in std_logic_vector(4 downto 0);
        Z: out std_logic_vector(15 downto 0);
        c_out: out std_logic);
end partA; 
architecture archA of partA is
    component my_nadder is
        PORT (a, b : IN std_logic_vector(15 DOWNTO 0) ;
        cin : IN std_logic;
        s : OUT std_logic_vector(15 DOWNTO 0);
        cout : OUT std_logic);
    end component;
    Signal tempInput: std_logic_vector(15 downto 0);
    signal carry :std_logic; 
    signal tempCout : std_logic; 
begin   

    u0: my_nadder port map(Dest , tempInput , carry , Z , tempCout);
    tempInput <= 
    Src when (opcode = "00001") or (opcode = "00010") or (opcode = "01001")  else  -- A + B
    (not(Src)) when (opcode = "00011") or (opcode = "00100") or ( opcode = "01010") or (opcode = "01000");-- A - B + 1

    carry <= 
    c_in when (opcode = "00010") else
    not (c_in) when (opcode = "00100") else
    '1' when opcode = "00011"  or opcode = "01000" or opcode = "01010" else
    '0';
    c_out <= c_in when opcode =  "01001" or opcode = "01010"
	else tempCout;
end archA; 
