
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControlUnit is
  port (
  opCode,Func: in std_logic_vector(2 downto 0);
  MemWrite: out std_logic;
  MemRead: out std_logic;
  RegWrite: out std_logic;
  FlagSelcetor: out std_logic;
  Branch: out std_logic;
  InEnb: out std_logic;
  OutEnb: out std_logic;
  AddressSelector: out std_logic;
  AluSelector: out std_logic_vector(2 downto 0);
  UncondBranch: out std_logic
  ) ;
end ControlUnit;

architecture archOfConTrolUnit of ControlUnit is
  
  signal temp:std_logic_vector(8 downto 0); 

begin
  temp <= "000000000" When opCode = "000"
Else "001000000" When opCode = "001"
Else "00"&Func(1)&"00"&Func(1)&Func(0)&'0'&'0' When opCode="010"
Else "011000000" When opCode = "011"
Else "100000000" When opCode = "100"
Else "000"&Func(0)&"1000"&Func(2) When opCode = "101"
Else Not Func(0)& Func(0)& Func(0)&"000010" When opCode = "110"
Else Not Func(0)& Func(0)&"0010011" When opCode = "111"
Else "000000000";

MemWrite<=temp(8);
MemRead<=temp(7);
RegWrite<=temp(6);
FlagSelcetor<=temp(5);
Branch<=temp(4);
InEnb<=temp(3);
OutEnb<=temp(2);
AddressSelector<=temp(1);
UncondBranch<=temp(0);
AluSelector<=Func;
end archOfConTrolUnit ; -- archOfConTrolUnit
