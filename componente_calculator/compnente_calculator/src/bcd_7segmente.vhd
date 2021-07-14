Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity bcd is
	port (anod: out std_logic_vector(3 downto 0);
	catod: out std_logic_vector(6 downto 0);
	clk: in std_logic;
	nr0,nr1,nr2,nr3: in std_logic_vector(3 downto 0));
end bcd;

architecture behavioral of bcd is	
signal sel: std_logic_vector(1 downto 0);
signal numarator: std_logic_vector(15 downto 0) := "0000000000000000";
signal an: std_logic_vector(3 downto 0);
signal cifra: std_logic_vector(3 downto 0);
begin										
Div_frecv:	process (clk)
	begin
		if clk = '1' and clk'event then
			numarator <= numarator + '1';
		end if;
	end process Div_frecv;
	sel <= numarator(15 downto 14);  
Sel_anod:  process(sel)
    begin
	    case sel is
			when "11" => an <= "1110";
			when "10" => an <= "1101";
			when "01" => an <= "1011";
			when others => an <= "0111";
		end case;
		end process Sel_anod;
		anod <= an;
Sel_cifra:  process(an)
    begin
	case an is
		when "1110"=> cifra <=nr0;
		when "1101"=> cifra <=nr1;
		when "1011"=> cifra <=nr2;
		when others=> cifra <=nr3;
	end case;
	end process Sel_cifra;
	
Sel_catod:	process(cifra)
	begin
		case cifra is
			when "0000" => catod <= "0000001"; --0
			when "0001" => catod <= "1001111"; --1  				
			when "0010" => catod <= "0010010"; --2
			when "0011" => catod <= "0000110"; --3
			when "0100" => catod <= "1001100"; --4
			when "0101" => catod <= "0100100"; --5
			when "0110" => catod <= "0100000"; --6
			when "0111" => catod <= "0001111"; --7
			when "1000" => catod <= "0000000"; --8
			when "1001" => catod <= "0000100"; --9 	
			when "1010" => catod <= "0000010"; -- A
            when "1011" => catod <= "0000010"; -- B
            when "1100" => catod <= "0110001"; -- C
            when "1101" => catod <= "1000010"; -- d
            when "1110" => catod <= "0110000"; -- E
            when "1111" => catod <= "0111000"; -- F
			when others => catod <= "1111110"; --semn minus	
		end case;
	end process Sel_catod;
end behavioral;	