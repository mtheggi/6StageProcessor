LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

package instruction_buffer_type is
	type instructionBuffer is array(0 to 7) of std_logic_vector (15 downto 0);
end package instruction_buffer_type;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use work.instruction_buffer_type.all;

entity Processor is
    port (
        CLK: IN std_logic;
        RST: IN std_logic;
        PCOut: out std_logic_vector(9 downto 0);
        OUT1: out instructionBuffer
    );
end entity Processor;

architecture Proc of Processor is
	component RegistersWithVec is 
	 generic (n: integer:= 10);
    port (
        WritePort: in std_logic_vector(n - 1 DOWNTO 0);
	    ReadPort: out std_logic_vector(n - 1 DOWNTO 0);
        WriteAddress, ReadAddress: in std_logic_vector(2 DOWNTO 0);
        CLK, RST, WriteEnable:  in std_logic;
	AllRegisters: out instructionBuffer
    );
end component;
    component alu is
generic (n: integer:= 16);
port (
	A,B: in std_logic_vector(n-1 downto 0);
	sel : in std_logic_vector(3 downto 0);
	F : out std_logic_vector(n-1 downto 0);
	cin: in std_logic;
	cout : out std_logic
);	

	
end component;
    SIGNAL instruction: std_logic_vector(9 downto 0);
    Signal opcode: std_logic_vector(15 downto 0);
    Signal opcodeFromBuffer: std_logic_vector(15 downto 0);
signal ALUSelect :std_logic_vector(3 downto 0);
signal  Cin1:  std_logic;
signal RegWrite: std_logic;

signal ALUBufferReadPort:std_logic_vector(15 DOWNTO 0);
signal OutPutbufferBeforeALU: std_logic_vector(24 DOWNTO 0);
signal InputbufferBeforeALU: std_logic_vector(24 DOWNTO 0);
signal AluOutput: std_logic_vector(15 DOWNTO 0);
signal AluOutputCout:std_logic	;
signal InputBufferWB: std_logic_vector(20 DOWNTO 0);
signal OutPutBufferWB: std_logic_vector(20 DOWNTO 0);
signal NotCLK: std_logic;
begin
    
    PCEnt: entity work.PC port map(RST, '1', CLK, instruction);

    instructionCache: entity work.instruction_cache port map(instruction(9 downto 0), opcode);

    Buffer1: entity work.MyRegister generic map(16) port map(CLK, RST, '1', opcode(15 downto 0), opcodeFromBuffer);

    controllerCirc: entity work.controller port map(opcodeFromBuffer(15 downto 13), RegWrite, ALUSelect, Cin1);

    mem : RegistersWithVec generic map (16) port map(OutPutBufferWB(20 downto 5), ALUBufferReadPort, OutPutBufferWB(2 downto 0),opcodeFromBuffer(12 downto 10),CLK,RST,OutPutBufferWB(3), OUT1);

    InputbufferBeforeALU<=opcodeFromBuffer(6 downto 4) & ALUSelect(3 downto 0) & RegWrite & Cin1 & ALUBufferReadPort(15 downto 0);

    Buffer2: entity work.MyRegister generic map(25) port map(CLK, RST, '1', InputbufferBeforeALU(24 downto 0),OutPutbufferBeforeALU(24 downto 0));

    ALU1: alu generic map(16) port map(OutPutbufferBeforeALU(15 downto 0),(OTHERS=>'0'),OutPutbufferBeforeALU(21 downto 18),AluOutput(15 downto 0),OutPutbufferBeforeALU(16),AluOutputCout);

    InputBufferWB<= AluOutput(15 downto 0) & AluOutputCout & OutPutbufferBeforeALU(17)& OutPutbufferBeforeALU(24 downto 22); 
	NotCLK<=not CLK;
    BufferWB:  entity work.MyRegister generic map(21) port map(NotCLK, RST, '1', InputBufferWB(20 downto 0),OutPutBufferWB(20 downto 0));

    PCOut <= instruction;

end architecture Proc;