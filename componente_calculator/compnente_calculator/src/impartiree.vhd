library IEEE;
use IEEE.std_logic_1164.all;	  
use IEee.std_logic_unsigned.all;
use	ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity impartiree is
	port(sel: in  std_logic_vector(1 downto 0);   
deimpartit: in std_logic_vector(6 downto 0);
impartitor: in std_logic_vector(6 downto 0);
semnd,semni: in std_logic;
cat: out std_logic_vector(15 downto 0));
end impartiree;

architecture imp of impartiree is 
begin 
	process(sel, deimpartit,impartitor)
	variable cat_s: std_logic_vector(11 downto 0);
	variable rest: std_logic_vector(6 downto 0);  
	variable semncat: std_logic_vector(3 downto 0);
	begin
		if(sel="00") then 
				if (impartitor/="00000000") then				  --daca impartitorul este diferit de 0 se efectueaza impartirea
					rest := deimpartit;				   --semnalul rest ia valoarea deimpartitului pentru ca din el sa scadem impartitorul repetat
					cat_s := "000000000000";			   --in cat_s se va afla la final rzultatul impartirii
					for i in 0 to 500 loop
			         if ( rest >= impartitor) then
			             rest := rest - impartitor;			--se scade repetat din deimpartit impartitorul	(impartire = scaderi repetate)
			             cat_s := cat_s + 1;			  
			         end if; 
					end loop; 
					if(semnd = semni) then
						semncat := "0000";
					else 
						semncat := "1000";
					end if;
					cat(11 downto 0) <= cat_s;
					cat(15 downto 12) <= semncat;
				else
					cat <= "0000000000001110";	   --altfel impartirea cu 0 nu se poate => EROARE
				end if;	  
		end if;
	end process;	   
end imp;
