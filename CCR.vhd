library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CCR is
    port (
        CCRData: IN std_logic_vector(2 downto 0);
        FlagSelector: in std_logic;
        FlagOutput: out std_logic
    ); -- 2: Carry, 1: Zero, 0: negative
end entity CCR;

architecture ControlRegister of CCR is
    
begin
    with FlagSelector select
        FlagOutput <= CCRData(2) when '0',
                      CCRData(1) when others;
    
    
end architecture ControlRegister;