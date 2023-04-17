
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControlUnit is
  port (
  opCode,Func: in std_logic_vector(2 downto 0);
  AluSelector: out std_logic_vector(2 downto 0);
  int : in std_logic;
  ControllerSignal: out std_logic_vector(9 downto 0)
  ) ;
end ControlUnit;

architecture archOfConTrolUnit of ControlUnit is
  component mux2 is
    GENERIC (n: integer:= 16);
    port(	
      in1,in2: in std_logic_vector(n - 1 downto 0);
      out1 : out std_logic_vector(n - 1 downto 0);
      sel : in std_logic
    );
    end component;
  signal temp,temp2:std_logic_vector(9 downto 0); 

begin
  temp(8 downto 0) <= "000000000" When opCode = "000"
Else "001000000" When opCode = "001"
Else "00"&Func(1)&"00"&Func(1)&Func(0)&'0'&'0' When opCode="010"
Else "011000000" When opCode = "011"
Else "100000000" When opCode = "100"
Else "000"&Func(0)&"1000"&Func(2) When opCode = "101"
Else Not Func(0)& Func(0)& Func(0)&"000010" When opCode = "110"
Else Not Func(0)& Func(0)&"0010011" When opCode = "111"
Else "000000000";

--AluOperation
temp(9) <= '1' when opCode="001"
               else '0';
temp2<="0100000011";
-- ALUOPeration<=temp(9);
-- MemWrite<=temp(8);
-- MemRead<=temp(7);
-- RegWrite<=temp(6);
-- FlagSelcetor<=temp(5);
-- Branch<=temp(4);
-- InEnb<=temp(3);
-- OutEnb<=temp(2);
-- AddressSelector<=temp(1);
-- UncondBranch<=temp(0);
mux1: mux2 GENERIC map(10) port map(temp,temp2,ControllerSignal,int);
AluSelector<=Func;
end archOfConTrolUnit ; -- archOfConTrolUnit
