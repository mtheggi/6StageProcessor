library ieee;
use ieee.std_logic_1164.all;

entity alu is
port (
	A,B: in std_logic_vector(15 downto 0);
	CCRIN, sel : in std_logic_vector(2 downto 0);
	ALUOperation: in std_logic;	
	F : out std_logic_vector(15 downto 0);
	CCROut : out std_logic_vector(2 downto 0)
);	-- 2: Carry, 1: Zero, 0: negative

end alu;

architecture arch4 of alu is
component select_adder  is
generic (n: integer:= 10);
PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
end component;

signal ALUNot,ALUMov,ALUAdding,ALUAnd,ALUOr: std_logic_vector(15 downto 0);
signal inputToAdder, notB, ALUResult: std_logic_vector(15 downto 0);
signal AdderCin, CarryOut, notMov, NFlag, ZFlag: std_logic;
signal CarrySelectors1: std_logic_vector(1 downto 0);

begin
	F <= ALUResult;
	ALUNot <= not A;
	notB <= not B;
	with sel select
		inputToAdder <= "0000000000000001" when "100",
						"1111111111111111" when "101",
						B when "110",
						notB when others;
		

	with sel select
		AdderCin <= '1' when "111",
					'0' when others;

	
	AddingFunc: select_adder generic map(16) port map(A, inputToAdder, AdderCin, ALUAdding, CarryOut);

	ALUMov <= B;
	ALUAnd <= A and B;
	AluOr <= A or B;

	with sel select
		ALUResult <= ALUNot when "000",
			 ALUMov when "011",
			 ALUAnd when "001",
			 ALUOr when "010",
			 ALUAdding when others;

	notMov <= (((sel(2)) or (not sel(1))) or (not sel(0))) and (ALUOperation);
	with ALUResult(15) select
		NFlag <= '1' when '1',
				 '0' when others;

	with ALUResult select
		ZFlag <= '1' when "0000000000000000",
				 '0' when others;

	with notMov select
		CCROut(1 downto 0) <= ZFlag & NFlag when '1',
						   CCRIN(1 downto 0) when others;
		 
	CarrySelectors1 <= (notMov and sel(2)) & sel(0);
	with CarrySelectors1 select
		CCROut(2) <= CarryOut when "10",
					 not CarryOut when "11",					 
				  	 CCRIN(2) when others;
	

end arch4;