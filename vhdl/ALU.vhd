----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: ALU - behavior
-- ALU: Operations (and, or, add, subtract, set-on-less-then 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity ALU is
    port(
        op: in std_logic_vector(2 downto 0);
        A, B: in std_logic_vector(31 downto 0);
        Zero: out std_logic;
        result: out std_logic_vector(31 downto 0)
    );
end ALU;

architecture behavior of ALU is
    signal T_result: std_logic_vector(31 downto 0);	
begin
    process(A, B, op)
    begin
        case op is
            when "000" => T_result <= A and B;
            when "001" => T_result <= A or B;
            when "010" => T_result <= A + B;
            when "110" => T_result <= A - B;
            when "111" =>
                if (A < B) then
                    T_result <= x"00000001";
                else
                    result <= x"00000000";
                end if;
            when others => T_result <= x"00000000";
        end case;
        
        if(T_result = x"00000000") then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
	end process;
    result <= T_result;
end behavior;