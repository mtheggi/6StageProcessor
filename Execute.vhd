library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Execute is
    port (
        ControlSignals : IN std_logic_vector(9 downto 0);
        Rs, Rt, Immediate: IN std_logic_vector(15 downto 0);
        ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit: IN std_logic;
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
            CCRData: IN std_logic_vector(2 downto 0);
            FlagSelcetor: in std_logic;
            FlagOutput: out std_logic
        );
    end component;

    signal ALUB: std_logic_vector(15 downto 0);
    signal ALUFlags, OutputBeforeMux: std_logic_vector(2 downto 0);
    signal STCorCLC: std_logic;
    signal MuxSelector: std_logic_vector(1 downto 0);
    
begin
    ControllerSignalOut <= ControlSignals(8 downto 6) & ControlSignals(4) & ControlSignals(3) & ControlSignals(1);
    CCROut <= ALUFlags;

    -- MemWrite<=ControllerSignal(4);
    -- MemRead<=ControllerSignal(3);
    -- RegWrite<=ControllerSignal(2);
    -- Branch
    -- InEnb<=ControllerSignal(1);
    -- AddressSelector<=ControllerSignal(0);

    with identifierBit select
        ALUB <= Rt when '0',
                Immediate when others;

    ALUComp: ALU port map(Rs, ALUB, ALUFlags, ALUFunction, ControlSignals(9), ALUResult, OutputBeforeMux);
    CCRComp: CCR port map(ALUFlags, ControlSignals(5), BranchFlag);

    OutputPort <= Rs when ControlSignals(2) = '1';

    STCorCLC <= (not (ControlSignals(8) or ControlSignals(7) or ControlSignals(6) or ControlSignals(4)) or ControlSignals(2)) and (ALUFunction(1) or ALUFunction(0));
    MuxSelector <= RTIBit & STCorCLC when RTIBit = '1'
                    else '0' & STCorCLC;
    
    with MuxSelector select
        ALUFlags <= OutputBeforeMux when "00",
                    (ALUFunction(0) & ALUFlags(1 downto 0)) when "01",
                    CCRFromRTI when others;
    
end architecture Exec;