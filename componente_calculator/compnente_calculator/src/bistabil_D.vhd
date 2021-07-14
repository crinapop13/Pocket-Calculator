Library IEEE;
use IEEE.std_logic_1164.all;	  

entity bistabil_d is
	port(d: in std_logic_vector(7 downto 0);
	enable: in std_logic;
	q: out std_logic_vector(7 downto 0));
end bistabil_d;

architecture nr1 of bistabil_d is
begin
	process(enable,d)
	begin 
		if enable = '0' then
				q <= d;	
		end if;
	end process;
end nr1;