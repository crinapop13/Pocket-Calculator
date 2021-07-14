library IEEE;
use IEEE.std_logic_1164.all;
use IEee.std_logic_unsigned.all;
use	ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity conex is
	port(switch: in std_logic_vector(7 downto 0); 
	sel: in std_logic_vector(1 downto 0);
	clk: in std_logic;
	en: in std_logic;
	enable: in std_logic; 
	semnnr1, semnnr2: in std_logic;
	anode: out std_logic_vector(3 downto 0);
	cathode: out std_logic_vector(6 downto 0));
end conex;

architecture conexiuni of conex is
signal a,z: std_logic_vector(15 downto 0);
signal x,y: std_logic_vector(7 downto 0);
signal adunare,scadere,impar,inmul: std_logic_vector(15 downto 0);
signal semnin, semnim: std_logic;

component sumator is
	port (X: in std_logic_vector(7 downto 0);	
	Y: in std_logic_vector(7 downto 0);	
	sel: in  std_logic_vector(1 downto 0);
	cout: out std_logic;
	suma: out std_logic_vector(15 downto 0));	 
end component;

 component scazator is
	port (X: in std_logic_vector(7 downto 0);	
		Y: in std_logic_vector(7 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		cout: out std_logic;
		diferenta: inout std_logic_vector(15 downto 0));	 
end component;			 

 component impartiree is
	port(sel: in  std_logic_vector(1 downto 0);   
deimpartit: in std_logic_vector(6 downto 0);
impartitor: in std_logic_vector(6 downto 0);
semnd,semni: in std_logic;
cat: out std_logic_vector(15 downto 0));
end component;	

 component inmultire is
	port(sel: in  std_logic_vector(1 downto 0); 
deinmultit: in std_logic_vector(6 downto 0);
inmultitor: in std_logic_vector(6 downto 0);
semnd,semni: in std_logic;
produs: out std_logic_vector(15 downto 0));
end component; 

 component mux is
	port(adunare, scadere, inm, imp: in std_logic_vector(15 downto 0);	 	   
	S: in std_logic_vector (1 downto 0);				   
	Y: out std_logic_vector (15 downto 0)); 
end component; 

component bistabil_d is						   --nr1
	port(d: in std_logic_vector(7 downto 0);
	enable: in std_logic;
	q: out std_logic_vector(7 downto 0));
end component;		 

component bistabil is							--nr2
	port(d: in std_logic_vector(7 downto 0);
	enable: in std_logic;
	q: out std_logic_vector(7 downto 0));
end component;	  
													  
component registru_mem is					  --rezultat
	port(d: in std_logic_vector(15 downto 0);
	en: in std_logic;
	q: out std_logic_vector(15 downto 0));
end component; 

component bcd is
	port (anod: out std_logic_vector(3 downto 0);
	catod: out std_logic_vector(6 downto 0);
	clk: in std_logic;
	nr0,nr1,nr2,nr3: in std_logic_vector(3 downto 0));
end component;

begin
	
	nr_1: bistabil_d port map(d=>switch,enable=>enable,q=>x);
	nr_2: bistabil port map(d=>switch,enable=>enable,q=>y);
	ad: sumator port map(X=>x,Y=>y,suma=>adunare,sel=>sel);
	sc: scazator port map(X=>x,Y=>y,diferenta=>scadere,sel=>sel);
	inm: inmultire port map(sel=>sel,deinmultit=>x(6 downto 0),inmultitor=>y(6 downto 0),semnd=>semnnr1,semni=>semnnr2,produs=>inmul); 
	imp: impartiree port map(sel=>sel,deimpartit=>x(6 downto 0),impartitor=>y(6 downto 0),semnd=>semnnr1,semni=>semnnr2,cat=>impar);
	m: mux port map(adunare=>adunare,scadere=>scadere,inm=>inmul,imp=>impar,S=>sel,Y=>a); 
	r: registru_mem port map(d=>a,en=>en,q=>z);
	afis: bcd port map(anod=>anode,catod=>cathode,clk=>clk,nr0=>z(3 downto 0),nr1=>z(7 downto 4),nr2=>z(11 downto 8),nr3=>z(15 downto 12));
end;	