library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity integration is
  port (
    clk, rst, int: in std_logic;
    OutputPort: out std_logic_vector(15 downto 0)
  ) ;

end integration;

architecture archinteg of integration is
component fetch is
port( rst, clk, branch, int:in std_logic;
	branch_update: in std_logic_vector ( 15 downto 0);
	updated_PC: out std_logic_vector ( 15 downto 0);
      inst: out std_logic_vector(31 downto 0));
end component;
component Decode is
  port (
    int, clk, rst, WriteEnable: in std_logic;
    inst: in std_logic_vector(31 downto 0);
    ControllerSignal: out std_logic_vector(9 downto 0);
    identifierBit: out std_logic;
    AluSelector, rs, rt, rd: out std_logic_vector(2 downto 0);
    WriteAddress: in std_logic_vector(2 downto 0);
    WriteData: in std_logic_vector(15 downto 0);
    immediateVal, ReadPort1, ReadPort2: out std_logic_vector(15 downto 0)
  ) ;
end component;
component IntMux is
    port (
      intOp:in std_logic;
      OpcodePlusFunc: in std_logic_vector(5 downto 0); 
    Rs,PC:in std_logic_vector(15 downto 0);
    OutofMux: out std_logic_vector(15 downto 0)
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
component Execute is
    port (
        ControlSignals : IN std_logic_vector(9 downto 0);
        Rs, Rt, Immediate: IN std_logic_vector(15 downto 0);
        ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit: IN std_logic;
        OutputPort, ALUResult: OUT std_logic_vector(15 downto 0);
        ControllerSignalOut: OUT std_logic_vector(5 downto 0);
        CCROut: out std_logic_vector(2 downto 0); -- For RTI
        CCRFromRTI: IN std_logic_vector(2 downto 0);
        RTIBit: IN std_logic;
        BranchFlag: out std_logic
    );
end component;
signal AluSelector, rs, rt, rd: std_logic_vector(2 downto 0);
signal rs_data, rt_data: std_logic_vector(15 downto 0);
signal FD_out, FD_in: std_logic_vector(48 downto 0);
signal instruction: std_logic_vector(31 downto 0);
signal immediateVal, updated_PC,ResofMux: std_logic_vector(15 downto 0);
signal identifierBit:  std_logic;
signal ControllerSignal, ControllerSignalAfterMux: std_logic_vector (9 downto 0);
signal OpcodePlusFunc: std_logic_vector (5 downto 0);
signal DE_in, DE_out: std_logic_vector(71 downto 0);
signal CCRFromRTI, CCROut: std_logic_vector(2 downto 0);
signal RTIBit, BranchFlag: std_logic;
signal ALUResult: std_logic_vector(15 downto 0);
signal ControllerSignalsofM1: std_logic_vector(5 downto 0);
begin
FD_in <= int & updated_PC & instruction;
DE_in <= FD_Out(48) & ControllerSignal & rs_data & rt_data & immediateVal & rs & rt & rd & AluSelector & identifierBit;
OpcodePlusFunc<=instruction(31 downto 29)&AluSelector;
f: fetch port map (rst, clk, ControllerSignal(4), int, rs_data,  updated_PC, instruction);
FD: Reg generic map(49) port map (FD_in, clk, rst, '1', FD_out);
d: Decode port map (FD_Out(48), clk, rst, '0', FD_out(31 downto 0), ControllerSignal, identifierBit, AluSelector, rs, rt, rd, "000", (others => '0'), immediateVal, rs_data, rt_data);--Write en, address, data from WB
MuxBetWeenIntAndPush: IntMux port map (FD_out(48),OpcodePlusFunc,rs_data,FD_out(47 downto 32),ResofMux);
DE: reg generic map(72) port map (DE_in, clk, rst, '1', DE_out);
Ex: Execute port map(DE_out(70 downto 61), DE_out(60 downto 45), DE_out(44 downto 29), DE_out(28 downto 13), DE_out(3 downto 1), DE_out(0), OutputPort, ALUResult, ControllerSignalsofM1, CCROut, CCRFromRTI, RTIBit, BranchFlag);
end archinteg;
