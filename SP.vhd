library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity SP is
    Port ( mem_read : in STD_LOGIC;
           address_select : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (9 downto 0));
end SP;

architecture Behavioral of SP is
    signal stack_pointer : unsigned(9 downto 0) := "1111111110"; -- 1022 in decimal
begin
    process (mem_read, address_select)
    begin
        if address_select = '1' then
            if mem_read = '1' then -- pop 
                stack_pointer <= stack_pointer + 1;
            else -- push 
                stack_pointer <= stack_pointer - 1;
            end if;
        end if;
    end process;

    data_out <= std_logic_vector(stack_pointer);
end Behavioral;
