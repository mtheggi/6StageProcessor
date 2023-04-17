library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SimpleIntegration is
  port (
    clk, rst, int: in std_logic
  ) ;

end SimpleIntegration;

architecture archinteg of SimpleIntegration is
component fetch is
port( rst, clk, branch, int:in std_logic;
	branch_update: in std_logic_vector ( 15 downto 0);
	updated_PC: out std_logic_vector ( 15 downto 0);
      inst: out std_logic_vector(31 downto 0));
end component;
component Decode is
  port (
    clk, rst, WriteEnable: in std_logic;
    inst: in std_logic_vector(31 downto 0);
    ControllerSignal: out std_logic_vector(9 downto 0);
    identifierBit: out std_logic;
    AluSelector, rs, rt, rd: out std_logic_vector(2 downto 0);
    WriteAddress: in std_logic_vector(2 downto 0);
    WriteData: in std_logic_vector(15 downto 0);
    immediateVal, ReadPort1, ReadPort2: out std_logic_vector(15 downto 0)
  ) ;
end component;
component Reg is
    generic(n: integer:=16);
      port(
        
        d: in std_logic_vector(n-1 downto 0);
        clk, rst, enable: in std_logic;
        q: out std_logic_vector(n-1 downto 0)
      );
end component;
component SimpleExecute is
    port (
        ControlSignals : IN std_logic_vector(9 downto 0);
        Rs, Rt, Immediate: IN std_logic_vector(15 downto 0);
	ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit, clk, rst: IN std_logic;
        OutputPort, ALUResult: OUT std_logic_vector(15 downto 0);
        ControllerSignalOut: OUT std_logic_vector(4 downto 0);
        BranchFlag: out std_logic;
	Flags: out std_logic_vector(2 downto 0)
    );
end component;
component SP is
    Port ( 
           mem_read ,Clk, INTR : in STD_LOGIC;
           address_select : in STD_LOGIC;
           FunctionCode : in std_logic_vector(2 downto 0) ; 
           data_out : out STD_LOGIC_VECTOR (9 downto 0)
        
       );
end component;
component DataMemory is 
    port(
        WriteEnable , ReadEnable , Reset, INTR: in std_logic; 
        address : in std_logic_vector(9 downto 0  ) ; 
        dataIn : in std_logic_vector(31 downto 0); 
        dataOut : out std_logic_vector(31 downto 0 )
    );

end component;
signal AluSelector, rs, rt, rd, flags: std_logic_vector(2 downto 0);
signal rs_data, rt_data: std_logic_vector(15 downto 0);
signal FD_out, FD_in: std_logic_vector(48 downto 0);
signal DE_out, DE_in: std_logic_vector(87 downto 0);
signal EM1_out, EM1_in: std_logic_vector(69 downto 0);
signal EM2_out, EM2_in: std_logic_vector(21 downto 0);
signal MW_out, MW_in: std_logic_vector(53 downto 0);
signal instruction, DMin, DMout: std_logic_vector(31 downto 0);
signal immediateVal, updated_PC, OutputPort, ALURes: std_logic_vector(15 downto 0);
signal identifierBit, BranchFlag:  std_logic;
signal ControllerSignal, DMaddress, SPout: std_logic_vector (9 downto 0);
signal ControllerSignalex : std_logic_vector (4 downto 0);
begin
FD_in <= int & updated_PC & instruction;
DE_in <= FD_out(48 downto 32) & AluSelector & controllerSignal(9 downto 0)& identifierBit & rs_data & rt_data & rs & rt & rd & immediateVal;
EM1_in <= DE_out(87 downto 71) & ControllerSignalex & flags & DE_out(56 downto 41) & ALURes & DE_out(18 downto 16) & SPout;
EM2_in <= EM1_out(57 downto 55) & EM1_out(34 downto 19) & EM1_out(18 downto 16);
MW_in <= DMout & EM2_out(21 downto 0);
f: fetch port map (rst, clk, ControllerSignal(4), int, rs_data,  updated_PC, instruction);
FD: Reg generic map(49) port map (FD_in, clk, rst, '1', FD_out);
d: Decode port map (clk, rst, '0', FD_out(31 downto 0), ControllerSignal, identifierBit, AluSelector, rs, rt, rd, "000", (others => '0'), immediateVal, rs_data, rt_data);--Write en, address, data from WB
DE: Reg generic map(88) port map (DE_in, clk, rst, '1', DE_out);
e: SimpleExecute port map( DE_out(67 downto 58), DE_out(56 downto 41), DE_out(40 downto 25), DE_out(15 downto 0), DE_out(70 downto 68), DE_out(57), clk, rst, Outputport, ALURes, ControllerSignalex, BranchFlag, flags);
stp: SP port map (DE_out(65), clk, int, DE_out(59), DE_out(70 downto 68), SPout);
EM1: Reg generic map(70) port map (EM1_in, clk, rst, '1', EM1_out);
EM2: Reg generic map(22) port map (EM2_in, clk, rst, '1', EM2_out);
DM: DataMemory port map (EM1_out(52), EM1_out(51), rst, EM1_out(69), DMaddress, DMin, DMout);
MW: Reg generic map(54) port map (MW_in, clk, rst, '1', MW_out);

with EM1_out(54) select
	DMaddress <= EM1_out(28 downto 19) when '0',
		     EM1_out(9 downto 0) when others;
with EM1_out(69) select
	DMin <= EM1_out(50 downto 35) & "0000000000000000" when '0',
		     EM1_out(15 downto 0) & "0000000000000" & flags when others;

end archinteg;
