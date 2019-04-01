library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
use WORK.constants.all; -- libreria WORK user-defined


entity MUX21_GENERIC is
  Generic (N: integer:= NumBit;
           DELAY_MUX: Time:= tp_mux);
  Port    (A:	In	std_logic_vector(N-1 downto 0);
           B:	In	std_logic_vector(N-1 downto 0);
           SEL:	In	std_logic;
           Y:	Out	std_logic_vector(N-1 downto 0));
end MUX21_GENERIC;

architecture MUX21_GENERIC_BEHAVIORAL_ARCH of MUX21_GENERIC is

begin

  MUX_SELECT: process(A, B, SEL) is
  begin

      case(SEL) is
        when '0' => Y <= A;
        when '1' => Y <= B;
        when others => Y <= (others => 'Z');
      end case;

  end process MUX_SELECT;


end MUX21_GENERIC_BEHAVIORAL_ARCH;


architecture MUX21_GENERIC_STRUCTURAL_ARCH of MUX21_GENERIC is

  component MUX21
  	Port (	A:	In	std_logic;
  		B:	In	std_logic;
  		S:	In	std_logic;
  		Y:	Out	std_logic);
  	end component;

begin

    MUX21_NBITS : for i in 0 to N-1 generate
      mux21map : MUX21 port map (A(i), B(i), SEL, Y(i));
    end generate MUX21_NBITS;

end MUX21_GENERIC_STRUCTURAL_ARCH;



configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is
  for MUX21_GENERIC_BEHAVIORAL_ARCH
  end for;
end CFG_MUX21_GEN_BEHAVIORAL;


configuration CFG_MUX21_GEN_STRUCTURAL of MUX21_GENERIC is
  for MUX21_GENERIC_STRUCTURAL_ARCH
    for MUX21_NBITS
      for all : MUX21
        use configuration WORK.CFG_MUX21_BEHAVIORAL_3;
      end for;
    end for;
  end for;
end CFG_MUX21_GEN_STRUCTURAL;
