LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

package instruction_buffer_type is
	type instructionBuffer is array(0 to 7) of std_logic_vector (15 downto 0);
end package instruction_buffer_type;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use work.instruction_buffer_type.all;

entity RegistersWithVec is
    generic (n: integer:= 10);
    port (
        WritePort: in std_logic_vector(n - 1 DOWNTO 0);
	    ReadPort: out std_logic_vector(n - 1 DOWNTO 0);
        WriteAddress, ReadAddress: in std_logic_vector(2 DOWNTO 0);
        CLK, RST, WriteEnable:  in std_logic;
	AllRegisters: out instructionBuffer
    );
end entity RegistersWithVec;

architecture RF1 of RegistersWithVec is
    component MyRegister is
        GENERIC (n: integer:= 10);
        port(	
            Clk,Rst, enable : IN std_logic;
            d : IN std_logic_vector(n-1 DOWNTO 0);
            q : OUT std_logic_vector(n-1 DOWNTO 0)
        );
        end component;
	component mux8 is
        GENERIC (n: integer:= 10);
        port(	
            in1,in2,in3,in4,in5,in6,in7,in8: in std_logic_vector(n - 1 downto 0);
            out1 : out std_logic_vector(n - 1 downto 0);
            sel : in std_logic_vector(2 downto 0)
        );
    end component;

    signal en: std_logic_vector(7 downto 0);
    signal out1: instructionBuffer;
		
begin
	AllRegisters <= out1;
  	process	(clk,rst) 
	begin
	if rst='1'
		then out1<=(others => (others => '0'));
	elsif rising_edge(clk) 
	then 
			if writeEnable='1' 
			then	
				out1(to_integer(unsigned((writeaddress))))<=writeport;
			end if;
		end if;	
	end process; 
	Mux: mux8 GENERIC MAP(n) PORT MAP(out1(0), out1(1), out1(2), out1(3), out1(4), out1(5), out1(6), out1(7), ReadPort, ReadAddress);
	
	

    
end architecture RF1;