
library ieee;
use ieee.std_logic_1164.all;

entity mux8 is
GENERIC (n: integer:= 10);
port(	
	in1,in2,in3,in4,in5,in6,in7,in8: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic_vector(2 downto 0)
);
end mux8;

architecture arch3 of mux8 is
component mux2 is
	GENERIC (n: integer:= 10);
	port(	
		in1,in2: in std_logic_vector(n - 1 downto 0);
		out1 : out std_logic_vector(n - 1 downto 0);
		sel : in std_logic
	);
	end component;
component mux4 is
GENERIC (n: integer:= 10);
port(	
	in1,in2,in3,in4: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic_vector(1 downto 0)
);
end component;

signal x1,x2:std_logic_vector(n - 1 downto 0);
begin 


m1 : mux4 GENERIC MAP(n) port map(in1,in2,in3,in4,x1,sel(1 downto 0));
m2 : mux4 GENERIC MAP(n) port map(in5,in6,in7,in8,x2,sel(1 downto 0));
m3 : mux2 GENERIC MAP(n) port map(x1,x2,out1,sel(2));

end arch3;