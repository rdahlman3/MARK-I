LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register16x16 IS
	PORT(
		RegD, RegT, RegS 					:IN std_logic_vector(3 downto 0);
		Data  								:IN std_logic_vector(15 downto 0);
		Clock, Reset, Enable 				:IN std_logic;
		DataS, DataT 						:OUT std_logic_vector(15 downto 0)
	);
END register16x16;

ARCHITECTURE behavior OF register16x16 IS
		COMPONENT mux16
			PORT(
				d0,d1,d2,d3,d4,d5,d6,d7		:IN std_logic_vector(15 downto 0);
				d8,d9,dA,dB,dC,dD,dE,dF		:IN std_logic_vector(15 downto 0);
				sel							:IN std_logic_vector(3 downto 0);
				f 							:OUT std_logic_vector(15 downto 0)
			);
		END COMPONENT;
		COMPONENT reg16
			PORT(
				data						:IN std_logic_vector(15 downto 0);
				enable, reset, Clock		:IN std_logic;
				output						:OUT std_logic_vector(15 downto 0)
			);
		END COMPONENT;
		COMPONENT decoder16
			PORT(
				Sel 						:IN std_logic_vector(3 downto 0);
				Output 						:OUT std_logic_vector(15 downto 0)
			);
		END COMPONENT;
		SIGNAL decoderOutput				: std_logic_vector(15 downto 0);
		SIGNAL enabled0, enabled1, enabled2, enabled3, enabled4, enabled5, enabled6, enabled7, enabled8, enabled9, enabled10, enabled11, enabled12, enabled13, enabled14, enabled15		: std_logic;
		SIGNAL Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15	: std_logic_vector(15 downto 0);

	BEGIN
		decoder: decoder16 PORT MAP(regD, decoderOutput);
		enabled0 <= decoderOutput(0) AND Enable;		
		enabled1 <= decoderOutput(1) AND Enable;
		enabled2 <= decoderOutput(2) AND Enable;
		enabled3 <= decoderOutput(3) AND Enable;
		enabled4 <= decoderOutput(4) AND Enable;
		enabled5 <= decoderOutput(5) AND Enable;
		enabled6 <= decoderOutput(6) AND Enable;
		enabled7 <= decoderOutput(7) AND Enable;
		enabled8 <= decoderOutput(8) AND Enable;
		enabled9 <= decoderOutput(9) AND Enable;
		enabled10 <= decoderOutput(10) AND Enable;
		enabled11 <= decoderOutput(11) AND Enable;
		enabled12 <= decoderOutput(12) AND Enable;
		enabled13 <= decoderOutput(13) AND Enable;		
		enabled14 <= decoderOutput(14) AND Enable;
		enabled15 <= decoderOutput(15) AND Enable;

		Q0 <= ("0000000000000001");

		r1: reg16 PORT MAP(Data, enabled1, Reset, Clock, Q1);
		r2: reg16 PORT MAP(Data, enabled2, Reset, Clock, Q2);
		r3: reg16 PORT MAP(Data, enabled3, Reset, Clock, Q3);
		r4: reg16 PORT MAP(Data, enabled4, Reset, Clock, Q4);
		r5: reg16 PORT MAP(Data, enabled5, Reset, Clock, Q5);
		r6: reg16 PORT MAP(Data, enabled6, Reset, Clock, Q6);
		r7: reg16 PORT MAP(Data, enabled7, Reset, Clock, Q7);
		r8: reg16 PORT MAP(Data, enabled8, Reset, Clock, Q8);
		r9: reg16 PORT MAP(Data, enabled9, Reset, Clock, Q9);
		r10: reg16 PORT MAP(Data, enabled10, Reset, Clock, Q10);
		r11: reg16 PORT MAP(Data, enabled11, Reset, Clock, Q11);
		r12: reg16 PORT MAP(Data, enabled12, Reset, Clock, Q12);
		r13: reg16 PORT MAP(Data, enabled13, Reset, Clock, Q13);
		r14: reg16 PORT MAP(Data, enabled14, Reset, Clock, Q14);
		r15: reg16 PORT MAP(Data, enabled15, Reset, Clock, Q15);
		
		m1: mux16 PORT MAP(Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, RegS, DataS);
		m2: mux16 PORT MAP(Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, RegT, DataT);
END behavior;