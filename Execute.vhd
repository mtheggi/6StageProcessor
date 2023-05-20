library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Execute is
    port (
        ControlSignals : IN std_logic_vector(9 downto 0);
        ALUA, ALUB: IN std_logic_vector(15 downto 0);
        ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit, RST, clk: IN std_logic;
        OutputPort, ALUResult: OUT std_logic_vector(15 downto 0);
        ControllerSignalOut: OUT std_logic_vector(5 downto 0);
        CCROut: out std_logic_vector(2 downto 0); -- For RTI
        CCRFromRTI: IN std_logic_vector(2 downto 0);
        RTIBit: IN std_logic;
        BranchFlag: out std_logic
    );
end entity Execute;

architecture Exec of Execute is
    component ALU  is
        port (
            A,B: in std_logic_vector(15 downto 0);
            CCRIN, sel : in std_logic_vector(2 downto 0);
            ALUOperation: in std_logic;	
            F : out std_logic_vector(15 downto 0);
            CCROut : out std_logic_vector(2 downto 0)
        );
    end component;
    component CCR  is
        port (
            CCRDataIn: IN std_logic_vector(2 downto 0);
            clk, rst, enable: IN std_logic;
            CCRDataOut: out std_logic_vector(2 downto 0)
        ); -- 2: Carry, 1: Negative, 0: Zero
    end component;

    signal ALUFlags,CCROut1, OutputBeforeMux: std_logic_vector(2 downto 0);
    signal STCorCLC, JCorJZ: std_logic;
    signal MuxSelector: std_logic_vector(2 downto 0);
    signal currentRTIBit: std_logic;
    signal CCREnable: std_logic;
begin
    ControllerSignalOut <= ControlSignals(8 downto 6) & currentRTIBit & ControlSignals(3) & ControlSignals(1);
    currentRTIBit <= ControlSignals(7) and ControlSignals(1) and ALUFunction(2) and ALUFunction(1) and ALUFunction(0);
    -- MemWrite<=ControllerSignal(5);
    -- MemRead<=ControllerSignal(4);
    -- RegWrite<=ControllerSignal(3);
    -- RTI Bit (2)
    -- InEnb<=ControllerSignal(1);
    -- AddressSelector<=ControllerSignal(0);

    ALUComp: ALU port map(ALUA, ALUB, CCROut1, ALUFunction, ControlSignals(9), ALUResult, OutputBeforeMux);
    CCRComp: CCR port map(ALUFlags, clk, rst, CCREnable, CCROut1);

    CCROut <= CCROut1;

    CCREnable <= (not MuxSelector(0)) or (not MuxSelector(1));
    BranchFlag <= CCROut1(2) when ControlSignals(5) = '0'
                            else CCROut1(0);

    OutputPort <= ALUA when ControlSignals(2) = '1'
                 else (others => '0') when rst='1';

    STCorCLC <= (not (ControlSignals(8) or ControlSignals(7) or ControlSignals(6) or ControlSignals(4) or ControlSignals(2))) and (ALUFunction(1) or ALUFunction(0));
    MuxSelector <= RTIBit & STCorCLC & JCorJZ when RTIBit = '1'
                    else '0' & STCorCLC & JCorJZ;
    
    JCorJZ <= (ControlSignals(4) and not ControlSignals(0));

    ALUFlags <= OutputBeforeMux when MuxSelector = "000"
                else (ALUFunction(0) & ALUFlags(1 downto 0)) when MuxSelector = "010"
                else ('0' & ALUFlags(1 downto 0)) when MuxSelector = "001" and ALUFunction(0) = '0'
                else (ALUFlags(2 downto 1) & '0') when MuxSelector = "001" and ALUFunction(0) = '1'
                else CCRFromRTI when MuxSelector = "100"
                else (others => '0');
    
end architecture Exec;