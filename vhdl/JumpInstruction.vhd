----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: JumpInstruction - behavior
-- Return address of Jump Instruction
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity JumpInstruction is
    port(
        instruction: signed(25 downto 0);
        pc: in signed(3 downto 0);
        result: out signed(31 downto 0)
    );
end JumpInstruction;

architecture behavior of JumpInstruction is
begin
    result <= pc & (instruction & "00");
end behavior;