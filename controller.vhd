LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity controller is
    port (
        opcode: IN std_logic_vector(2 downto 0);
        RegWrite: OUT std_logic;
        ALUSelect: OUT std_logic_vector(3 downto 0);
        Cin: OUT std_logic
    );
end entity controller;

architecture rtl of controller is
    
begin


    with opcode select
        ALUSelect <= "1101" when "101",
                     "1011" when "111",
		     "1011" when "000",
                     "0011" when others;

    Cin <= '0';

    with opcode select
        RegWrite <= '0' when "111",
                     '1' when others;
    
    
end architecture rtl;