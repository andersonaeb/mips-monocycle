----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Control - behavior
-- Control module of datapath
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Control is
	port(
		instruction: in std_logic_vector(5 downto 0);
		PCtoRA, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out std_logic;
		RegDst, ALUOp: out std_logic_vector(1 downto 0)
	);
end Control;

architecture behavior of Control is
begin
    process(instruction)
    begin
        case instruction is
            -- R-Format
            when "000000" =>
                RegDst   <= "01";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '1';
                ALUOp    <= "10";
            
            -- LW
            when "100000" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '1';   
                MemtoReg <= '1';
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "00";
            
            -- SW
            when "101110" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '1';
                ALUSrc   <= '1';
                RegWrite <= '0';
                ALUOp    <= "00";
                
            -- BEQ
            when "000100" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '1';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '0';
                ALUOp    <= "01";
            
            -- BNE
            when "000101" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '1';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '0';
                ALUOp    <= "01";
            
            -- J
            when "000010" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '1';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '0';
                ALUOp    <= "00";
            
            -- JAL
            when "000011" =>
                RegDst   <= "00";
                PCtoRA   <= '1';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '1';
                ALUOp    <= "00";
            
            -- ADDI
            when "000000" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "00";
                            
            -- SLTI
            when "000000" =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "11";
                
        end case;
    end process;
end behavior;