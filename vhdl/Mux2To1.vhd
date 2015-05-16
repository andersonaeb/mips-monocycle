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
        A, B: in std_logic_vector(31 downto 0);
        Sel: in std_logic;
        S: out std_logic_vector(31 downto 0)
    );
end Mux2To1;

architecture behavior of Mux2To1 is
begin
    S <= A when Sel = '1' else B;
end behavior;