library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity interruptLatch is
    port (
        rst, clk, RET_stall, int, condition: std_logic
    );
end entity interruptLatch;

architecture intLatch of interruptLatch is
    signal latchEnable, LatchedInt: std_logic;
begin
    process (clk)
    begin
	if rst = '1' then
		latchEnable <= '1';
	elsif rising_edge(clk) then
    	if RET_stall = '1' and LatchedInt = '1' then
			latchEnable <= '0';
	elsif RET_stall = '0' then
			latchEnable <= '1';
    	end if;
	end if;
    end process;    
    
    LatchedInt <= '0' when condition = '1'
                  else int when latchEnable='1';
    
end architecture intLatch;