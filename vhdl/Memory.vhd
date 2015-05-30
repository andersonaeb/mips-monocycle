----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Memory - behavior
-- Memory Module, use 4 bytes for every word
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
	port(
        clk, MemRead, MemWrite: in std_logic;
        address: in signed(31 downto 0);
        read_data: out signed(31 downto 0);
        write_data: in signed(31 downto 0)
	);
end Memory;

architecture behavior of Memory is
    -- 256 bytes
    type RAM is array(0 to 255) of signed(7 downto 0);
    signal memory_data: RAM;
    signal addr: integer;
    
	begin
		process(clk, MemRead, address)
		begin
		    addr <= to_integer(address);

            if falling_edge(clk) then
                if MemWrite = '1' then
                    memory_data(addr)     <= write_data(31 downto 24);
                    memory_data(addr + 1) <= write_data(23 downto 16);
                    memory_data(addr + 2) <= write_data(15 downto 8);
                    memory_data(addr + 3) <= write_data(7 downto 0);
    			end if;
    		end if;
    		
            if MemRead = '1' then
                read_data <= memory_data(addr) &
                             memory_data(addr + 1) &
                             memory_data(addr + 2) &
                             memory_data(addr + 3);
            end if;
		end process;
end behavior;