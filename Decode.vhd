library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decode is
  port (
    inst: in std_logic_vector(31 downto 0);
    opcode: out std_logic_vector(2 downto 0);
    func: out std_logic_vector(2 downto 0);
    identifierBit: out std_logic;
    rs: out std_logic_vector(2 downto 0);
    rt: out std_logic_vector(2 downto 0);
    rd: out std_logic_vector(2 downto 0);
    immediateVal: out std_logic_vector(15 downto 0)
  ) ;

end Decode;

architecture archOfDecode of Decode is


begin
    opcode<=inst(31 downto 29);
    func<=inst(28 downto 26);
    identifierBit<=inst(25);
    rs<=inst(24 downto 22);
    rt<=inst(21 downto 19);
    rd<=inst(18 downto 16);
    immediateVal<=inst(15 downto 0);

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

