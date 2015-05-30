----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Mux2To1 - behavior
-- Multiplexer 2 to 1 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux2To1 is
    port (
        A, B: in signed(31 downto 0);
        Sel: in std_logic;
        S: out signed(31 downto 0)
    );
end Mux2To1;

architecture behavior of Mux2To1 is
begin
    process(A, B, Sel) is
    begin
        case Sel is
            when '0'    => S <= A;
            when others => S <= B;
        end case;
    end process;
end behavior;