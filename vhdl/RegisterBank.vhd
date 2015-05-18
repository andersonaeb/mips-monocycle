----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: PC - behavior
-- Bank Registers // 32 Registers of 32 bits
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RegisterBank is
    port(
        RegWrite: std_logic;
        read_reg1, read_reg2, write_reg: in std_logic_vector(4 downto 0);
        write_data: in std_logic_vector(31 downto 0);
        read_data1, read_data2: out std_logic_vector(31 downto 0)
	);
end RegisterBank;

architecture behavior of RegisterBank is
    type bank is array(0 to 31) of std_logic_vector(31 downto 0);
    signal memory: bank := (
        others => X"00000000"
    );
begin	
    read_data1 <= memory(conv_integer(read_reg1));
    read_data2 <= memory(conv_integer(read_reg2));
	
    process (RegWrite, write_reg, write_data)
    begin
        if RegWrite = '1' and write_reg /= "00000" then  
            memory(conv_integer(write_reg)) <= write_data;
        end if;
    end process;
	
end behavior;