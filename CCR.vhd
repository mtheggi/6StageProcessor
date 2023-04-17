library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CCR is
    port (
        CCRDatain: IN std_logic_vector(2 downto 0);
	CCRDataout: out std_logic_vector(2 downto 0);
        FlagSelector, clk, rst: in std_logic;
        FlagOutput: out std_logic
    ); -- 2: Carry, 1: Zero, 0: negative
end entity CCR;

architecture ControlRegister of CCR is
    component Reg is
    generic(n: integer:=16);
      port(
        
        d: in std_logic_vector(n-1 downto 0);
        clk, rst, enable: in std_logic;
        q: out std_logic_vector(n-1 downto 0)
      );
end component;
signal Current_flags: std_logic_vector(2 downto 0);
begin
    with FlagSelector select
        FlagOutput <= Current_flags(2) when '0',
                      Current_flags(1) when others;
flags: reg generic map (3) port map(CCRDatain, clk, rst, '1', Current_flags);
CCRDataout <= current_flags;
end architecture ControlRegister;