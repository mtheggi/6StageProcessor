entity forwardingUnit is
    port (
        RsAddress, RtAddress: IN std_logic_vector(2 downto 0);
        ALUImmSrc: IN std_logic;
        RdFromMemory, RdFromWB: IN std_logic_vector(2 downto 0);
        MemReadFromM1, RegWriteFromWB, RegWriteFromM1: IN std_logic; -- To Be Completed
        DataInWrite, DataInMemory: IN std_logic_vector(15 downto 0);
        operand1Select, operand2Select: out std_logic_vector(1 downto 0);
    );
end entity forwardingUnit;

architecture FUnit of forwardingUnit is
    
begin
    
    
    
end architecture FUnit;