LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity PC is
generic (n: integer := 16);
    port (
        RST, Enable, IntEnable, clk, int: IN std_logic;
	update, rstAddress, intAddress: in std_logic_vector(n-1 downto 0);
        inst_address: OUT std_logic_vector(n-1 downto 0);
	RET_RTI: IN std_logic;
	RET_RTI_update: in std_logic_vector(n-1 downto 0)
    );
end entity PC;


architecture ProgramCounter of PC is
    SIGNAL current_address: std_logic_vector(n-1 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                current_address <= rstAddress;
	        elsif int = '1' and IntEnable='1' then
	            current_address <= intAddress;
	        elsif RET_RTI = '1' then
	            current_address <= RET_RTI_update;
            elsif Enable='1' then
                current_address <= update;
            end if;
        end if;
    end process;

    inst_address <= current_address;
    
end architecture ProgramCounter;