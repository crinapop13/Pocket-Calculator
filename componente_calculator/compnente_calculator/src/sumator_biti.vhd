Library IEEE;
use IEEE.std_logic_1164.all;	  
use IEee.std_logic_unsigned.all;
use	ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity sumator is
	port (X: in std_logic_vector(7 downto 0);	
	Y: in std_logic_vector(7 downto 0);	
	sel: in  std_logic_vector(1 downto 0);
	cout: out std_logic;
	suma: out std_logic_vector(15 downto 0));	 
end sumator;

architecture sumator8 of sumator is
signal cin: std_logic_vector (8 downto 0);
begin 
	process(sel,X,Y,cin)
	begin
		if (sel = "11") then
			cin(0) <= '0';
			suma <= "00000000" & (X xor Y xor cin(7 downto 0));
			cin(8 downto 1) <= (X and Y) or (cin(7 downto 0) and (X xor Y));
			cout <= cin(8);	
		end if;
	end process;
end sumator8;	