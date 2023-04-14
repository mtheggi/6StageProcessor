Library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

Entity DataMemory is 
    port(
        WriteEnable , ReadEnable , Reset: in std_logic; 
        address : in std_logic_vector(9 downto 0  ) ; 
        dataIn : in std_logic_vector(15 downto 0); 
        dataOut : out std_logic_vector(15 downto 0 )
    );

end Entity DataMemory;
architecture DM of DataMemory is 
    type Dmemory is array (0 to 1023) of std_logic_vector(15 downto 0);
    signal memory : Dmemory := (others => (others => '0'));
begin 
	process(Reset , WriteEnable , ReadEnable)
	begin 
    	if Reset = '1' then 
	        memory <= (others => (others=> '0'));     		
 		ELSIF WriteEnable = '1' and ReadEnable = '1' then 
	        memory(to_integer(unsigned(address))) <= dataIn; 
            dataOut <= memory(to_integer(unsigned(address)));    		
 		ELSIF ReadEnable  = '1' then 
		        dataOut <= memory(to_integer(unsigned(address))); 
        ELSIF WriteEnable = '1' then
            memory(to_integer(unsigned(address))) <= dataIn;
        end if ; 
	end process;  
end architecture DM;