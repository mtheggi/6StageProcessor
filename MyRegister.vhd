library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MyRegister is
    generic (n: integer:= 10);
    port (
        Clk,Rst, enable : IN std_logic;
        d : IN std_logic_vector(n-1 DOWNTO 0);
        q : OUT std_logic_vector(n-1 DOWNTO 0)
    );
end MyRegister;

ARCHITECTURE a_my_nDFF OF MyRegister IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
    IF Rst = '1' THEN
        q <= (OTHERS=>'0');
    ELSIF rising_edge(Clk) THEN
        if enable = '1' then
            q <= d;
        end if;
    END IF;
END PROCESS;
END a_my_nDFF;