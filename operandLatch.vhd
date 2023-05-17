library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity operandLatch is
    Port ( rst, clk, stall, condition: in STD_LOGIC;
	   dataIn: in STD_LOGIC_VECTOR(15 downto 0);
	   dataOut: out STD_LOGIC_VECTOR(15 downto 0)
	);
	   
end operandLatch;

architecture Arch_operandLatch of operandLatch is
    signal latchEnable: std_logic; 
    
begin
    process (clk)
    begin
	if rst = '1' then
		latchEnable <= '1';
	elsif rising_edge(clk) then
    	if stall = '1' and condition = '1' then
			latchEnable <= '0';
	elsif stall = '0' then
			latchEnable <= '1';
    	end if;
	end if;
    end process;
    
    dataOut <= dataIn when latchEnable = '1';	
end Arch_operandLatch;