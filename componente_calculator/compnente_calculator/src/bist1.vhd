Library IEEE;
use IEEE.std_logic_1164.all;	  

entity registru_mem is
	port(d: in std_logic_vector(15 downto 0);
	en: in std_logic;
	q: out std_logic_vector(15 downto 0));
end registru_mem;

architecture rezultat of registru_mem is
begin
	process(en,d)
	begin
		if en = '1' then
				q <= d;
	    end if;
	end process;
end rezultat;
