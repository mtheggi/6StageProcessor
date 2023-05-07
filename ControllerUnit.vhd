
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControlUnit is
  port (
  opCode,Func: in std_logic_vector(2 downto 0);
  AluSelector: out std_logic_vector(2 downto 0);
  int, identifierBit : in std_logic;
  ControllerSignal: out std_logic_vector(9 downto 0);
  RTI_RET, selectPC : out std_logic;
  ValidRs, ValidRt: out std_logic
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
  signal RTIDetectTemp:std_logic_vector(5 downto 0);
  signal selPC: std_logic;
  signal integerOpcode, integerFunction: integer;
begin
  RTIDetectTemp <= (opCode&Func) ; 
  RTI_RET <= '1' when RTIDetectTemp = "111101" or RTIDetectTemp = "111111" else '0';
  
  temp(8 downto 0) <= "000000000" When opCode = "000"
Else "001000000" When opCode = "001"
Else "00"&Func(1)&"00"&Func(1)&Func(0)&'0'&'0' When opCode="010"
Else "011000000" When opCode = "011"
Else "100000000" When opCode = "100"
Else "000"&Func(0)&"1000"&Func(2) When opCode = "101"
Else Not Func(0)& Func(0)& Func(0)&"000010" When opCode = "110"
Else Not Func(0)& Func(0)&"0000011" When opCode = "111"
Else "000000000";

--AluOperation
temp(9) <= '1' when opCode="001"
               else '0';
temp2<="0100010011";
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
-- Determine if call from Opcode & func
selPC <= '1' when (int='1' or RTIDetectTemp = "111100")
	else '0';
mux1: mux2 GENERIC map(10) port map(temp,temp2,ControllerSignal,selPC);
AluSelector<=Func;
selectPC <= selPC;
integerOpcode <= to_integer(unsigned(opCode));
integerFunction <= to_integer(unsigned(Func));
ValidRt <= '1' when integerOpcode = 3 or integerOpcode = 4 or (integerOpcode = 1 and identifierBit = '1' and
                    ((integerFunction > 0 and integerFunction < 4) or integerFunction = 7 or integerFunction = 6))
              else '0';

ValidRs <= '0' when integerOpcode = 0 or RTIDetectTemp = "111101" or RTIDetectTemp = "111111"
                    or RTIDetectTemp = "001011" or RTIDetectTemp = "010010" or RTIDetectTemp = "011011" or RTIDetectTemp = "110001"
              else '1';

end archOfConTrolUnit ; -- archOfConTrolUnit
