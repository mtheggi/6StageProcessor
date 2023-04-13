library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegistersFile is
    generic (n: integer:= 16);
    port (
        WritePort: in std_logic_vector(n - 1 DOWNTO 0);
	      ReadPort: out std_logic_vector(n - 1 DOWNTO 0);
        WriteAddress, ReadAddress: in std_logic_vector(2 DOWNTO 0);
        CLK, RST, WriteEnable:  in std_logic
    );
end entity RegistersFile;

architecture ArchOfRegistersFile of RegistersFile is
    component Reg is
        GENERIC (n: integer:= 16);
        port(	
            Clk,Rst, enable : IN std_logic;
            d : IN std_logic_vector(n-1 DOWNTO 0);
            q : OUT std_logic_vector(n-1 DOWNTO 0)
        );
        end component;

    component mux8 is
        GENERIC (n: integer:= 16);
        port(	
            in1,in2,in3,in4,in5,in6,in7,in8: in std_logic_vector(n - 1 downto 0);
            out1 : out std_logic_vector(n - 1 downto 0);
            sel : in std_logic_vector(2 downto 0)
        );
    end component;

    signal en: std_logic_vector(7 downto 0);
	 Type InputType is Array(0 to 7) of std_logic_vector(n - 1 downto 0);
    signal out1: InputType;
begin
    
	
	 loop1: FOR i in 0 to 7 GENERATE
		Registers: Reg GENERIC MAP(n) PORT MAP(CLK, RST, en(i), WritePort, out1(i));
	 END GENERATE;
    ReadMux: mux8 GENERIC MAP(n) PORT MAP(out1(0), out1(1), out1(2), out1(3), out1(4), out1(5), out1(6), out1(7), ReadPort, ReadAddress);
	 
	 loop2: FOR i in 0 to 7 GENERATE 
		en(i) <= '1' when ((to_integer(unsigned(WriteAddress)) = i) and WriteEnable='1') else '0';
	 END GENERATE;


    
end architecture ArchOfRegistersFile;
