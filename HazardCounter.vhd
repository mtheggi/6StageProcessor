library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CounterHazard is
    Port ( clk : in STD_LOGIC;
           RET_RTI : in STD_LOGIC;
	   stall: out STD_LOGIC
	);
	   
end CounterHazard;

architecture Arch_CounterHazard of CounterHazard is
    signal temp : STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
    
begin
    process (clk, RET_RTI)
    begin
	if  (rising_edge(clk) and to_integer(unsigned(temp)) > 0) then
		temp <= std_logic_vector(unsigned(temp) - 1);
	end if;
        if RET_RTI = '1' then
            temp <= "0100";
        end if;
    end process;
    
    stall <= '1' when unsigned(temp) > 0
	     else '0';
end Arch_CounterHazard;
