----------------------------------------------------------------------------------
-- TestBench MIPS MONOCYCLE
-- Module: MipsMonocycle - TB
-- TestBench of MipsMonocycle
----------------------------------------------------------------------------------

library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity TBFibo_MipsMonocycle is
end TBFibo_MipsMonocycle;

architecture TB of TBFibo_MipsMonocycle is
    
    component MipsMonocycle
        port(clk, reset, InstructionAddr, IMRead, IMWrite : in std_logic;
             InitAddress, WriteInstruction                : signed(31 downto 0));
    end component MipsMonocycle;
    
    -- Constants
    constant clk_period:time := 10 ns;
    
    -- Signs
    signal clk, reset, InstructionAddr, IMRead, IMWrite: std_logic;
    signal InitAddress, WriteInstruction: signed(31 downto 0);    
begin
    
    U_Mips: MipsMonocycle port map(clk, reset, InstructionAddr, IMRead, IMWrite, InitAddress, WriteInstruction);
    
    -- Clock process
    Clock: process is
    begin
        clk <= '1';
        wait for (clk_period / 2);
        clk <= '0';
        wait for (clk_period / 2);
    end process Clock;
    
    -- Test
    process
    begin
        
        -- Init signs and Instructions
        InitAddress <= x"00000000";
        InstructionAddr <= '1';
        IMRead <= '0';
        IMWrite <= '1';
        reset <= '0';
        wait for clk_period;
                
        -- addi $t0, $0, 10 # main:
        WriteInstruction <= "00100000000010000000000000001010";
        wait for clk_period;

        -- addi $t1, $0, 0
        WriteInstruction <= "00100000000010010000000000000000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;

        -- addi $t2, $0, 1
        WriteInstruction <= "00100000000010100000000000000001";
        InitAddress <= InitAddress + 4;
        wait for clk_period;       

        -- add $t3, $0, $0
        WriteInstruction <= "00000000000000000101100000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;
        
        -- add $t5, $0 $0
        WriteInstruction <= "00000000000000000110100000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- add $t6, $0, $0
        WriteInstruction <= "00000000000000000111000000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;
        
        -- slt $t4, $t5, $t0 # for:
        WriteInstruction <= "00000001101010000110000000101010";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- beq $t4, $0, 6
        WriteInstruction <= "00010000000011000000000000000110";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- add $t3, $t1, $t2
        WriteInstruction <= "00000001001010100101100000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- add $t1, $t2, $0
        WriteInstruction <= "00000001010000000100100000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- add $t2, $t3, $0
        WriteInstruction <= "00000001011000000101000000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- addi $t5, $t5, 1
        WriteInstruction <= "00100001101011010000000000000001";
        InitAddress <= InitAddress + 4;
        wait for clk_period;  
        
        -- sw $t3, 0($t6)
        WriteInstruction <= "10101101110010110000000000000000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;
        
        -- addi $t6, $t6 4
        WriteInstruction <= "00100001110011100000000000000100";
        InitAddress <= InitAddress + 4;
        wait for clk_period;
        
        -- j 6
        WriteInstruction <= "00001000000000000000000000000110";
        InitAddress <= InitAddress + 4;
        wait for clk_period;    
        
        -- Start Program
        IMRead <= '1';
        IMWrite <= '0';
        InstructionAddr <= '0';
        
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        for i in 0 to 300 loop
            wait for clk_period;
        end loop;
    
    end process;
    

end TB;

configuration CFG_TB of tb_MipsMonocycle is
    for TB
    end for;
end CFG_TB;