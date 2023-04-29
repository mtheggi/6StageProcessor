library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Branch is
    port (
        BranchFlag, UncondJump, BranchSignal: in std_logic;
        UpdateSelector: out std_logic
    );
end entity Branch;

architecture BranchLogic of Branch is
signal condition: std_logic;
begin
    with UncondJump select
    condition <= '1' when '1',
                 BranchFlag when others;
	
    UpdateSelector <= condition and BranchSignal;
    
end architecture BranchLogic;
