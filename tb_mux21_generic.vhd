library IEEE;

use IEEE.std_logic_1164.all;
use WORK.constants.all;

entity TBMUX21_GENERIC is
end TBMUX21_GENERIC;

architecture TEST of TBMUX21_GENERIC is

  constant NBIT: integer := NumBit;
	signal	A1:	std_logic_vector(NBIT-1 downto 0);
	signal	B1:	std_logic_vector(NBIT-1 downto 0);
	signal	S1:	std_logic;
	signal	output1:	std_logic_vector(NBIT-1 downto 0);
	signal	output2:	std_logic_vector(NBIT-1 downto 0);

  component MUX21_GENERIC
    Generic (N: integer:= NumBit;
             DELAY_MUX: Time:= tp_mux);
    Port    (A:	In	std_logic_vector(N-1 downto 0);
             B:	In	std_logic_vector(N-1 downto 0);
             SEL:	In	std_logic;
             Y:	Out	std_logic_vector(N-1 downto 0));
  end component MUX21_GENERIC;

begin

	U1 : MUX21_GENERIC
	Generic Map (NBIT, 3 ns)
	Port Map (A1, B1, S1, output1);

	U2 : MUX21_GENERIC
	Generic Map (NBIT)
	Port Map ( A1, B1, S1, output2);



		A1 <= "0000000100000001";
		B1 <= "1000000000000001";
		S1 <= '0', '1' after 5 ns, 'U' after 10 ns;


end TEST;

configuration MUX21GENTEST of TBMUX21_GENERIC is
   for TEST
      for U1: MUX21_GENERIC
         use configuration WORK.CFG_MUX21_GEN_BEHAVIORAL;
      end for;

      for U2: MUX21_GENERIC
         use configuration WORK.CFG_MUX21_GEN_STRUCTURAL;
      end for;

   end for;
end MUX21GENTEST;
