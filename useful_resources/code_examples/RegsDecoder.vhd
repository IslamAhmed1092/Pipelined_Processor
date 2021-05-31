library ieee; 
use ieee.std_logic_1164.all; 
USE IEEE.numeric_std.all;

entity RegsDecoder is 
port (  Rdst_out, Rdst_in,Rsrc_out,Rsrc_in: In std_logic;
        IR_reg : IN std_logic_vector(15 downto 0);
        Regs_in_signal, Regs_out_signal: out std_logic_vector(7 downto 0)); 
end RegsDecoder;

architecture RegDecoder_arc of RegsDecoder is 
component decode3x8 is 
port(sel : std_logic_vector(2 downto 0 );
     regs : out std_logic_vector(7 downto 0)
    ); 
end component;
    signal src_reg: std_logic_vector(7 downto 0); 
    signal dst_reg: std_logic_vector(7 downto 0); 
    signal is2op: std_logic;
    signal dest_loc : std_logic_vector(2 downto 0); 
begin
    d1: decode3x8 port map (IR_reg(8 downto 6),src_reg);
    d2: decode3x8 port map (dest_loc,dst_reg);

    dest_loc <= IR_reg(2 downto 0) when is2op = '1'
    else IR_reg(4 downto 2);

    is2op <= '0' when IR_reg(15 downto 13) = "110" or IR_reg(15 downto 12) = "1110" or IR_reg(15 downto 11) = "11110" or IR_reg(15 downto 11) = "11111"
    else '1';

    Regs_in_signal <= src_reg when Rsrc_in = '1' and is2op = '1'
    else dst_reg when Rdst_in = '1'
    else x"00" ;

    Regs_out_signal <= src_reg when Rsrc_out = '1' and is2op = '1'
    else dst_reg when Rdst_out = '1'
    else x"00" ;
end  RegDecoder_arc;