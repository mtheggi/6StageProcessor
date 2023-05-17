library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity operandLatch is
    Port ( clk, stall: in STD_LOGIC;
	   dataIn: in STD_LOGIC_VECTOR(15 downto 0);
	   dataOut: out STD_LOGIC_VECTOR(15 downto 0)
	);
	   
end operandLatch;

architecture Arch_operandLatch of operandLatch is
    signal latchEnable: std_logic; 
    
begin
    process (clk)
    begin
	if rising_edge(clk) then
      	  if stall = '1' then
		latchEnable <= '1';
	  else 			
		latchEnable <= '0';
           end if;
	end if;
    end process;
    
    dataOut<= dataIn when latchEnable = '1' and not (operandSelector = MazIn);	
end Arch_operandLatch;