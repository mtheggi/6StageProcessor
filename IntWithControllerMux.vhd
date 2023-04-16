library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IntWithControllerMux is
  port (
    ControllerSignalPure:in std_logic_vector(8 downto 0);
    OutofMux : out std_logic_vector(8 downto 0);
    sel : in std_logic
  ) ;
end IntWithControllerMux;

architecture archOfIntWithControllerMux of IntWithControllerMux is
  component mux2 is
    GENERIC (n: integer:= 16);
    port(	
      in1,in2: in std_logic_vector(n - 1 downto 0);
      out1 : out std_logic_vector(n - 1 downto 0);
      sel : in std_logic
    );
    end component;
    signal  temp: std_logic_vector(8 downto 0);
begin
      temp<="100010011";
 
  mux1: mux2 GENERIC map(16) port map(ControllerSignalPure,temp,OutofMux,sel);

end IntWithControllerMux ; -- arch
