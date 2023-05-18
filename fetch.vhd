library ieee;
use ieee.std_logic_1164.all;
entity fetch is
port( en, rst, clk, branch, int, RET_RTI, stall:in std_logic;
	branch_update, RET_RTI_update: in std_logic_vector ( 15 downto 0);
	updated_PC: out std_logic_vector ( 15 downto 0);
  inst: out std_logic_vector(31 downto 0);
	intOut: out std_logic);
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
component interruptLatch is
	port (
			rst, clk, RET_stall, int, condition: std_logic;
			LatchedIntOut: out std_logic
	);
end component interruptLatch;
component instruction_cache IS
PORT (
 address : IN std_logic_vector(15 DOWNTO 0);
 dataout : OUT std_logic_vector(31 DOWNTO 0);
 resetAddress, intAddress: OUT std_logic_vector(15 DOWNTO 0) );
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
        RST, Enable, clk, int: IN std_logic;
	update, rstAddress, intAddress: in std_logic_vector(n-1 downto 0);
        inst_address: OUT std_logic_vector(n-1 downto 0);
	RET_RTI: IN std_logic;
	RET_RTI_update: in std_logic_vector(n-1 downto 0)
    );
end component;
signal instruction: std_logic_vector(31 downto 0);
signal instruction_address, add1, add2, sequential_increment, sequential_update, update, rstAddress, intAddress, updated_PC_signal: std_logic_vector(15 downto 0);
signal cout: std_logic;
signal latchedInterrupt, conditionInt: std_logic;
begin
p1: PC port map(rst, en, clk, latchedInterrupt, update, rstAddress, intAddress, instruction_address, RET_RTI, RET_RTI_update);
ic: instruction_cache port map (instruction_address, instruction, rstAddress, intAddress);
ad: my_nadder port map (instruction_address, sequential_increment, '0', sequential_update, cout);
add1 <= (0 => '1', others => '0');
add2 <= (1 => '1', others => '0');
m1: mux2 port map( add1, add2, sequential_increment, instruction(25));
m2: mux2 port map( sequential_update, branch_update, update, branch);
inst <= instruction;
updated_PC_signal <= sequential_update when latchedInterrupt = '0'
else instruction_address;
IL: interruptLatch port map (rst, clk, stall, int, conditionInt, latchedInterrupt);
intOut <= latchedInterrupt;
conditionInt <= '1' when instruction_address = intAddress
				else '0';
updated_PC <= updated_PC_signal;
end archfetch;