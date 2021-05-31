library ieee; 
use ieee.std_logic_1164.all; 

entity processor is 
generic (n:integer := 32); 
port (
    clk ,rst, enable:in std_logic; 
    source , dest : in std_logic_vector(1 downto 0); 
    data_bus:inout std_logic_vector(n-1 downto 0));
end processor; 

architecture processor_arch of processor is
    component N_BIT_REG is
    generic (n:integer:=32);         
    port(clk, rst ,en :IN std_logic; 
    d:In std_logic_vector(n-1 downto 0); 
    q:out std_logic_vector(n-1 downto 0 )); 
    end component; 
    component decoder is port(ip: IN std_logic_vector(1 downto 0 ); 
    enable: IN std_logic; 
    op: out std_logic_vector(3 downto 0));
    end component; 
    component tristate is
    generic (n:integer:=32);     
    port  (ip:in std_logic_vector(n-1 downto 0);
    op:out std_logic_vector(n-1 downto 0); 
     en: std_logic); 
     end component; 
signal reg_0,reg_1,reg_2,reg_3:  std_logic_vector(n-1 downto 0);  
signal we:std_logic_vector(3 downto 0); 
signal re:std_logic_vector(3 downto 0); 
begin
    -- write in register from data bus when enabled and rising clk rising edge and ouput
    r0: N_BIT_REG generic map(n) port map (clk, rst, we(0), data_bus, reg_0); 
    r1: N_BIT_REG generic map(n) port map (clk, rst, we(1), data_bus, reg_1); 
    r2: N_BIT_REG generic map(n) port map (clk, rst, we(2), data_bus, reg_2); 
    r3: N_BIT_REG generic map(n) port map (clk, rst, we(3), data_bus, reg_3);

    t0: tristate generic map (n) port map (reg_0,data_bus,re(0));
    t1: tristate generic map (n) port map (reg_1,data_bus,re(1));
    t2: tristate generic map (n) port map (reg_2,data_bus,re(2));
    t3: tristate generic map (n) port map (reg_3,data_bus,re(3));

    d0:decoder port map (dest, enable, we); 
    d1:decoder port map (source, enable, re); 


end processor_arch; 