----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Datapath 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MixMonocycle is
	port(
        clk, read_im, write_im: in std_logic
	);
end MixMonocycle;

-------------------------------------------------------------------------

architecture behavior of MixMonocycle is
	
	component Mux2To1
	    port(A, B : in  std_logic_vector(31 downto 0);
	         Sel  : in  std_logic;
	         S    : out std_logic_vector(31 downto 0));
	end component Mux2To1;
	
	component Mux4To1
	    port(A, B, C, D : in  std_logic_vector(31 downto 0);
	         Sel        : in  std_logic_vector(1 downto 0);
	         S          : out std_logic_vector(31 downto 0));
	end component Mux4To1;
	
	component PC
	    port(clk, rst : in  std_logic;
	         D        : in  std_logic_vector(31 downto 0);
	         Q        : out std_logic_vector(31 downto 0));
	end component PC;
	
	component Control
	    port(instruction                                                           : in  std_logic_vector(31 downto 26);
	         PCtoRA, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite : out std_logic;
	         RegDst, ALUOp                                                         : out std_logic_vector(1 downto 0));
	end component Control;
	
	component Memory
	    port(MemRead, MemWrite : in  std_logic;
	         address           : in  std_logic_vector(31 downto 0);
	         read_data         : out std_logic_vector(31 downto 0);
	         write_data        : in  std_logic_vector(31 downto 0));
	end component Memory;
	
	component Adder
	    port(A, B   : in  std_logic_vector(31 downto 0);
	         result : out std_logic_vector(31 downto 0));
	end component Adder;
	
	component RegisterBank
	    port(RegWrite                        : std_logic;
	         read_reg1, read_reg2, write_reg : in  std_logic_vector(4 downto 0);
	         write_data                      : in  std_logic_vector(31 downto 0);
	         read_data1, read_data2          : out std_logic_vector(31 downto 0));
	end component RegisterBank;
	
	component Extend16To32
	    port(s_in  : in  std_logic_vector(15 downto 0);
	         s_out : out std_logic_vector(31 downto 0));
	end component Extend16To32;
	
	component JumpInstruction
	    port(instruction : std_logic_vector(25 downto 0);
	         pc          : in  std_logic_vector(31 downto 28);
	         result      : out std_logic_vector(31 downto 0));
	end component JumpInstruction;
	
	component ALU_Control
	    port(ALUOp : in  std_logic_vector(1 downto 0);
	         Funct : in  std_logic_vector(5 downto 0);
	         op    : out std_logic_vector(2 downto 0);
	         JR    : out std_logic);
	end component ALU_Control;
	
	component ALU
	    port(op     : in  std_logic_vector(2 downto 0);
	         A, B   : in  std_logic_vector(31 downto 0);
	         Zero   : out std_logic;
	         result : out std_logic_vector(31 downto 0));
	end component ALU;
	
begin
	
end behavior;