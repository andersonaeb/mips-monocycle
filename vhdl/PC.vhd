----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: PC - behavior
-- Program Instruction 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(
        clk, rst: in std_logic;
		D: in signed(31 downto 0);
		Q: out signed(31 downto 0)
	);
end PC;

architecture behavior of PC is
    
    signal address: signed(31 downto 0);
    
	begin
		process(clk, rst)
		begin
			if(rst = '1') then
				address <= "00000000000000000000000000000000";
			else
				if rising_edge(clk) then
					address <= D;
				end if;
			end if;
		end process;
		
		Q <= address;
		
end behavior;