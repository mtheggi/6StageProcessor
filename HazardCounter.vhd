library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CounterHazard is
    Port ( clk : in STD_LOGIC;
           RET_RIL : in STD_LOGIC;
	   isItZero: out STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0)
	);
	   
end CounterHazard;

architecture Arch_CounterHazard of CounterHazard is
    signal temp : STD_LOGIC_VECTOR(3 downto 0) := "1000"; 
	signal isitzerotemp:STD_LOGIC;
    
begin
    process (clk, RET_RIL)
    begin
        if RET_RIL = '0' then
            temp <= "1000";
		isitzerotemp<='1';
        elsif rising_edge(clk) then
                if temp = "0000" then
                    temp <= "1000";
			isitzerotemp<='0';
                else
                    temp <= std_logic_vector(unsigned(temp) - 1);
			isitzerotemp<='1';
                end if;
        end if;
    end process;
    
    count <= temp; 
    isItZero<=isitzerotemp;
end Arch_CounterHazard;
