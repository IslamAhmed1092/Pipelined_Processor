library ieee; 
use ieee.std_logic_1164.all; 

entity lab4_unit is 
generic (n:integer := 32); 
port (
    clk , rst, src_en, dest_en :in std_logic; 
    src , dest : in std_logic_vector(1 downto 0));
end lab4_unit; 

architecture lab4_unit_arch of lab4_unit is
    
    component N_BIT_REG is 
    generic (n:INTEGER:= 32); 
    port(clk, rst ,en :IN std_logic; 
            d:In std_logic_vector(n-1 downto 0); 
            q:out std_logic_vector(n-1 downto 0 )); 
    end component; 
    component decoder is port(ip: IN std_logic_vector(1 downto 0 ); 
    enable: IN std_logic; 
    op: out std_logic_vector(3 downto 0));
    end component; 
    component tristate is
    generic (n:INTEGER:= 32); 
    port(ip:in std_logic_vector(n-1 downto 0);
            op:out std_logic_vector(n-1 downto 0); 
            en: std_logic); 
    end component; 
    component ram is 
    generic (n:INTEGER:= 32); 
    port (in_data:IN std_logic_vector(n -1 downto 0);
        out_data: out std_logic_vector(n-1 downto 0); 
        address: In std_logic_vector(5 downto 0); 
        clk,we : In std_logic );
    end component; 
    component counter is
    generic (n:INTEGER:= 6); 
    port  (rst, clk, enable : IN std_logic; 
    op : out std_logic_vector(n-1 downto 0)); 
    end component; 
    
signal reg_0,reg_1,reg_2,reg_3,ram_out:  std_logic_vector(n-1 downto 0);  
signal we:std_logic_vector(3 downto 0); 
signal re:std_logic_vector(3 downto 0); 
signal data_bus:std_logic_vector(n-1 downto 0);
signal src_temp,dest_temp: std_logic; 
signal ram_address: std_logic_vector(5 downto 0); 
begin

    r0: N_BIT_REG generic map(n) port map (clk, rst, we(0), data_bus, reg_0); 
    r1: N_BIT_REG generic map(n) port map (clk, rst, we(1), data_bus, reg_1); 
    r2: N_BIT_REG generic map(n) port map (clk, rst, we(2), data_bus, reg_2); 
    r3: N_BIT_REG generic map(n) port map (clk, rst, we(3), data_bus, reg_3);

    t0: tristate generic map (n) port map (reg_0, data_bus, re(0));
    t1: tristate generic map (n) port map (reg_1, data_bus, re(1));
    t2: tristate generic map (n) port map (reg_2, data_bus, re(2));
    t3: tristate generic map (n) port map (reg_3, data_bus, re(3));

    r: ram generic map (n) port map( data_bus, ram_out, ram_address, clk, dest_temp); 
    ram_t: tristate generic map (n) port map (ram_out, data_bus, src_temp);   

    c: counter generic map (6) port map(rst, clk, '1', ram_address);

    src_temp <= not src_en; 
    dest_temp <= not dest_en; 

    d0:decoder port map (dest, dest_en, we); 
    d1:decoder port map (src, src_en, re); 

end lab4_unit_arch; 