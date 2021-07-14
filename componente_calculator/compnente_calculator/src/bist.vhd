Library IEEE;
use IEEE.std_logic_1164.all; 

entity bistabil is
	port(d: in std_logic_vector(7 downto 0);
	enable: in std_logic;
	q: out std_logic_vector(7 downto 0));
end bistabil;

architecture nr2 of bistabil is
begin 
	process(enable,d)
	begin
		if enable = '1' then
			q <= d;
		end if;
	end process;
end nr2;  