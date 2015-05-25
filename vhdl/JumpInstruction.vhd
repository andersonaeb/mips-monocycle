----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: JumpInstruction - behavior
-- Return address of Jump Instruction
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity JumpInstruction is
    port(
        instruction: std_logic_vector(25 downto 0);
        pc: in std_logic_vector(4 downto 0);
        result: out std_logic_vector(31 downto 0)
    );
end JumpInstruction;

architecture behavior of JumpInstruction is
begin
    result <= pc & (instruction & "00");
end behavior;