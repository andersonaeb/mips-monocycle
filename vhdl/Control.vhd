----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: Control - behavior
-- Control module of datapath
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Control is
	port(
		instruction: in signed(5 downto 0);
		PCtoRA, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out std_logic;
		RegDst, ALUOp: out signed(1 downto 0)
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
            when "100011" =>
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
            when "101011" =>
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
            when "001000" =>
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
            when "001010" =>
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
            
            -- NOP
            when others =>
                RegDst   <= "00";
                PCtoRA   <= '0';
                Jump     <= '0';
                Beq      <= '0';
                Bne      <= '0';
                MemRead  <= '0';   
                MemtoReg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '0';
                ALUOp    <= "00";
        end case;
    end process;
end behavior;