
library ieee; 
use ieee.std_logic_1164.all;

entity ALU is
    port ( ALU_A, ALU_B : in std_logic_vector(15 downto 0);
            ALU_Cin : in std_logic; 
            ALU_S : in std_logic_vector(4 downto 0); 
            ALU_F: out std_logic_vector(15 downto 0); 
            ALU_Cout: out std_logic) ;
end ALU;

architecture arch of AlU IS 
    component partB  is 
		PORT( Dest, Src : IN std_logic_vector(15 DOWNTO 0); 
		opcode : IN std_logic_vector ( 4 DOWNTO 0); 
		Z : OUT std_logic_vector(15 DOWNTO 0)); 
    end component;
    component partC IS 
	PORT(A : In std_logic_vector(15 DownTO 0);
		S : IN std_logic_vector( 4 DOWNTO 0); 
		CIN : IN std_logic; 	
		F : out std_logic_vector(15 DOWNTO 0);
		Cout : OUT std_logic); 
END component;
component partD IS 
	PORT( A : IN std_logic_vector(15 downto 0); 
	 	Cin : IN std_logic; 
		S : IN std_logic_vector( 4 DOWNTO 0); 
		F: out std_logic_vector(15 downto 0); 
		Cout : OUT std_logic); 
END component;   
component partA is
	Port(
        Dest,Src : in std_logic_vector(15 downto 0); 
        c_in: in std_logic; 
        opcode:in std_logic_vector(4 downto 0);
        Z: out std_logic_vector(15 downto 0);
        c_out: out std_logic);
END component; 
Signal partAF, partBF,partCF,partDF , src: std_logic_vector( 15 downto 0);
Signal partA_carry, partC_carry,partD_carry : std_logic; 
begin 
		
		u0 : partB port map (ALU_A , src , ALU_S , partBF);
		u1 : partC port map (ALU_A , ALU_S, ALU_Cin, partCF,partC_carry);
		u2 : partD port map (ALU_A , ALU_Cin , ALU_S, partDF,partD_carry);
		u3 : partA port map (ALU_A ,src ,ALU_Cin , ALU_S, partAF, partA_carry);

		src <= x"0001" when (ALU_S = "01010" or ALU_S = "01001") 
		else ALU_B ;

		ALU_F <= partAF when (ALU_S = "00001" or ALU_S ="00010" or ALU_S = "00011" or ALU_S = "00100" or ALU_S = "01001" or ALU_S = "01010" or ALU_S = "01000")  -- inc and dec 
		else partCF when (ALU_S ="01101" or ALU_S = "01110" or ALU_S ="01111")
		else partDF when (ALU_S ="10000" or ALU_S ="10001")
	    else partBF ;

		ALU_Cout <= partA_carry when (ALU_S = "00001" or ALU_S ="00010" or ALU_S = "00011" or ALU_S = "00100" or ALU_S = "01001" or ALU_S = "01010" or ALU_S = "01000")  -- inc and dec 
		else partC_carry when (ALU_S ="01101" or ALU_S = "01110" or ALU_S ="01111")
		else partD_carry when (ALU_S ="10000" or ALU_S ="10001");
end arch; 