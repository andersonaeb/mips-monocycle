----------------------------------------------------------------------------------
-- MIPS MONOCYCLE
-- Datapath 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MipsMonocycle is
	port(
        clk, reset, InstructionAddr, IMRead, IMWrite: in std_logic;
        InitAddress, WriteInstruction: signed(31 downto 0)
	);
end MipsMonocycle;

-------------------------------------------------------------------------

architecture behavior of MipsMonocycle is
	
	component Mux2To1
	    port(A, B : in  signed(31 downto 0);
	         Sel  : in  std_logic;
	         S    : out signed(31 downto 0));
	end component Mux2To1;
	
	component Mux4To1
	    port(A, B, C, D : in  signed(4 downto 0);
	         Sel        : in  signed(1 downto 0);
	         S          : out signed(4 downto 0));
	end component Mux4To1;
	
	component PC
	    port(clk, rst : in  std_logic;
	         D        : in  signed(31 downto 0);
	         Q        : out signed(31 downto 0));
	end component PC;
	
	component Control
	    port(instruction                                                           : in  signed(31 downto 26);
	         PCtoRA, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite : out std_logic;
	         RegDst, ALUOp                                                         : out signed(1 downto 0));
	end component Control;
	
	component Memory
	    port(clk, MemRead, MemWrite : in  std_logic;
	         address                : in  signed(31 downto 0);
	         read_data              : out signed(31 downto 0);
	         write_data             : in  signed(31 downto 0));
	end component Memory;
	
	component Adder
	    port(A, B   : in  signed(31 downto 0);
	         result : out signed(31 downto 0));
	end component Adder;
	
	component RegisterBank
	    port(clk, RegWrite                   : std_logic;
	         read_reg1, read_reg2, write_reg : in  signed(4 downto 0);
	         write_data                      : in  signed(31 downto 0);
	         read_data1, read_data2          : out signed(31 downto 0));
	end component RegisterBank;
	
	component Extend16To32
	    port(s_in  : in  signed(15 downto 0);
	         s_out : out signed(31 downto 0));
	end component Extend16To32;
	
	component JumpInstruction
	    port(instruction : signed(25 downto 0);
	         pc          : in  signed(31 downto 28);
	         result      : out signed(31 downto 0));
	end component JumpInstruction;
	
	component ALU_Control
	    port(ALUOp : in  signed(1 downto 0);
	         Funct : in  signed(5 downto 0);
	         op    : out signed(2 downto 0);
	         JR    : out std_logic);
	end component ALU_Control;
	
	component ALU
	    port(op     : in  signed(2 downto 0);
	         A, B   : in  signed(31 downto 0);
	         Zero   : out std_logic;
	         result : out signed(31 downto 0));
	end component ALU;
	
	-- Data signal
	signal PCOut, PCFourAdder, Instruction, InstructionLSB, BranchExtend, MuxIMOut, RD1Out, RD2Out, ALUResult, JPInstruction, BranchAdder,
	       DMRead, DMWrite, MuxALUOut, MuxBranchOut, MuxJumpOut, MuxDMOut, MuxWDOut, MuxJrOut: signed(31 downto 0);
    signal MuxWROut: signed(4 downto 0);
	       
	-- Control Signal
    signal PCtoRa, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, ALUControlJR, Zero, RegWrite, Branch: std_logic;
    signal RegDst, ALUOp: signed(1 downto 0);
    signal ALUControlOp: signed(2 downto 0);
    
    -- Number four to adder pc
    signal FourNumber: signed(31 downto 0):= "00000000000000000000000000000100";
    -- RA Register number 31
    signal RANumber: signed(4 downto 0):="11111";
    -- Null Data 
    signal NullData: signed(4 downto 0):="00000";
	
begin
    
	-- Program Instruction
	U_PC: PC port map(clk, reset, MuxJrOut, PCOut);
	U_PC_Adder: Adder port map(PCOut, FourNumber, PCFourAdder);
	
	-- Instruction Memory
	U_IM_Mux: Mux2To1 port map(PCOut, InitAddress, InstructionAddr, MuxIMOut);
	U_IM: Memory port map(clk, IMRead, IMWrite, MuxIMOut, Instruction, WriteInstruction);
	
	-- Control
    U_Control: Control port map(Instruction(31 downto 26), PCtoRA, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, RegDst, ALUOp);
    
    -- Register Bank
    U_RB_WR_Mux: Mux4To1 port map(Instruction(20 downto 16), Instruction(15 downto 11), RANumber, NullData, RegDst, MuxWROut);
    U_RB_WD_Mux: Mux2To1 port map(MuxDMOut, PCFourAdder, PCtoRA, MuxWDOut);
    U_RB: RegisterBank port map(clk, RegWrite, Instruction(25 downto 21), Instruction(20 downto 16), MuxWROut, MuxWDOut, RD1Out, RD2Out);
	
	-- Jump Instruction
	U_JumpInstruction: JumpInstruction port map(Instruction(25 downto 0), PCFourAdder(31 downto 28), JPInstruction);
	
	-- Instruction Extend
	U_InstructionExtend: Extend16To32 port map(Instruction(15 downto 0), InstructionLSB);
	
	-- Branch Modules
	Branch <= (Beq AND Zero) OR (Bne AND (NOT Zero));
	BranchExtend <= (InstructionLSB(29 downto 0) & "00");
	U_Branch_Adder: Adder port map(PCFourAdder, BranchExtend, BranchAdder);
    U_Branch_Mux: Mux2To1 port map (PCFourAdder, BranchAdder, Branch, MuxBranchOut);
	
	-- ALU
	U_ALU_Mux: Mux2To1 port map(RD2Out, InstructionLSB, ALUSrc, MuxALUOut);
	U_ALU_Control: ALU_Control port map(ALUOp, Instruction(5 downto 0), ALUControlOp, ALUControlJR);
	U_ALU: ALU port map(ALUControlOp, RD1Out, MuxALUOut, Zero, ALUResult);
	
	-- Data Memory
	U_DM: Memory port map(clk, MemRead, MemWrite, ALUResult, DMRead, RD2Out);
	U_DM_Mux: Mux2To1 port map(ALUResult, DMRead, MemtoReg, MuxDMOut);
	
	-- Jump / JR Mux
	U_Jump_Mux: Mux2To1 port map(MuxBranchOut, JPInstruction, Jump, MuxJumpOut);
	U_JR_Mux: Mux2To1 port map(MuxJumpOut, RD1Out, ALUControlJR, MuxJrOut);
	
end behavior;