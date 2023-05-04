library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity integration is
  port (
    clk, rst, int: in std_logic;
    inport: in std_logic_vector(15 downto 0);
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
    immediateVal, ReadPort1, ReadPort2: out std_logic_vector(15 downto 0);
    RET_RTI_sig: out std_logic
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
        ALUA, ALUB: IN std_logic_vector(15 downto 0);
        ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit, RST: IN std_logic;
        OutputPort, ALUResult: OUT std_logic_vector(15 downto 0);
        ControllerSignalOut: OUT std_logic_vector(5 downto 0);
        CCROut: out std_logic_vector(2 downto 0); -- For RTI
        CCRFromRTI: IN std_logic_vector(2 downto 0);
        RTIBit: IN std_logic;
        BranchFlag: out std_logic
    );
end component;

component forwardingUnit is
  port (
    RsAddress, RtAddress: IN std_logic_vector(2 downto 0);
    ALUImmSrc: IN std_logic;
    RegWriteFromM1, RegWriteFromM2, RegWriteFromWB: IN std_logic;
    MemReadFromM1, MemReadFromM2: IN std_logic;
    RdFromM1, RdFromM2, RdFromWB: IN std_logic_vector(2 downto 0);
    Operand1Sel: OUT std_logic_vector(1 downto 0);
    Operand2Sel: OUT std_logic_vector(2 downto 0);
    LDUse: OUT std_logic
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
        WriteEnable , ReadEnable , Reset, INTR, clk: in std_logic; 
        address : in std_logic_vector(9 downto 0  ) ; 
        dataIn : in std_logic_vector(31 downto 0); 
        dataOut : out std_logic_vector(31 downto 0 )
    );

end component;
component WriteBackMux is
  port (
    res,memoryData: in std_logic_vector(15 downto 0);
    memSelector:in std_logic;
    MuxRes: out std_logic_vector(15 downto 0)
   
  ) ;
end component;
component Branch is
    port (
        BranchFlag, UncondJump, BranchSignal: in std_logic;
        UpdateSelector: out std_logic
    );
end component Branch;

component HazardDetectionUnit is
    Port (
        Ex_memRead , Ex_memWrite , M1_memRead  , M1_memWrite , loadUse     : in  std_logic;
        reset       : out std_logic
    );
end component HazardDetectionUnit;

