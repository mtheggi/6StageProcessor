library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity SP is
    Port ( 
            mem_read ,Clk : in STD_LOGIC;
           address_select : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (9 downto 0)
           );
end SP;

architecture Behavioral of SP is
    signal stack_pointer : unsigned(9 downto 0) := "1111111110"; -- 1022 in decimal
begin
    process (Clk , mem_read, address_select)
	variable temp_stack_pointer : unsigned(9 downto 0);
    begin
        if Clk = '1' then 
        if address_select = '1' then
            if mem_read = '1' then -- pop 
                temp_stack_pointer := stack_pointer +1 ;   
                stack_pointer <= temp_stack_pointer;
                data_out <= std_logic_vector(temp_stack_pointer);
            else -- push 
                temp_stack_pointer := stack_pointer;
                data_out <= std_logic_vector(temp_stack_pointer);
                temp_stack_pointer := stack_pointer -1 ;
                stack_pointer <= temp_stack_pointer;
            end if;
        end if;
        end if; 
    end process; 
 
 end Behavioral;
