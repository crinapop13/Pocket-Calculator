Library IEEE;
use IEEE.STD_LOGIC_1164.all; 

entity scazator is
	port (X: in std_logic_vector(7 downto 0);	
		Y: in std_logic_vector(7 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		cout: out std_logic;
		diferenta: out std_logic_vector(15 downto 0));	 
end scazator;	

architecture scazator8 of scazator is
	signal cin: std_logic_vector (8 downto 0);
	signal yn: std_logic_vector(7 downto 0);
begin 
	process(sel,X,Y,cin,yn)
	begin
		if sel="10" then
			cin(0) <= '1'; 
			yn <= not Y;
			diferenta <= "00000000" & (X xor yn xor cin(7 downto 0));
			cin(8 downto 1) <= (X and yn) or (cin(7 downto 0) and (X xor yn));
			cout <= cin(8);
		end if;
	end process;
end scazator8;	