signal AluSelector, rs, rt, rd: std_logic_vector(2 downto 0);
signal rs_data, rt_data: std_logic_vector(15 downto 0);
signal FD_out, FD_in: std_logic_vector(48 downto 0);
signal instruction, DMout, DMin: std_logic_vector(31 downto 0);
signal immediateVal, updated_PC,ResofMux: std_logic_vector(15 downto 0);
signal identifierBit:  std_logic;
signal ControllerSignal, ControlSignalsInEx: std_logic_vector (9 downto 0);
signal OpcodePlusFunc: std_logic_vector (5 downto 0);
signal RET_RTI_Dec: std_logic;
signal DE_in, DE_out: std_logic_vector(72 downto 0);
signal EM1_in, EM1_out: std_logic_vector(55 downto 0);
signal EM2_in, EM2_out: std_logic_vector(23 downto 0);
signal MW_in, MW_out: std_logic_vector(55 downto 0);
signal CCROut: std_logic_vector(2 downto 0);
signal BranchFlag, UpdateSelector, rst_or_flush: std_logic;
signal ALUResult1, ALUResult, WBResult: std_logic_vector(15 downto 0);
signal ControllerSignalsofM1: std_logic_vector(5 downto 0);
signal SPout, DMaddress: std_logic_vector(9 downto 0);
signal ALUA, ALUB: std_logic_vector(15 downto 0);
signal Operand1Sel: std_logic_vector(1 downto 0);
signal Operand2Sel: std_logic_vector(2 downto 0);
signal LDUse: std_logic;
-- 
signal BufferResetFromHDU : std_logic;  
--
begin
-- 
HDU : HazardDetectionUnit port map(DE_out(69) ,DE_out(68) , EM1_out (53) ,EM1_out (52) , LDUse, BufferResetFromHDU  );
-- 
FD_in <= int & updated_PC & instruction;
DE_in <= RET_RTI_Dec & FD_Out(48) & ControllerSignal & ResofMux & rt_data & immediateVal & rs & rt & rd & AluSelector & identifierBit;
EM1_in <= DE_out(72 downto 71) & ControllerSignalsofM1 & CCROut & DE_out(60 downto 45) & ALUResult & DE_out(6 downto 4) & SPout;
OpcodePlusFunc<=instruction(31 downto 29)&AluSelector;
EM2_in <= EM1_out(50) & EM1_out(55) & EM1_out(52 downto 51) & EM1_out(49) & EM1_out(28 downto 13) & EM1_out(12 downto 10);
MW_in <= DMout & EM2_out;
f: fetch port map (rst, clk, UpdateSelector, int, ALUA,  updated_PC, instruction);
FD: Reg generic map(49) port map (FD_in, clk, rst, '1', FD_out);
d: Decode port map (FD_Out(48), clk, rst, MW_out(20), FD_out(31 downto 0), ControllerSignal, identifierBit, AluSelector, rs, rt, rd, MW_out(2 downto 0), WBResult, immediateVal, rs_data, rt_data,RET_RTI_Dec);--Write en, address, data from WB
MuxBetWeenIntAndPush: IntMux port map (FD_out(48),OpcodePlusFunc,rs_data,FD_out(47 downto 32),ResofMux);
Br: Branch port map (BranchFlag, DE_out(61), DE_out(65), UpdateSelector);
rst_or_flush <= rst or UpdateSelector;
DE: reg generic map(73) port map (DE_in, clk, rst_or_flush, '1', DE_out);
Ex: Execute port map(DE_out(70 downto 61), ALUA, ALUB, DE_out(3 downto 1), DE_out(0), rst, OutputPort, ALUResult1, ControllerSignalsofM1, CCROut, MW_out(42 downto 40), MW_out(23), BranchFlag);
ALUResult <= inport when DE_out(64) = '1' else ALUResult1;
FWUnit: forwardingUnit port map(DE_out(12 downto 10), DE_out(9 downto 7), DE_out(0), EM1_out(51), EM2_out(20), MW_out(20), EM1_out(52), EM2_out(21), EM1_out(12 downto 10), EM2_out(2 downto 0), MW_out(2 downto 0), Operand1Sel, Operand2Sel, LDUse);
stp: SP port map (DE_out(68), clk, int, DE_out(62), DE_out(3 downto 1), SPout);
EM1: reg generic map(56) port map (EM1_in, clk, rst, '1', EM1_out);
DM: DataMemory port map (EM1_out(53), EM1_out(52), rst, int, clk, DMaddress, DMin, DMout);
EM2: reg generic map(24) port map (EM2_in, clk, rst, '1', EM2_out);
DMin <= "0000000000000" & EM1_out(47 downto 45) & EM1_out(44 downto 29);
DMaddress <= EM1_out(22 downto 13) when EM1_out(48) = '0'
	     else EM1_out(9 downto 0);
MW: reg generic map(56) port map (MW_in, clk, rst, '1', MW_out);
WB: WriteBackMux port map (MW_out(18 downto 3),MW_out(39 downto 24), MW_out(21), WBResult);

with Operand1Sel select
        ALUA <= EM1_out(28 downto 13) when "01",
                EM2_out(18 downto 3) when "10",
                MW_out(18 downto 3) when "11",
                DE_out(60 downto 45) when others;

with Operand2Sel select
        ALUB <= DE_out(28 downto 13) when "001",
                EM1_out(28 downto 13) when "010",
                EM2_out(18 downto 3) when "011",
                MW_out(18 downto 3) when "100",
                DE_out(44 downto 29) when others;

end archinteg;
