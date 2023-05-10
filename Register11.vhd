library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg11 is
    generic(n: integer:=16);
      port(
        
        d: in std_logic_vector(n-1 downto 0);
        clk, rst, enable: in std_logic;
        q: out std_logic_vector(n-1 downto 0)
      );
    end entity;

    architecture ArchOfReg of Reg11 is
    begin
      process(clk, rst) begin
        if rising_edge(clk) then
          if rst = '1' then
            q <= (others=>'0');
          elsif enable = '1' THEN
            q <= d;
          end if;
        end if;
      end process;
    end ArchOfReg ; -- ArchOfReg
