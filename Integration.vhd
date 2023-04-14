library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity integration is
  port (
    clk, rst, int: in std_logic
  ) ;

end integration;

architecture archinteg of integration is
component fetch is
port( rst, clk, branch:in std_logic;
	branch_update: in std_logic_vector ( 15 downto 0);
      inst: out std_logic_vector(31 downto 0));
end component;
component Decode is
  port (
    clk, WriteEnable: in std_logic;
    inst: in std_logic_vector(31 downto 0);
    MemWrite, MemRead, RegWrite, FlagSelector, Branch, InEnb, OutEnb, AddressSelector, UncondBranch, identifierBit: out std_logic;
    AluSelector, rs, rt, rd: out std_logic_vector(2 downto 0);
    WriteAddress: in std_logic_vector(2 downto 0);
    WriteData: in std_logic_vector(15 downto 0);
    immediateVal, ReadPort1, ReadPort2: out std_logic_vector(15 downto 0)
  ) ;
end component;
signal AluSelector, rs, rt, rd: std_logic_vector(2 downto 0);
signal rs_data, rt_data: std_logic_vector(15 downto 0);
signal instruction: std_logic_vector(31 downto 0);
signal immediateVal: std_logic_vector(15 downto 0);
signal MemWrite, MemRead, RegWrite, FlagSelector, Branch, InEnb, OutEnb, AddressSelector, UncondBranch, identifierBit:  std_logic;
begin
f: fetch port map (rst, clk, Branch, rs_data, instruction);
d: Decode port map (clk, '0', instruction, MemWrite, MemRead, RegWrite, FlagSelector, Branch, InEnb, OutEnb, AddressSelector, UncondBranch, identifierBit, AluSelector, rs, rt, rd, "000", (others => '0'), immediateVal, rs_data, rt_data);--Write en, address, data from WB
end archinteg;