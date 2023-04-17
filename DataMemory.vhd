Library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

Entity DataMemory is 
    port(
        WriteEnable , ReadEnable , Reset, INTR: in std_logic; 
        address : in std_logic_vector(9 downto 0  ) ; 
        dataIn : in std_logic_vector(31 downto 0); 
        dataOut : out std_logic_vector(31 downto 0 )
    );

end Entity DataMemory;
architecture DM of DataMemory is 
    type Dmemory is array (0 to 1023) of std_logic_vector(15 downto 0);
    signal memory : Dmemory := (others => (others => '0'));
    signal latched_address : std_logic_vector(9 downto 0);
    signal latched_data : std_logic_vector(31 downto 0); 
    signal latched_memRead: std_logic; 
    signal latched_memWrite: std_logic; 
begin 
	process(Reset , WriteEnable , ReadEnable , INTR)
      variable tempAddress : integer := 0; 
    begin 
        
        if rising_edge(WriteEnable) or rising_edge(ReadEnable) then   
                latched_address <= address;
                latched_data <= dataIn; 
                latched_memWrite <= WriteEnable;
                latched_memRead <= ReadEnable;
        end if ;  
    
        if Reset = '1' then 
	        memory <= (others => (others=> '0'));  
            latched_address <= (others => '0'); 
            latched_data <= (others => '0'); 
            latched_memRead <= '0'; 
            latched_memWrite <= '0';   		
 	    ELSIF ReadEnable  = '1' then 

                dataOut(15 downto 0 ) <= memory(to_integer(unsigned(address))); 
                tempAddress := to_integer(unsigned(address)) + 1; 
                dataOut(31 downto 16) <= memory(tempAddress);

                latched_address <= address;        
        ELSIF WriteEnable = '1' then
            if INTR  = '1' then  
                memory(to_integer(unsigned(address))) <= dataIn(15 downto 0); 
                memory(to_integer(unsigned(address)) + 1) <= dataIn(31 downto 16); 		
            else 
                memory(to_integer(unsigned(address))) <= dataIn(15 downto 0); 
        end if ;
        
           
        
        end if ; 
    end process; 
end architecture DM;