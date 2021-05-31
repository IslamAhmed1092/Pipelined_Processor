library ieee; 
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;


entity decoding_circuit is 
port ( flagReg: In std_logic_vector(15 downto 0);
       IR_reg: In std_logic_vector(15 downto 0);
       ORoperation, ORindsrc, ORinddest,ORdest, ORresult ,pla_en: In std_logic;
       nextAddress: IN std_logic_vector(8 downto 0);
       address: out std_logic_vector(8 downto 0));
end decoding_circuit; 

architecture decoding_circuit_arch of decoding_circuit is 
component  PLA is 
port (IR_reg:IN std_logic_vector(15 downto 0);
    out_data: out std_logic_vector(8 downto 0));
end component; 
signal pla_out: std_logic_vector(8 downto 0); 
signal is2op: std_logic; 
begin  

    p: PLA port map(IR_reg, pla_out);

    is2op <= '0' when IR_reg(15 downto 13) = "110" or IR_reg(15 downto 12) = "1110" or IR_reg(15 downto 11) = "11110" or IR_reg(15 downto 11) = "11111"   
    else '1';
    address <= pla_out when pla_en = '1'
    else o"470" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 5 ) ="000" and ORdest = '1' --one oprand direct reg
    else o"500" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 5 ) ="001" and ORdest = '1' --one oprand indirect reg
    else o"510" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 6 ) ="01" and ORdest = '1' --one oprand auto increment and indirect auto increment
    else o"520" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 6 ) ="10" and ORdest = '1' --one oprand aut0o decrement and indirect auto decrement
    else o"530" when IR_reg(15 downto 12) = "1110" and IR_reg(7 downto 6 ) ="11" and ORdest = '1' --one oprand indexed and indexed indirect

    else o"470" when is2op = '1' and IR_reg(5 downto 3 ) ="000" and ORdest = '1' --one oprand direct reg
    else o"500" when is2op = '1' and IR_reg(5 downto 3 ) ="001" and ORdest = '1' --one oprand indirect reg
    else o"510" when is2op = '1' and IR_reg(5 downto 4 ) ="01" and ORdest = '1' --one oprand auto increment and indirect auto increment
    else o"520" when is2op = '1' and IR_reg(5 downto 4 ) ="10" and ORdest = '1' --one oprand aut0o decrement and indirect auto decrement
    else o"530" when is2op = '1' and IR_reg(5 downto 4 ) ="11" and ORdest = '1' --one oprand indexed and indexed indirect
    
    else o"537"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0000"
    else o"540"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0001"
    else o"541"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0010"
    else o"542"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0011"
    else o"543"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0100"
    else o"544"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0101"
    else o"545"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0110"
    else o"546"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "0111"
    else o"547"  when ORoperation = '1' and is2op = '1' and  IR_reg(15 downto 12) = "1000"

    else o"550"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0000"
    else o"551"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0001"
    else o"552"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0010"
    else o"553"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0011"
    else o"554"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0100"
    else o"555"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0101"
    else o"556"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0110"
    else o"557"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "0111"
    else o"560"  when ORoperation = '1' and is2op = '0' and  IR_reg(11 downto 8) = "1000"
    -- two  resul
    else o"562" when ORresult = '1' and is2op = '1' and IR_reg(5 downto 3) = "000" 
    else o"561" when ORresult = '1' and is2op = '1'
    -- one 
    else o"562" when ORresult = '1' and is2op = '0' and IR_reg(7 downto 5) = "000"
    else o"561" when ORresult = '1' and is2op = '0'

    else o"536" when ORinddest = '1' and is2op = '1' and IR_reg(3) = '0'
    else o"535" when ORinddest = '1' and is2op = '1' and IR_reg(3) = '1'

    else o"466" when ORindsrc = '1' and IR_reg(9) = '0'
    else o"465" when ORindsrc = '1' and IR_reg(9) = '1'

    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "000" 
    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "001" and flagReg(1) = '1' 
    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "010" and flagReg(1) = '0'
    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "011" and flagReg(0) = '0'
    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "100" and (flagReg(0) = '0' or flagReg(1)= '1')
    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "101" and flagReg(0) = '1'    
    else pla_out when pla_out = o"270" and IR_reg(12 downto 10)  = "110" and (flagReg(0) = '1' or flagReg(1)= '1')
    else o"000" when pla_out = o"270"
    

    else o"142" when pla_out = o"140" and IR_reg(10) = '0' 

    
    else nextAddress; 

     end decoding_circuit_arch; 