library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CounterHazard is
    Port ( clk : in STD_LOGIC;
           RET_RTI : in STD_LOGIC;
	   stall: out STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0)
	);
	   
end CounterHazard;

architecture Arch_CounterHazard of CounterHazard is
    signal temp : STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
    signal isitzerotemp:STD_LOGIC := '1';
    
begin
    process (clk, RET_RTI)
    begin
	if  (rising_edge(clk) and to_integer(unsigned(temp)) > 0) then
		temp <= std_logic_vector(unsigned(temp) - 1);
		isitzerotemp<='0';
	elsif to_integer(unsigned(temp)) = 0 then
		isitzerotemp <= '1';
	end if;
        if RET_RTI = '1' and not falling_edge(RET_RTI) then
            temp <= "0100";
	    isitzerotemp<='0';
        end if;
    end process;
    
    count <= temp; 
    stall<= not isitzerotemp;
end Arch_CounterHazard;
