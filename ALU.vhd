library ieee;
use ieee.std_logic_1164.all;

entity alu is
GENERIC (n: integer:= 10);
port (
	A,B: in std_logic_vector(n - 1 downto 0);
	sel : in std_logic_vector(3 downto 0);
	F : out std_logic_vector(n - 1 downto 0);
	cin: in std_logic;
	cout : out std_logic
);	

end alu;

architecture arch4 of alu is
component select_adder  is
generic (n: integer:= 10);
PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
end component;
--component adder is 
--generic (n: integer:= 10);
--port (
--	A,B: in std_logic_vector(n - 1 downto 0);
--	F : out std_logic_vector(n - 1 downto 0);
--	cin: in std_logic;
--	cout : out std_logic
--);	
--end component;
component mux16 is
GENERIC (n: integer:= 10);
port(	
	in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic_vector(3 downto 0)
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
component mux2 is
GENERIC (n: integer:= 10);
port(	
	in1,in2: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic
);
end component;

signal x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16 : std_logic_vector(n-1 downto 0);
signal temp, notB: std_logic_vector(n-1 downto 0);
--signal res, resA: std_logic_vector(9 downto 0);
signal selector, coutResultAdder, coutResultAdderMux: std_logic;
--signal CinPremium: std_logic;

begin
with sel select
cout <= '0' when "0100",
'0' when "0101",
'0' when "0110",
'0' when "0111",
A(n - 1) when "1000",
A(n - 1) when "1001",
A(n - 1) when "1010",
'0' when "1011",
A(0) when "1100",
A(0) when "1101",
A(0) when "1110",
'0' when "1111",
coutResultAdderMux when others;

notB <= not B;
selector <= '1' when sel="0011" and cin='1' else '0';
--CinPremium <= '0' when sel="0011" and cin='1' else Cin;
--mux2Comp: mux2 PORT MAP ((others => '1'), B (9 downto 0), temp (9 downto 0), Cin);
mux4Comp: mux4 GENERIC MAP(n) PORT MAP((others => '0'), B(n - 1 downto 0), notB(n - 1 downto 0), (others => '1'), temp(n - 1 downto 0), sel(1 downto 0));
--mux2Comp1: mux2 PORT MAP(A(9 downto 0), (others => '0'), resA(9 downto 0), selector);
adderComponent: select_adder GENERIC MAP(n) PORT MAP(A(n - 1 downto 0), temp( n - 1 downto 0), Cin, x2( n - 1 downto 0), coutResultAdder);
mux2CompRes: mux2 GENERIC MAP(n) PORT MAP (x2(n - 1 downto 0), B(n - 1 downto 0), x1(n - 1 downto 0), selector);
coutResultAdderMux <= coutResultAdder when selector='0' else '0';


x5<= A or B;
x6<= A and B;
x7<= A nor B;
x8<= not A;
x9<= A(n - 2 downto 0) &'0';
x10<= A(n - 2 downto 0) & A(n - 1);
x11<= A(n - 2 downto 0) & cin;
x12<=(others =>'0');
x13<='0'&A(n - 1 downto 1);
x14<=A(0) & A(n - 1 downto 1);
x15<=cin & A(n - 1 downto 1);
x16<=A(n - 1) & A(n - 1 downto 1);

mux6 : mux16 GENERIC MAP(n) port map(x1,x1,x1,x1,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,F,sel(3 downto 0));
end arch4;