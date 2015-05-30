----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: ALU - behavior
-- ALU: Operations (and, or, add, subtract, set-on-less-then 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port(
        op: in signed(2 downto 0);
        A, B: in signed(31 downto 0);
        Zero: out std_logic;
        result: out signed(31 downto 0)
    );
end ALU;

architecture behavior of ALU is
begin
    process(A, B, op)
        variable T_result: signed(31 downto 0);   
    begin
        case op is
            when "000" => T_result := A and B;
            when "001" => T_result := A or B;
            when "010" => T_result := A + B;
            when "110" => T_result := A - B;
            when "111" =>
                if (A < B) then
                    T_result := x"00000001";
                else
                    T_result := x"00000000";
                end if;
            when others => T_result := x"00000000";
        end case;
        
        if(T_result = x"00000000") then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
        
        result <= T_result;
	end process;
	
end behavior;