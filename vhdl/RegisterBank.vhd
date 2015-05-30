----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: PC - behavior
-- Bank Registers // 32 Registers of 32 bits
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterBank is
    port(
        clk, RegWrite: std_logic;
        read_reg1, read_reg2, write_reg: in signed(4 downto 0);
        write_data: in signed(31 downto 0);
        read_data1, read_data2: out signed(31 downto 0)
	);
end RegisterBank;

architecture behavior of RegisterBank is
    type bank is array(0 to 31) of signed(31 downto 0);
    signal memory: bank := (
        others => x"00000000"
    );
begin	
    
    read_data1 <= memory(to_integer('0' & read_reg1));
    read_data2 <= memory(to_integer('0' & read_reg2));
	
    process (clk, RegWrite, write_reg, write_data)
    begin
        if falling_edge(clk) then
            if RegWrite = '1' and write_reg /= "00000" then  
                memory(to_integer('0' & write_reg)) <= write_data;
            end if;
        end if;
    end process;
	
end behavior;