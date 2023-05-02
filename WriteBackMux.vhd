
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity WriteBackMux is
  port (
    res,memoryData: in std_logic_vector(15 downto 0);
    memSelector:in std_logic;
    MuxRes: out std_logic_vector(15 downto 0)
   
  ) ;
end WriteBackMux;

architecture archOFWriteBackMux of WriteBackMux is

component mux2 is 
GENERIC (n: integer:= 16);
port(	
	in1,in2: in std_logic_vector(n - 1 downto 0);
	out1 : out std_logic_vector(n - 1 downto 0);
	sel : in std_logic
);

end component;
begin
mainMux: mux2 generic map(16) port map(res,memoryData,MuxRes,memSelector);
end archOFWriteBackMux ; -- OFWriteBackMux
