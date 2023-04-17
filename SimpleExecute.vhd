library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SimpleExecute is
    port (
        ControlSignals : IN std_logic_vector(9 downto 0);
        Rs, Rt, Immediate: IN std_logic_vector(15 downto 0);
	ALUFunction: IN std_logic_vector(2 downto 0);
        identifierBit, clk, rst: IN std_logic;
        OutputPort, ALUResult: OUT std_logic_vector(15 downto 0);
        ControllerSignalOut: OUT std_logic_vector(4 downto 0);
        BranchFlag: out std_logic;
	Flags: out std_logic_vector(2 downto 0)
    );
end entity SimpleExecute;

architecture arch1 of SimpleExecute is
    component ALU  is
        port (
            A,B: in std_logic_vector(15 downto 0);
            CCRIN, sel : in std_logic_vector(2 downto 0);
            ALUOperation: in std_logic;	
            F : out std_logic_vector(15 downto 0);
            CCROut : out std_logic_vector(2 downto 0)
        );
    end component;
    component CCR is
    port (
        CCRDatain: IN std_logic_vector(2 downto 0);
	CCRDataout: out std_logic_vector(2 downto 0);
        FlagSelector, clk, rst: in std_logic;
        FlagOutput: out std_logic
    ); -- 2: Carry, 1: Zero, 0: negative
    end component;

    signal ALUB: std_logic_vector(15 downto 0);
    signal ALUFlagsin, CCROut, OutputBeforeMux: std_logic_vector(2 downto 0);
    signal STCorCLC: std_logic;
    
begin
    --Branch signal missing
    ControllerSignalOut <= ControlSignals(8 downto 6) & ControlSignals(3) & ControlSignals(1);

    -- MemWrite<=ControllerSignal(4);
    -- MemRead<=ControllerSignal(3);D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/SimpleExecute.vhd
    -- RegWrite<=ControllerSignal(2);
    -- InEnb<=ControllerSignal(1);
    -- AddressSelector<=ControllerSignal(0);

    with identifierBit select
        ALUB <= Rt when '0',
                Immediate when others;

    ALUComp: ALU port map(Rs, ALUB, CCROut, ALUFunction, ControlSignals(9), ALUResult, OutputBeforeMux);
    CCRComp: CCR port map(ALUFlagsin, CCROut, ControlSignals(5), clk, rst, BranchFlag);

    OutputPort <= Rs when ControlSignals(2) = '1';

    STCorCLC <= (not (ControlSignals(8) or ControlSignals(7) or ControlSignals(6) or ControlSignals(4)) or ControlSignals(2)) and (ALUFunction(1) or ALUFunction(0));

    with STCorCLC select
        ALUFlagsin <= OutputBeforeMux when '0',
                    (ALUFunction(0) & CCROut(1 downto 0)) when others;
    Flags <= CCROut;
end architecture arch1;