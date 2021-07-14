Library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux is
	port(adunare, scadere, inm, imp: in std_logic_vector(15 downto 0);	 --rezultatele operatiilor
	S: in std_logic_vector (1 downto 0);		   --selectie pentru a decide care rezultat al celor 4 operatii sa fie afisat
	Y: out std_logic_vector (15 downto 0)); 		   --rezultatul returnat de multiplexor
end mux;

architecture mux4_1 of mux is  
signal rez: std_logic_vector (15 downto 0);		 --semnal intermediar pentru rezultat
begin
p1: process(S, adunare, scadere, inm, imp)
    begin 
	  case S is		  --in functie de selectie alegem ce sa punem in rezultat
		  when "11" => rez <= adunare;	   --daca selectia este 11 se alege adunarea
		  when "10" => rez <= scadere;	   --daca selectia este 10 se alege scaderea
		  when "01" => rez <= inm;		   --daca selectia este 01 se alege inmultirea
		  when others => rez <= imp;		--daca selectia este 00 se alege impartirea
	  end case;
	end process p1;
	Y <= rez;			 --asignam iesirii rezultatului valoarea semnalului care retinea reultatul uneia dintre peratii
end mux4_1;	
	
