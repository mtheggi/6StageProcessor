library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HazardDetectionUnit is
    Port (
        Ex_memRead , Ex_memWrite , M1_memRead  , M1_memWrite , loadUse     : in  std_logic;
        reset       : out std_logic
    );
end HazardDetectionUnit;

architecture Behavioral of HazardDetectionUnit is
begin
    process (Ex_memRead, Ex_memWrite, M1_memRead, M1_memWrite, loadUse)
    begin
        if loadUse = '1' or ((Ex_memRead = '1' or Ex_memWrite = '1') and (M1_memRead = '1' or M1_memWrite = '1')) then
            reset <= '1';
        else
            reset <= '0';
        end if;
    end process;
end Behavioral;
