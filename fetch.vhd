library ieee;
use ieee.std_logic_1164.all;
entity fetch is
port( rst, clk, branch:in std_logic;
	branch_update: in std_logic_vector ( 15 downto 0);
	updated_PC: out std_logic_vector ( 15 downto 0);
      inst: out std_logic_vector(31 downto 0));
end entity fetch;
architecture archfetch of fetch is
component mux2 is
GENERIC (n: integer:= 16);
port(	
	in1,in2: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic
);
end component;
component instruction_cache IS
PORT (
 	address : IN std_logic_vector(15 DOWNTO 0);
 	dataout : OUT std_logic_vector(31 DOWNTO 0) );
END component;
component my_nadder IS
    	generic (n: integer := 16);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          	cin : in std_logic;
		s : out std_logic_vector(n-1 downto 0);
          	cout : OUT std_logic );
END component;
component PC is
generic (n: integer := 16);
    port (
        RST, Enable, clk: IN std_logic;
	update: in std_logic_vector(n-1 downto 0);
        inst_address: OUT std_logic_vector(n-1 downto 0)
    );
end component;
signal instruction: std_logic_vector(31 downto 0);
signal instruction_address, add1, add2, sequential_increment, sequential_update, update: std_logic_vector(15 downto 0);
signal cout: std_logic;
begin
p1: PC port map(rst, '1', clk, update, instruction_address);
ic: instruction_cache port map (instruction_address, instruction);
ad: my_nadder port map (instruction_address, sequential_increment, '0', sequential_update, cout);
add1 <= (0 => '1', others => '0');
add2 <= (1 => '1', others => '0');
m1: mux2 port map( add1, add2, sequential_increment, instruction(25));
m2: mux2 port map( sequential_update, branch_update, update, branch);
inst <= instruction;
updated_PC <= sequential_update;
end archfetch;