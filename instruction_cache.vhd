LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY instruction_cache IS
PORT (
 address : IN std_logic_vector(15 DOWNTO 0);
 dataout : OUT std_logic_vector(31 DOWNTO 0) );
END ENTITY instruction_cache;

ARCHITECTURE sync_ram_a OF instruction_cache IS 
 TYPE ram_type IS ARRAY(0 TO 65535) of std_logic_vector(15 DOWNTO 0);
 SIGNAL ram : ram_type ;
BEGIN
 dataout <= ram(to_integer(unsigned((address)))) & ram(to_integer(unsigned((address))+1));
END sync_ram_a;