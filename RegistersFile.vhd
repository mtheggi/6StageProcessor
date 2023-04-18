library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegistersFile is
    generic (n: integer:= 16);
    port (
        WritePort: in std_logic_vector(n - 1 DOWNTO 0);
	      ReadPort1,ReadPort2: out std_logic_vector(n - 1 DOWNTO 0);
        WriteAddress, ReadAddress1,ReadAddress2: in std_logic_vector(2 DOWNTO 0);
        CLK, RST, WriteEnable:  in std_logic
    );
end entity RegistersFile;

architecture ArchOfRegistersFile of RegistersFile is
    component Reg is
        GENERIC (n: integer:= 16);
        port(	
            d : IN std_logic_vector(n-1 DOWNTO 0);
            Clk,Rst, enable : IN std_logic;
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
    signal out1:std_logic_vector(n - 1 downto 0);
    signal out2:std_logic_vector(n - 1 downto 0);
    signal out3:std_logic_vector(n - 1 downto 0);
    signal out4:std_logic_vector(n - 1 downto 0);
    signal out5:std_logic_vector(n - 1 downto 0);
    signal out6:std_logic_vector(n - 1 downto 0);
    signal out7:std_logic_vector(n - 1 downto 0);
    signal out8:std_logic_vector(n - 1 downto 0);
    signal notCLk: std_logic;
begin
    
   notCLk <= not CLK;
   reg1 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(0), out1);
   reg2 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(1), out2);
   reg3 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(2), out3);
   reg4 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(3), out4);
   reg5 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(4), out5);
   reg6 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(5), out6);
   reg7 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(6), out7);
   reg8 :Reg GENERIC MAP(n) PORT MAP(WritePort, notCLk, RST, en(7), out8);
    ReadMux1: mux8 GENERIC MAP(n) PORT MAP(out1, out2, out3, out4, out5, out6, out7, out8, ReadPort1, ReadAddress1);
    ReadMux2: mux8 GENERIC MAP(n) PORT MAP(out1, out2, out3, out4, out5, out6, out7, out8, ReadPort2, ReadAddress2);
	 
	 loop2: FOR i in 0 to 7 GENERATE 
		en(i) <= '1' when ((to_integer(unsigned(WriteAddress)) = i) and WriteEnable='1') else '0';
	 END GENERATE;


    
end architecture ArchOfRegistersFile;
