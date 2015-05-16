----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Adder - behavior
-- 32-bits Adder 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Adder is
	port(
		A, B: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0)
	);
end Adder;

architecture behavior of Adder is
begin
    result <= A + B;
end behavior;