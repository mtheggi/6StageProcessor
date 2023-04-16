library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Execute is
    port (
        ControlSignals : IN std_logic_vector(9 downto 0);
        Rs, Rt, Immediate: IN std_logic_vector(15 downto 0);
        RsAddress, RtAddress, Rd, ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit: IN std_logic;
        RdFromMemory, RdFromWB: IN std_logic_vector(2 downto 0);
        MemReadFromM1, RegWriteFromWB, RegWriteFromM1: IN std_logic; -- To Be Completed
        DataInWrite, DataInMemory: IN std_logic_vector(15 downto 0);
        OutputPort, RsOut, ALUResult: OUT std_logic_vector(15 downto 0);
        RdOut: OUT std_logic_vector(2 downto 0);
        ControllerSignalOut: OUT std_logic_vector(4 downto 0);
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
    signal ALUFlags: std_logic_vector(2 downto 0);
    
begin
    RdOut <= Rd;
    ControllerSignalOut <= ControlSignals(8 downto 6) & ControlSignals(3) & ControlSignals(1);
    RSOut <= Rs;

    -- MemWrite<=ControllerSignal(4);
    -- MemRead<=ControllerSignal(3);
    -- RegWrite<=ControllerSignal(2);
    -- InEnb<=ControllerSignal(1);
    -- AddressSelector<=ControllerSignal(0);

    with identifierBit select
        ALUB <= Rt when '0',
                Immediate when others;

    ALUComp: ALU port map(Rs, ALUB, ALUFlags, ALUFunction, ControlSignals(9), ALUResult, ALUFlags);
    CCRComp: CCR port map(ALUFlags, ControlSignals(5), BranchFlag);

    OutputPort <= Rs when ControlSignals(2) = '1';
    
    
end architecture Exec;