----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Datapath 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MixMonocycle is
	
end MixMonocycle;

-------------------------------------------------------------------------

architecture behavior of MixMonocycle is
	
	component Mux2To1
		port(A, B : in  signed(31 downto 0);
			 Sel  : in  std_logic;
			 S    : out signed(31 downto 0));
	end component Mux2To1;
	
begin
	
end behavior;