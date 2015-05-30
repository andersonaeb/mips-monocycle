----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Mux4To1 - behavior
-- Multiplexer 4 to 1 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux4To1 is
    port (
        A, B, C, D: in signed(4 downto 0);
        Sel: in signed(1 downto 0);
        S: out signed(4 downto 0)
    );
end Mux4To1;

architecture behavior of Mux4To1 is
begin	
    process(A, B, C, D, Sel) is
    begin
        case Sel is
            when "00"   => S <= A;
            when "01"   => S <= B;
            when "10"   => S <= C;
            when others => S <= D;
        end case;
    end process;
end behavior;
