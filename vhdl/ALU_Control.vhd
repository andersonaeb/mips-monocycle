----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: ALU_Control - behavior
-- Module to control ALU 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity ALU_Control is
    port(
        ALUOp: in std_logic_vector(1 downto 0);
        Funct: in std_logic_vector(5 downto 0);
        op: out std_logic_vector(2 downto 0)
    );
end ALU_Control;

architecture behavior of ALU_Control is	
begin
    process(ALUOp, Funct)
    begin
        case ALUOp is
            when "00"   => op <= "010";
            when "01"   => op <= "110";
            when "11"   => op <= "111";
            when others =>
                case Funct is
                    when "100000" => op <= "010";
                    when "100010" => op <= "110";
                    when "100100" => op <= "000";
                    when "100101" => op <= "001";
                    when others => op <= "111";
                end case;
        end case;
    end process;
end behavior;