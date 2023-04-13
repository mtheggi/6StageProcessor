
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity WriteBackMux is
  port (
    res,memoryData,inportData: in std_logic_vector(15 downto 0);
    memSelactor,inPortSelector:in std_logic;
    MuxRes: out std_logic_vector(15 downto 0)
   
  ) ;
end WriteBackMux;

architecture archOFWriteBackMux of WriteBackMux is

component mux4 is 
GENERIC (n: integer:= 16);
port(	
	in1,in2,in3,in4: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic_vector(1 downto 0)
);

end component;
signal sel2:std_logic_vector(1 downto 0);
begin
sel2<=inPortSelector &memSelactor;
mainMux: mux4 generic map(16) port map(res,memoryData,inportData,inportData,MuxRes,sel2);
end archOFWriteBackMux ; -- OFWriteBackMux
