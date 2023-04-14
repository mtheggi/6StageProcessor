library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decode is
  port (
    clk, WriteEnable: in std_logic;
    inst: in std_logic_vector(31 downto 0);
    MemWrite, MemRead, RegWrite, FlagSelector, Branch, InEnb, OutEnb, AddressSelector, UncondBranch, identifierBit: out std_logic;
    AluSelector, rs, rt, rd: out std_logic_vector(2 downto 0);
    WriteAddress: in std_logic_vector(2 downto 0);
    WriteData: in std_logic_vector(15 downto 0);
    immediateVal, ReadPort1, ReadPort2: out std_logic_vector(15 downto 0)
  ) ;

end Decode;

architecture archOfDecode of Decode is
component ControlUnit is
  port (
  opCode,Func: in std_logic_vector(2 downto 0);
  MemWrite: out std_logic;
  MemRead: out std_logic;
  RegWrite: out std_logic;
  FlagSelector: out std_logic;
  Branch: out std_logic;
  InEnb: out std_logic;
  OutEnb: out std_logic;
  AddressSelector: out std_logic;
  AluSelector: out std_logic_vector(2 downto 0);
  UncondBranch: out std_logic
  ) ;
end component;
component RegistersFile is
    generic (n: integer:= 16);
    port (
        WritePort: in std_logic_vector(n - 1 DOWNTO 0);
	      ReadPort1,ReadPort2: out std_logic_vector(n - 1 DOWNTO 0);
        WriteAddress, ReadAddress1,ReadAddress2: in std_logic_vector(2 DOWNTO 0);
        CLK, RST, WriteEnable:  in std_logic
    );
end component;
signal opcode: std_logic_vector(2 downto 0) := inst(31 downto 29);
signal func: std_logic_vector(2 downto 0) := inst(28 downto 26);
signal rs_sig: std_logic_vector(2 downto 0) := inst(24 downto 22);
signal rt_sig: std_logic_vector(2 downto 0) := inst(21 downto 19);
signal rd_sig: std_logic_vector(2 downto 0) := inst(18 downto 16);
signal imm_sig: std_logic_vector(15 downto 0) := inst(15 downto 0);
begin
    identifierBit<=inst(25);
    rs<=rs_sig;
    rt<=rt_sig;
    rd<=rd_sig;
    immediateVal<=imm_sig;

    CU: ControlUnit port map(opcode, func, MemWrite, MemRead, RegWrite, FlagSelector, Branch, InEnb, OutEnb, AddressSelector, AluSelector, UncondBranch);

    RF: RegistersFile port map(WriteData, ReadPort1, ReadPort2, WriteAddress, rs_sig, rt_sig, clk,'0', WriteEnable);
end archOfDecode ; -- archOfDecode


-- 3-bit opcode 

-- (inst[31-29]) 

-- 3-bit Funct 

-- (inst[28-26]) 

-- 16/32 identifier bit 

-- (inst[25]) 

-- 3-bit Rs 

-- (inst[24-22]) 

-- 3-bit rt 

-- (inst[21-19]) 

-- 3-bit rd 

-- (inst[18-16]) 

-- 16-bit immediate value 

-- (inst[15-0]) 

