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
	updated_PC: out std_logic_vector ( 15 downto 0);
      inst: out std_logic_vector(31 downto 0));
end component;
component Decode is
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
end component;
component Reg is
    generic(n: integer:=16);
      port(
        
        d: in std_logic_vector(n-1 downto 0);
        clk, rst, enable: in std_logic;
        q: out std_logic_vector(n-1 downto 0)
      );
end component;
signal AluSelector, rs, rt, rd: std_logic_vector(2 downto 0);
signal rs_data, rt_data: std_logic_vector(15 downto 0);
signal FD_out, FD_in: std_logic_vector(47 downto 0);
signal instruction: std_logic_vector(31 downto 0);
signal immediateVal, updated_PC: std_logic_vector(15 downto 0);
signal identifierBit:  std_logic;
signal ControllerSignal: std_logic_vector (8 downto 0);
begin
FD_in <= updated_PC & instruction;
f: fetch port map (rst, clk, ControllerSignal(4), rs_data,  updated_PC, instruction);
FD: Reg generic map(48) port map (FD_in, clk, rst, '1', FD_out);
d: Decode port map (clk, rst, '0', FD_out(31 downto 0), ControllerSignal, identifierBit, AluSelector, rs, rt, rd, "000", (others => '0'), immediateVal, rs_data, rt_data);--Write en, address, data from WB
end archinteg;