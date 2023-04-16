library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RTIDetectUnit is
    port (
        CCR , FunctionCode : in std_logic_vector(2 downto 0);
        memRead , AddressSelect : in std_logic ; 
        output:  out std_logic ; 
        CCRout : out std_logic_vector(2 downto 0)
    );
end RTIDetectUnit;

architecture Behavioral of RTIDetectUnit is
begin
    CCRout <= CCR; 
    output <= '1' when ((FunctionCode = "111" )and ((memRead = '1' ) and( AddressSelect = '1'))) else '0';
end architecture Behavioral;