library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.riscv_types.all;

package decoder_pkg is

    COMPONENT decoder is
    Port ( 
        instr_i       : in  STD_LOGIC_VECTOR (31 downto 0);
        isLoad_o      : out STD_LOGIC;  -- is load instruction ?
        isStore_o     : out STD_LOGIC;  -- is store instruction ?
        isALUreg_o    : out STD_LOGIC;  -- is using rs1 and rs2 in ALU ?
        isBranch_o    : out STD_LOGIC;  -- is branch instruction ?
        isSYSTEM_o    : out STD_LOGIC;  -- is system instruction ?
        isJAL_o       : out STD_LOGIC;  -- is JAL instruction ?
        isJALR_o      : out STD_LOGIC;  -- is JALR instruction ?
        isJALorJALR_o : out STD_LOGIC;  -- is JAL or JALR instruction ?
        isAuipc_o     : out STD_LOGIC;  -- is AUIPC instruction ?
        isLui_o       : out STD_LOGIC;  -- is LUI instruction ?
        isCustom_o    : out STD_LOGIC;  -- custom instruction (not used yet)
            
        isCSRRS_o     : out STD_LOGIC;  -- is CSRRS instruction ?
        isEBreak_o    : out STD_LOGIC;  -- is EBREAK instruction ?
            
        isByte_o      : out STD_LOGIC;  -- load or store instruction with byte access ?
        isHalf_o      : out STD_LOGIC;  -- load or store instruction with half access ?
            
        -- sign extension pour le load 
            
        funct3_o      : out STD_LOGIC_VECTOR ( 2 downto 0); -- funct3 field
        funct7_o      : out STD_LOGIC_VECTOR ( 6 downto 0); -- funct7 field
            
        csrId_o       : out STD_LOGIC_VECTOR ( 1 downto 0); -- CSR register ID
            
        rs1_o         : out STD_LOGIC_VECTOR ( 4 downto 0); -- rs1 register ID
        rs2_o         : out STD_LOGIC_VECTOR ( 4 downto 0); -- rs2 register ID
        rdId_o        : out STD_LOGIC_VECTOR ( 4 downto 0)  -- rd  register ID
    );
    END COMPONENT;

 end package;