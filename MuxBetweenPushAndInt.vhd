library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IntMux is
  port (
    intOp:in std_logic;
    OpcodePlusFunc: in std_logic_vector(5 downto 0); 
  Rs,PC:in std_logic_vector(15 downto 0);
  OutofMux: out std_logic_vector(15 downto 0)
  ) ;
end IntMux;

architecture archOfIntMux of IntMux is
  component mux2 is
    GENERIC (n: integer:= 16);
    port(	
      in1,in2: in std_logic_vector(n - 1 downto 0);
      out1 : out std_logic_vector(n - 1 downto 0);
      sel : in std_logic
    );
    end component;
    signal Iscall, intOrCall: std_logic; 
begin
  with OpcodePlusFunc select
  Iscall <= '1' when "111100",
            '0' when others;
  intOrCall<= Iscall or intOp;       
 
  mux1: mux2 GENERIC map(16) port map(Rs,PC,OutofMux,intOrCall);

end archOfIntMux ; -- arch
