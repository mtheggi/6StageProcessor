library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
GENERIC (n: integer:= 10);
port(	
	in1,in2,in3,in4: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic_vector(1 downto 0)
);
end mux4;

architecture arch2 of mux4 is
component mux2 is
GENERIC (n: integer:= 10);
port(	
	in1,in2: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic
);
end component;

signal x1,x2:std_logic_vector(n - 1 downto 0);
begin 
mx1: mux2 GENERIC MAP(n) port map(in1,in2,x1,sel(0));
mx2 : mux2 GENERIC MAP(n) port map(in3,in4,x2,sel(0));
mx3 : mux2 GENERIC MAP(n) port map(x1,x2,out1,sel(1));
end arch2;