library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.riscv_types.all;

entity decoder_5stg is
Port ( 
    instr_i       : in  STD_LOGIC_VECTOR (31 downto 0);
    isLoad_o      : out STD_LOGIC;
    isStore_o     : out STD_LOGIC;
    isALUreg_o    : out STD_LOGIC;
    isBranch_o    : out STD_LOGIC;
    isSYSTEM_o    : out STD_LOGIC;
    isJAL_o       : out STD_LOGIC;
    isJALR_o      : out STD_LOGIC;
    isJALorJALR_o : out STD_LOGIC;
    isAuipc_o     : out STD_LOGIC;
    isLui_o       : out STD_LOGIC;
    isCustom_o    : out STD_LOGIC; -- custom instruction

    isCSRRS_o     : out STD_LOGIC;
    isEBreak_o    : out STD_LOGIC;

    isByte_o      : out STD_LOGIC;
    isHalf_o      : out STD_LOGIC;

    isRV32M_o     : out STD_LOGIC;
    isMUL_o       : out STD_LOGIC;
    isDIV_o       : out STD_LOGIC;

    -- sign extension pour le load 

    funct3_o      : out STD_LOGIC_VECTOR ( 2 downto 0);
    funct7_o      : out STD_LOGIC_VECTOR ( 6 downto 0);

    csrId_o       : out STD_LOGIC_VECTOR ( 1 downto 0);

    rs1_o         : out STD_LOGIC_VECTOR ( 4 downto 0);
    isRs1Used_o   : out STD_LOGIC;
    rs2_o         : out STD_LOGIC_VECTOR ( 4 downto 0);
    isRs2Used_o   : out STD_LOGIC;
    rdId_o        : out STD_LOGIC_VECTOR ( 4 downto 0)
 );
end decoder_5stg;

architecture arch of decoder_5stg is

    SIGNAL opcode   : STD_LOGIC_VECTOR(6 downto 0);
    SIGNAL imm12sys : STD_LOGIC_VECTOR(31 downto 20);
    SIGNAL funct3   : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL funct7   : STD_LOGIC_VECTOR(6 downto 0);

begin

    -- Extraction des champs classiques RISC-V
    opcode   <= instr_i(6 downto 0);
    imm12sys <= instr_i(31 downto 20);
    funct3   <= instr_i(14 downto 12);
    funct7   <= instr_i(31 downto 25);
    
    funct3_o <= funct3;
    funct7_o <= funct7;
    
    rs1_o    <= instr_i(19 downto 15);
    rs2_o    <= instr_i(24 downto 20);
    rdId_o   <= instr_i(11 downto 7);
    csrId_o  <= instr_i(21 downto 20);

    process (opcode, funct3, funct7, imm12sys)
    begin
        isLoad_o      <= '0';
        isStore_o     <= '0';
        isALUreg_o    <= '0';
        isBranch_o    <= '0';
        isSYSTEM_o    <= '0';
        isJAL_o       <= '0';
        isJALR_o      <= '0';
        isJALorJALR_o <= '0';
        isAuipc_o     <= '0';
        isLui_o       <= '0';
        isCustom_o    <= '0';
        isCSRRS_o     <= '0';
        isEBreak_o    <= '0';
        isByte_o      <= '0';
        isHalf_o      <= '0';

        isRs1Used_o   <= '0';
        isRs2Used_o   <= '0';

        isRV32M_o     <= '0';
        isMUL_o       <= '0';
        isDIV_o       <= '0';

        case opcode is
            when "0000011" => -- LOAD
                isLoad_o <= '1';
                isRs1Used_o <= '1';
                if (funct3 = "000") OR (funct3 = "100") then 
                    isByte_o <= '1';
                elsif (funct3 = "001") OR (funct3 = "101") then
                    isHalf_o <= '1';
                end if;

            when "0100011" => -- STORE
                isStore_o <= '1';
                isRs1Used_o <= '1';
                isRs2Used_o <= '1';
                if (funct3 = "000") then 
                    isByte_o <= '1';
                elsif (funct3 = "001") then
                    isHalf_o <= '1';
                end if;

            when "0110011" => -- ALUreg
                isALUreg_o <= '1';
                isRs1Used_o <= '1';
                isRs2Used_o <= '1';
                
                -- Detection extension M
                if funct7 = "0000001" then
                    isRV32M_o <= '1';
                    if funct3(2) = '0' then
                        isMUL_o <= '1';
                    else
                        isDIV_o <= '1';
                    end if;
                end if;

            when "0010011" => -- ALUimm
                isRs1Used_o <= '1';

            when "1100011" => -- Branch
                isBranch_o <= '1';
                isRs1Used_o <= '1';
                isRs2Used_o <= '1';

            when "1110011" => -- SYSTEM
                isSYSTEM_o <= '1';
                isRs1Used_o <= '1';
                if (imm12sys = x"001") or (imm12sys = x"000") then
                    isEBreak_o <= '1';
                end if;

            when "1101111" => -- JAL
                isJAL_o <= '1';
                isJALorJALR_o <= '1';

            when "1100111" => -- JALR
                isJALR_o <= '1';
                isJALorJALR_o <= '1';
                isRs1Used_o <= '1';

            when "0010111" => -- AUIPC
                isAuipc_o <= '1';
            
            when "0110111" => -- LUI
                isLui_o <= '1';

            when others =>
                isCustom_o <= '1';
        
        end case;

    end process;

end arch;
 
