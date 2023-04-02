LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity PC is
    port (
        RST: IN std_logic;
        Enable: IN std_logic;
        clk: IN std_logic;
        instruction: OUT std_logic_vector(9 downto 0)
    );
end entity PC;


architecture ProgramCounter of PC is
    SIGNAL a: std_logic_vector(9 downto 0);
begin
    instruction <= a;
    process(clk, RST)
        
    begin
        if rst = '1' then
            a <= (others => '0');
        elsif rising_edge(clk) then
            if Enable='1' then
                --a <= std_logic_vector(to_unsigned(to_integer(unsigned(a)) + 1, 10));
                a <= std_logic_vector(unsigned(a) + 1);
            end if;
        end if;
    end process;
    
end architecture ProgramCounter;