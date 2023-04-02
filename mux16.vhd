
library ieee;
use ieee.std_logic_1164.all;

entity mux16 is
generic (n: integer:= 16);
port(	
	in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16: in std_logic_vector(n-1 downto 0);
	out1 : out std_logic_vector(n-1 downto 0);
	sel : in std_logic_vector(3 downto 0)
);
end mux16;

architecture arch3 of mux16 is
component mux4 is
generic (n: integer:= 16);
port(	
	in1,in2,in3,in4: in std_logic_vector(n-1 downto 0);
	out1 : out std_logic_vector(n-1 downto 0);
	sel : in std_logic_vector(1 downto 0)
);
end component;

signal x1,x2,x3,x4:std_logic_vector(n-1 downto 0);
begin 


m1 : mux4 GENERIC MAP(n) port map(in1,in2,in3,in4,x1,sel(1 downto 0));
m2 : mux4  GENERIC MAP(n) port map(in5,in6,in7,in8,x2,sel(1 downto 0));
m3 : mux4  GENERIC MAP(n)port map(in9,in10,in11,in12,x3,sel(1 downto 0));
m4 : mux4  GENERIC MAP(n) port map(in13,in14,in15,in16,x4,sel(1 downto 0));
m5 : mux4  GENERIC MAP(n) port map(x1,x2,x3,x4,out1,sel(3 downto 2));

end arch3;