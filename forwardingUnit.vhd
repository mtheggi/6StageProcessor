library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity forwardingUnit is
    port (
        RsAddress, RtAddress: IN std_logic_vector(2 downto 0);
        ALUImmSrc: IN std_logic;
        RegWriteFromM1, RegWriteFromM2, RegWriteFromWB: IN std_logic;
        MemReadFromM1, MemReadFromM2: IN std_logic;
        RdFromM1, RdFromM2, RdFromWB: IN std_logic_vector(2 downto 0);
        Operand1Sel: OUT std_logic_vector(1 downto 0);
        Operand2Sel: OUT std_logic_vector(2 downto 0);
        LDUse: OUT std_logic
    );
end entity forwardingUnit;

architecture FUnit of forwardingUnit is
    
begin
    LDUse <= '1' when (MemReadFromM1 = '1' and (RsAddress = RdFromM1 or RtAddress = RdFromM1) and RegWriteFromM1 = '1') or 
            (MemReadFromM2 = '1' and (RsAddress = RdFromM2 or RtAddress = RdFromM2) and RegWriteFromM2 = '1')
    else '0';

    Operand1Sel <= "01" when RsAddress = RdFromM1 and RegWriteFromM1 = '1'
              else "10" when RsAddress = RdFromM2 and RegWriteFromM2 = '1'
              else "11" when RsAddress = RdFromWB and RegWriteFromWB = '1'
              else "00";
              
    Operand2Sel <= "001" when ALUImmSrc = '1'
                    else "010" when RtAddress = RdFromM1 and RegWriteFromM1 = '1'
                    else "011" when RtAddress = RdFromM2 and RegWriteFromM2 = '1'
                    else "100" when RtAddress = RdFromWB and RegWriteFromWB = '1'
                    else "000";               
    
    
end architecture FUnit;