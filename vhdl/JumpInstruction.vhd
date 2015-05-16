----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Module: JumpInstruction - behavior
-- Module return address of Jump Instruction
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity JumpInstruction is
    port(
        inst, pc: in std_logic_vector(31 downto 0);
        result: out std_logic_vector(31 downto 0)
    );
end JumpInstruction;

architecture behavior of JumpInstruction is
begin
    result <= pc(31 downto 28) & (inst(25 downto 0) & "00");
end behavior;