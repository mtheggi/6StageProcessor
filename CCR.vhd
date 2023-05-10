library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CCR is
    port (
        CCRDataIn: IN std_logic_vector(2 downto 0);
        clk, rst, enable: IN std_logic;
        CCRDataOut: out std_logic_vector(2 downto 0)
    ); -- 2: Carry, 1: Negative, 0: Zero
end entity CCR;

architecture ControlRegister of CCR is
    
begin
    process(clk, rst)
    begin
        if rst='1' then
            CCRDataOut <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                CCRDataOut <= CCRDataIn;
            end if;
        end if;
    end process;
    
    
end architecture ControlRegister;