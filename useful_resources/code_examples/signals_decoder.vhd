library ieee; 
use ieee.std_logic_1164.all; 
USE IEEE.numeric_std.all;

entity singal_decoder is 
port (signals: out std_logic_vector(47 downto 0); 
    micro_instruction: In std_logic_vector(31 downto 0));
end singal_decoder; 

architecture signal_decoder_arc of singal_decoder is 
begin
    -- F1   0No,1PC,2MDR,3Z,4Rs,5Rd,6S,7D,8T,9Address     Out      
    signals(8 downto 0) <= "000000000" when micro_instruction      (22 downto 19) =std_logic_vector(to_unsigned(0,4))
    else std_logic_vector(to_unsigned(1,9)) when micro_instruction (22 downto 19)=  std_logic_vector(to_unsigned(1,4))
    else std_logic_vector(to_unsigned(2,9)) when micro_instruction (22 downto 19)=  std_logic_vector(to_unsigned(2,4))
    else std_logic_vector(to_unsigned(4,9)) when micro_instruction (22 downto 19)=  std_logic_vector(to_unsigned(3,4))
    else std_logic_vector(to_unsigned(8,9)) when micro_instruction (22 downto 19)=  std_logic_vector(to_unsigned(4,4))
    else std_logic_vector(to_unsigned(16,9)) when micro_instruction(22 downto 19)= std_logic_vector(to_unsigned(5,4))
    else std_logic_vector(to_unsigned(32,9)) when micro_instruction(22 downto 19)= std_logic_vector(to_unsigned(8,4))
    else std_logic_vector(to_unsigned(64,9)) when micro_instruction(22 downto 19)= std_logic_vector(to_unsigned(9,4))
    else std_logic_vector(to_unsigned(128,9)) when micro_instruction(22 downto 19)=std_logic_vector(to_unsigned(10,4))
    else std_logic_vector(to_unsigned(256,9)) when micro_instruction(22 downto 19)=std_logic_vector(to_unsigned(11,4));
    
  
    -- F2   0No,1PC,2IR,3Z,4Rs,5Rd                    IN    
    signals(13 downto 9) <= "00000" when micro_instruction(18 downto 16) =std_logic_vector(to_unsigned(0,3))
    else std_logic_vector(to_unsigned(1,5)) when micro_instruction(18 downto 16)=  std_logic_vector(to_unsigned(1,3))
    else std_logic_vector(to_unsigned(2,5)) when micro_instruction(18 downto 16)=  std_logic_vector(to_unsigned(2,3))
    else std_logic_vector(to_unsigned(4,5)) when micro_instruction(18 downto 16)=  std_logic_vector(to_unsigned(3,3))
    else std_logic_vector(to_unsigned(8,5)) when micro_instruction(18 downto 16)=  std_logic_vector(to_unsigned(4,3))
    else std_logic_vector(to_unsigned(16,5)) when micro_instruction(18 downto 16)= std_logic_vector(to_unsigned(5,3));
  
  
    -- F3   0No,1MAR,2MDR,3TEMP                     IN
    signals(16 downto 14) <= "000" when micro_instruction(15 downto 14) =std_logic_vector(to_unsigned(0,2))
    else std_logic_vector(to_unsigned(1,3)) when micro_instruction(15 downto 14)=  std_logic_vector(to_unsigned(1,2))
    else std_logic_vector(to_unsigned(2,3)) when micro_instruction(15 downto 14)=  std_logic_vector(to_unsigned(2,2))
    else std_logic_vector(to_unsigned(4,3)) when micro_instruction(15 downto 14)=  std_logic_vector(to_unsigned(3,2));
   
    -- F4   0No,1Y,2Src,3Dst                            IN
    signals(19 downto 17) <= "000" when micro_instruction(13 downto 12) =std_logic_vector(to_unsigned(0,2))
    else std_logic_vector(to_unsigned(1,3)) when micro_instruction(13 downto 12)=  std_logic_vector(to_unsigned(1,2))
    else std_logic_vector(to_unsigned(2,3)) when micro_instruction(13 downto 12)=  std_logic_vector(to_unsigned(2,2))
    else std_logic_vector(to_unsigned(4,3)) when micro_instruction(13 downto 12)=  std_logic_vector(to_unsigned(3,2));
   


    -- F5   0MOV,1ADD,2ADC,3SUB,4SBC,5AND,6OR,7XOR,8CMP,9INC,10DEC,11CLR,12INV,13LSR,14ROR,15ASR,16LSL,17ROL
    signals(37 downto 20) <= std_logic_vector(to_unsigned(1,18)) when micro_instruction(11 downto 7) =std_logic_vector(to_unsigned(0,5))
    else std_logic_vector(to_unsigned(2,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(1,5))
    else std_logic_vector(to_unsigned(4,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(2,5))
    else std_logic_vector(to_unsigned(8,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(3,5))
    else std_logic_vector(to_unsigned(16,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(4,5))
    else std_logic_vector(to_unsigned(32,18)) when micro_instruction(11 downto 7)= std_logic_vector(to_unsigned(5,5))
    else std_logic_vector(to_unsigned(64,18)) when micro_instruction(11 downto 7)= std_logic_vector(to_unsigned(6,5))
    else std_logic_vector(to_unsigned(128,18)) when micro_instruction(11 downto 7)= std_logic_vector(to_unsigned(7,5))
    else std_logic_vector(to_unsigned(256,18)) when micro_instruction(11 downto 7)=std_logic_vector(to_unsigned(8,5))
    else std_logic_vector(to_unsigned(512,18)) when micro_instruction(11 downto 7)=std_logic_vector(to_unsigned(9,5))
    else std_logic_vector(to_unsigned(1024,18)) when micro_instruction(11 downto 7) =std_logic_vector(to_unsigned(10,5))
    else std_logic_vector(to_unsigned(2048,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(11,5))
    else std_logic_vector(to_unsigned(4096,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(12,5))
    else std_logic_vector(to_unsigned(8192,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(13,5))
    else std_logic_vector(to_unsigned(16384,18)) when micro_instruction(11 downto 7)=  std_logic_vector(to_unsigned(14,5))
    else std_logic_vector(to_unsigned(32768,18)) when micro_instruction(11 downto 7)= std_logic_vector(to_unsigned(15,5))
    else std_logic_vector(to_unsigned(65536,18)) when micro_instruction(11 downto 7)= std_logic_vector(to_unsigned(16,5))
    else std_logic_vector(to_unsigned(131072,18)) when micro_instruction(11 downto 7)= std_logic_vector(to_unsigned(17,5));
   
    -- F6   0No,1READ,2WRITE,3CLOCK_ENABLE
    signals(40 downto 38) <= "000" when micro_instruction(6 downto 5) =std_logic_vector(to_unsigned(0,2))
    else std_logic_vector(to_unsigned(1,3)) when micro_instruction(6 downto 5)=  std_logic_vector(to_unsigned(1,2))
    else std_logic_vector(to_unsigned(2,3)) when micro_instruction(6 downto 5)=  std_logic_vector(to_unsigned(2,2))
    else std_logic_vector(to_unsigned(4,3)) when micro_instruction(6 downto 5)=  std_logic_vector(to_unsigned(3,2));
   
    -- F7   No,WMFC
    signals(41) <= micro_instruction(4);
    
    -- F8   0No,1ORdst,2ORindsrc,3ORinddst,4ORresult,5ORoperations
    signals(46 downto 42) <= "00000" when micro_instruction(3 downto 1) =std_logic_vector(to_unsigned(0,3))
    else std_logic_vector(to_unsigned(1,5)) when micro_instruction(3 downto 1)=  std_logic_vector(to_unsigned(1,3))
    else std_logic_vector(to_unsigned(2,5)) when micro_instruction(3 downto 1)=  std_logic_vector(to_unsigned(2,3))
    else std_logic_vector(to_unsigned(4,5)) when micro_instruction(3 downto 1)=  std_logic_vector(to_unsigned(3,3))
    else std_logic_vector(to_unsigned(8,5)) when micro_instruction(3 downto 1)=  std_logic_vector(to_unsigned(4,3))
    else std_logic_vector(to_unsigned(16,5)) when micro_instruction(3 downto 1)= std_logic_vector(to_unsigned(5,3));
      
    -- F9   No,PLAout
    signals(47) <= micro_instruction(0);
       
end signal_decoder_arc; 
    
