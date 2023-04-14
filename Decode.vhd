library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decode is
  port (
    clk, rst, WriteEnable: in std_logic;
    inst: in std_logic_vector(31 downto 0);
    ControllerSignal: out std_logic_vector(8 downto 0);
    identifierBit: out std_logic;
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
  AluSelector: out std_logic_vector(2 downto 0);
  ControllerSignal: out std_logic_vector(8 downto 0)
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
signal opcode: std_logic_vector(2 downto 0);
signal func: std_logic_vector(2 downto 0);
signal rs_sig: std_logic_vector(2 downto 0);
signal rt_sig: std_logic_vector(2 downto 0);
signal rd_sig: std_logic_vector(2 downto 0);
signal imm_sig: std_logic_vector(15 downto 0);
begin
    opcode <= inst(31 downto 29);
    func <= inst(28 downto 26);
    rs_sig <= inst(24 downto 22);
    rt_sig <= inst(21 downto 19);
    rd_sig <= inst(18 downto 16);
    imm_sig <= inst(15 downto 0);
    identifierBit<=inst(25);
    rs<=rs_sig;
    rt<=rt_sig;
    rd<=rd_sig;
    immediateVal<=imm_sig;

    CU: ControlUnit port map(opcode, func, AluSelector, ControllerSignal);

    RF: RegistersFile port map(WriteData, ReadPort1, ReadPort2, WriteAddress, rs_sig, rt_sig, clk, rst, WriteEnable);
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

