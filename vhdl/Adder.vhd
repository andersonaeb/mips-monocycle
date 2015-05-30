----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Adder - behavior
-- 32-bits Adder 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
	port(
		A, B: in signed(31 downto 0);
		result: out signed(31 downto 0)
	);
end Adder;

architecture behavior of Adder is
begin
    result <= A + B;
end behavior;