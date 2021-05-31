

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY integration IS
	PORT( Clock1,Clock2,Rst : IN std_logic;
		
	      dataBus: INOUT std_logic_vector(15 downto 0));
END integration;


ARCHITECTURE a_integration OF integration 
IS
Component singal_decoder is 
	port (signals: out std_logic_vector(47 downto 0); 
		  micro_instruction: In std_logic_vector(31 downto 0));
end component; 
	
	COMPONENT N_BIT_REG IS 
		generic(n:integer :=16);
		port (clk, rst ,en :IN std_logic; 
        		d:In std_logic_vector(n-1 downto 0); 
      			q:out std_logic_vector(n-1 downto 0 )); 
	     END COMPONENT; 

	
	
	COMPONENT tristate IS 
		generic (n:integer := 16);
		port (ip:in std_logic_vector(n-1 downto 0);
   	 		op:out std_logic_vector(n-1 downto 0); 
    			 en: std_logic); 
	     END COMPONENT; 

	
	component control_store is 
		port (out_data: out std_logic_vector(31 downto 0); 
			address: In std_logic_vector(8 downto 0));
	end component; 
	component decoding_circuit is 
	port ( flagReg: In std_logic_vector(15 downto 0);
		   IR_reg: In std_logic_vector(15 downto 0);
		   ORoperation, ORindsrc, ORinddest,ORdest, ORresult ,pla_en: In std_logic;
		   nextAddress: IN std_logic_vector(8 downto 0);
		   address: out std_logic_vector(8 downto 0));
	end component; 

	component flags is port(
		Z: in std_logic_vector(15 downto 0);
		carry : in std_logic;
		flagout : out std_logic_vector(15 downto 0));
	end component; 
	COMPONENT ALU is
		port ( ALU_A, ALU_B : in std_logic_vector(15 downto 0);
				ALU_Cin : in std_logic; 
				ALU_S : in std_logic_vector(4 downto 0); 
				ALU_F: out std_logic_vector(15 downto 0); 
				ALU_Cout: out std_logic);
	 end component; 
	component RegsDecoder is 
	port (  Rdst_out, Rdst_in,Rsrc_out,Rsrc_in: In std_logic;
			IR_reg : IN std_logic_vector(15 downto 0);
			Regs_in_signal, Regs_out_signal: out std_logic_vector(7 downto 0)); 
	end component;
	component ram is 

	port (in_data:IN std_logic_vector(15 downto 0);
		out_data: out std_logic_vector(15 downto 0); 
		address: In std_logic_vector(10 downto 0); 
		clk,we : In std_logic );
	end component;
	signal q0,q1,q2,q3,q4,q5,q6,q7,qSRC,qDest,qTemp,qMAR,qMDR,qY,qZ,qFlag,qIR ,ALU_out ,flags_out,branch_address,ram_out,MDRIN: std_logic_vector(15 downto 0);
	signal signals: std_logic_vector(47 downto 0);
	signal microInst: std_logic_vector(31 downto 0);
	signal Rs_in_signal, Rs_out_signal: std_logic_vector(7 downto 0); 
	signal nextAddrDecodingCircuitOut,qMicroAR: std_logic_vector(8 downto 0);  
	signal ALU_carry_out,MDRen,R7en,R7out,Clk1,Clk2 : std_logic; 
BEGIN
	Clk1<=Clock1 and not signals(40);
	Clk2<=Clock2 and not signals(40);
	
	al: ALU PORT MAP (qY, dataBus, qFlag(0), microInst(11 downto 7), ALU_out, ALU_carry_out);

	dc: decoding_circuit port map(qFlag, qIR, signals(46),signals(43) ,signals(44) ,signals(42) 
	,signals(45) ,signals(47) ,microInst(31 downto 23),nextAddrDecodingCircuitOut);
	cs: control_store port Map (microInst,qMicroAR);
	sd: singal_decoder PORT MAP (signals,microInst);
	fgs: flags port map (qZ,ALU_carry_out, flags_out);
	RsDecoder: RegsDecoder port map (signals(4),signals(13),signals(3),signals(12),qIR,Rs_in_signal,Rs_out_signal);
	ram0:ram port map(qMDR,ram_out,qMAR(10 downto 0),Clk1,signals(39));

	R7out <= signals(0) or Rs_out_signal(7);
	tristate0: tristate PORT MAP (q0,dataBus,Rs_out_signal(0));		
	tristate1: tristate PORT MAP (q1,dataBus,Rs_out_signal(1));		
	tristate2: tristate PORT MAP (q2,dataBus,Rs_out_signal(2));		
	tristate3: tristate PORT MAP (q3,dataBus,Rs_out_signal(3));	
	tristate4: tristate PORT MAP (q4,dataBus,Rs_out_signal(4));		
	tristate5: tristate PORT MAP (q5,dataBus,Rs_out_signal(5));		
	tristate6: tristate PORT MAP (q6,dataBus,Rs_out_signal(6));	
	
	tristate7: tristate PORT MAP (q7,dataBus,R7out);			
	tristateSrc: tristate PORT MAP (qSRC,dataBus,signals(5));	
	tristateDest: tristate PORT MAP (qDest,dataBus,signals(6));		
	tristateTemp: tristate PORT MAP (qTemp,dataBus,signals(7));		

	
	tristateMDRdatabus: tristate PORT MAP (qMDR,databus,signals(1));	
	-- tristateMDRram: tristate PORT MAP (qMDR,ram_in,signals(39));	

	
	tristateZ: tristate PORT MAP (qZ,dataBus,signals(2));	


	branch_address<="000000"&qIR(9 downto 0);
    tristateAddress: tristate PORT MAP (branch_address,dataBus,signals(8));

	
	R7en <= Rs_in_signal(7) or  signals(9);
	reg0: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(0),dataBus,q0);
	reg1: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(1),dataBus,q1);
	reg2: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(2),dataBus,q2);
	reg3: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(3),dataBus,q3);
    	reg4: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(4),dataBus,q4);
	reg5: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(5),dataBus,q5);
	reg6: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,Rs_in_signal(6),dataBus,q6);
	reg7: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,R7en  ,dataBus,q7);
	
	regSrc: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(18),dataBus,qSrc);
	regDest: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(19),dataBus,qDest);
	regTemp: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(16),dataBus,qTemp);
	regMAR: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(14),dataBus,qMAR);
	
	MDRIN <= ram_out when signals(38)='1'
	else databus;
	MDRen <=signals(38) or signals(15);
	regMDR: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(38),MDRIN,qMDR);
	
	regY: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(17),dataBus,qY);
	regZ: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(11),ALU_out,qZ);
	regFlags: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,'1',flags_out,qFlag);
	regIR: N_BIT_REG GENERIC MAP (16)  PORT MAP (Clk1,Rst,signals(10),dataBus,qIR); 
	regMicroAR: N_BIT_REG GENERIC MAP (9)  PORT MAP (Clk2,Rst,'1',nextAddrDecodingCircuitOut,qMicroAR); 
	
		
END a_integration;