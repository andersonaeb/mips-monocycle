----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Datapath 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MixMonocycle is
	port(
        clk, reset, InstructionAddr, IMRead, IMWrite: in std_logic;
        InitAddress, WriteInstruction: std_logic_vector(31 downto 0)
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
	    port(A, B, C, D : in  std_logic_vector(4 downto 0);
	         Sel        : in  std_logic_vector(1 downto 0);
	         S          : out std_logic_vector(4 downto 0));
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
	
	-- Data signal
	signal PCOut, PCFourAdder, Instruction, InstructionLSB, BranchExtend, MuxIMOut, RD1Out, RD2Out, ALUResult, JPInstruction, BranchAdder,
	       DMRead, DMWrite, MuxALUOut, MuxBranchOut, MuxJumpOut, MuxDMOut, MuxWDOut, MuxJrOut: std_logic_vector(31 downto 0);
    signal MuxWROut: std_logic_vector(4 downto 0);
	       
	-- Control Signal
    signal PCtoRa, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, ALUControlJR, Zero, RegWrite, JR, Branch: std_logic;
    signal RegDst, ALUOp: std_logic_vector(1 downto 0);
    signal ALUControlOp: std_logic_vector(2 downto 0);
    
    -- Number four to adder pc
    signal FourNumber: std_logic_vector(31 downto 0):=X"00000100";
    -- RA Register number 31
    signal RANumber: std_logic_vector(4 downto 0):="11111";
    -- Null Data 
    signal NullData: std_logic_vector(4 downto 0):="00000";
	
begin
    
	-- Program Instruction
	U_PC: PC port map(clk, reset, MuxJrOut, PCOut);
	U_PC_Adder: Adder port map(PCOut, FourNumber, PCFourAdder);
	
	-- Instruction Memory
	U_IM_Mux: Mux2To1 port map(PCOut, InitAddress, InstructionAddr, MuxIMOut);
	U_IM: Memory port map(IMRead, IMWrite, MuxIMOut, Instruction, WriteInstruction);
	
	-- Control
    U_Control: Control port map(Instruction(31 downto 26), PCtoRA, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, RegDst, ALUOp);
    
    -- Register Bank
    U_RB_WR_Mux: Mux4To1 port map(Instruction(20 downto 16), Instruction(15 downto 11), RANumber, NullData, RegDst, MuxWROut);
    U_RB_WD_Mux: Mux2To1 port map(PCFourAdder, MuxDMOut, PCtoRA, MuxWDOut);
    U_RB: RegisterBank port map(RegWrite, Instruction(25 downto 21), Instruction(20 downto 16), MuxWROut, MuxWDOut, RD1Out, RD2Out);
	
	-- Jump Instruction
	U_JumpInstruction: JumpInstruction port map(Instruction(25 downto 0), PCFourAdder(31 downto 28), JPInstruction);
	
	-- Branch Modules
	Branch <= (Beq AND Zero) OR (Bne AND (NOT Zero));
	BranchExtend <= (InstructionLSB(29 downto 0) & "00");
	U_Branch_Sign: Extend16To32 port map(Instruction(15 downto 0), InstructionLSB);
	U_Branch_Adder: Adder port map(PCFourAdder, BranchExtend, BranchAdder);
    U_Branch_Mux: Mux2To1 port map (PCFourAdder, BranchAdder, Branch, MuxBranchOut);
	
	-- ALU
	U_ALU_Mux: Mux2To1 port map(RD2Out, InstructionLSB, ALUSrc, MuxALUOut);
	U_ALU_Control: ALU_Control port map(ALUOp, Instruction(5 downto 0), ALUControlOp, ALUControlJR);
	U_ALU: ALU port map(ALUControlOp, RD1Out, MuxALUOut, Zero, ALUResult);
	
	-- Data Memory
	U_DM: Memory port map(MemRead, MemWrite, ALUResult, DMRead, RD2Out);
	U_DM_Mux: Mux2To1 port map(DMRead, ALUResult, MemtoReg, MuxDMOut);
	
	-- Jump / JR Mux
	U_Jump_Mux: Mux2To1 port map(MuxBranchOut, JPInstruction, Branch, MuxJumpOut);
	U_JR_Mux: Mux2To1 port map(MuxJumpOut, RD1Out, JR, MuxJrOut);
	
end behavior;