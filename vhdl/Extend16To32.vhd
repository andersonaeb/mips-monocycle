----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Extend16To32 - behavior
-- Signal Extender of 16 bits to 32 bits 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Extend16To32 is
    port(
        s_in: in std_logic_vector(15 downto 0);
        s_out: out std_logic_vector(31 downto 0)
    );
end Extend16To32;

architecture behavior of Extend16To32 is
begin
    process (s_in) is
        begin
            if s_in(15) = '0' then
            s_out <= "0000000000000000" & s_in;
        else
            s_out <= "1111111111111111" & s_in;
        end if;
    end process;
end behavior;