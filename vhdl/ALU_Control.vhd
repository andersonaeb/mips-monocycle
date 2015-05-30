----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: ALU_Control - behavior
-- Control module to ALU 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_Control is
    port(
        ALUOp: in signed(1 downto 0);
        Funct: in signed(5 downto 0);
        op: out signed(2 downto 0);
        JR: out std_logic
    );
end ALU_Control;

architecture behavior of ALU_Control is	
begin
    process(ALUOp, Funct)
    begin
        JR <= '0';
        case ALUOp is
            -- LW, SW, ADDI
            when "00"   => op <= "010";
            -- BEQ, BNE
            when "01"   => op <= "110";
            -- SLTI
            when "11"   => op <= "111";
            -- R-Format (10)
            when others =>
                case Funct(3 downto 0) is
                    -- ADD
                    when "0000" => op <= "010";
                    -- SUB
                    when "0010" => op <= "110";
                    -- AND
                    when "0100" => op <= "000";
                    -- OR
                    when "0101" => op <= "001";
                    -- JR
                    when "1000" =>
                        op <= "011";
                        JR <= '1';
                    -- Set-on-less-than
                    when others => op <= "111";
                end case;
        end case;
    end process;
end behavior;