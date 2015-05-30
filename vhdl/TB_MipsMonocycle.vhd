----------------------------------------------------------------------------------
-- TestBench MIPS MONOCYCLE
-- Module: MipsMonocycle - TB
-- TestBench of MipsMonocycle
----------------------------------------------------------------------------------

library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_MipsMonocycle is
end TB_MipsMonocycle;

architecture TB of TB_MipsMonocycle is
    
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
                
        -- addi $1, $0, 5
        WriteInstruction <= "00100000000000010000000000000101";
        wait for clk_period;

        -- add $2, $1, $1
        WriteInstruction <= "00000000001000010001000000100000";
        InitAddress <= InitAddress + 4;
        wait for clk_period;

        -- addi $1, $2, 20
        WriteInstruction <= "00100000010000010000000000010100";
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