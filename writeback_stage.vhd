LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


entity writeback_stage is Port(
    push , memRead : in std_logic; 
    SP_address, mem_out, ALU_result : in std_logic_vector(31 downto 0 ); 
    WB_data , SP_data: out std_logic_vector(31 downto 0)  
);
end entity writeback_stage; 

architecture writeback_stage_arch of writeback_stage is 
    begin
        SP_data <= SP_address when (push = '0') else (std_logic_vector(unsigned(SP_address) - 2)); 
        WB_data <= mem_out when (memRead = '1') else ALU_result; 
    end writeback_stage_arch; 