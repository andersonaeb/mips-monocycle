----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Memory - behavior
-- Memory Module, use 4 bytes for every word
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Memory is
	port(
        MemRead, MemWrite: in std_logic;
        address: in std_logic_vector(31 downto 0);
        read_data: out std_logic_vector(31 downto 0);
        write_data: in std_logic_vector(31 downto 0)
	);
end Memory;

architecture behavior of Memory is
    -- 256 bytes
    type RAM is array(0 to 255) of std_logic_vector(7 downto 0);
    signal memory_data: RAM;
    
	begin
		process(MemRead, MemWrite, address, write_data)
		    variable addr: integer;
		begin
		    addr := conv_integer(address);
		    
			if(MemRead = '1') then
				read_data <= memory_data(addr) &
				             memory_data(addr + 1) &
				             memory_data(addr + 2) &
				             memory_data(addr + 3);
            elsif(MemWrite = '1') then
                memory_data(addr)     <= write_data(31 downto 24);
                memory_data(addr + 1) <= write_data(23 downto 16);
                memory_data(addr + 2) <= write_data(15 downto 8);
                memory_data(addr + 3) <= write_data(7 downto 0);
			end if;
		end process;
end behavior;