library IEEE;
use IEEE.std_logic_1164.all;	  
use IEee.std_logic_unsigned.all;
use	ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity inmultire is
	port(sel: in  std_logic_vector(1 downto 0); 
deinmultit: in std_logic_vector(6 downto 0);
inmultitor: in std_logic_vector(6 downto 0);
semnd,semni: in std_logic;
produs: out std_logic_vector(15 downto 0));
end inmultire;			   

architecture inm of inmultire is
begin 
	process(sel, deinmultit, inmultitor)
	variable contor: std_logic_vector(7 downto 0);
	variable produs_s: std_logic_vector(11 downto 0); 
	variable semnp: std_logic_vector(3 downto 0);
	begin
		if(sel="01") then
				if (inmultitor /="00000000") then		--daca inmultitorul este diferit de 0 se inmultesc numerele normal		  
					produs_s := "000000000000";				   
					contor := "00000000";				--in contor se numara de cate ori adunam deinmultitul => produsul (inmultirea = adunari repetate) 
					for i in 1 to 256 loop	 
						if (contor < inmultitor) then	   --ne oprim atunci cand contorul este inca mai mic decat inmultitorul
							produs_s := produs_s + deinmultit;
							contor := contor + 1 ;
						end if;
					end loop; 
					if(semnd = semni) then
						semnp := "0000";
					else 
						semnp := "1000";
					end if;
					produs(11 downto 0) <= produs_s;
					produs(15 downto 12) <= semnp;
				else
					produs <= "0000000000000000";	   		 	--altfel rezultatul inmultirii este 0
				end if;	
		end if;
	end process;
end inm;