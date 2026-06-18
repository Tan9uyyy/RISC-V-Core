library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.riscv_types.all;

entity decoder is
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
    isEBreak_o    : out STD_LOGIC;  -- is EBREAK instruction ?  OR ECALL instruction

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
end decoder;

architecture arch of decoder is

    SIGNAL opcode : STD_LOGIC_VECTOR(6 downto 0);
    SIGNAL imm12sys : STD_LOGIC_VECTOR(31 downto 20);

begin

    --On extrait les champs qui sont presque toujours à la même place en RISCV
    opcode <= instr_i(6 downto 0);
    imm12sys <= instr_i(31 downto 20);
    funct3_o <= instr_i(14 downto 12);
    funct7_o <= instr_i(31 downto 25);
    rs1_o <= instr_i(19 downto 15);
    rs2_o <= instr_i(24 downto 20);
    rdId_o <= instr_i(11 downto 7);

   
    --  To be completed
    process (opcode, funct3_o, imm12sys)
    begin

        isLoad_o   <= '0';
        isStore_o  <= '0';
        isALUreg_o <= '0';
        isBranch_o <= '0';
        isSYSTEM_o <= '0';
        isJAL_o    <= '0';
        isJALR_o   <= '0';
        isJALorJALR_o <= '0';
        isAuipc_o <= '0';
        isLui_o <= '0';
        isCustom_o <= '0';
        isCSRRS_o <= '0';
        isEBreak_o <= '0';
        isByte_o <= '0';
        isHalf_o <= '0';

        case opcode is
            when "0000011" =>
                isLoad_o <= '1';
                if (funct3_o = "000") OR (funct3_o = "100") then 
                    isByte_o <= '1';
                elsif (funct3_o = "001") OR (funct3_o = "101") then
                    isHalf_o <= '1';
                end if;

            when "0100011" =>
                isStore_o <='1';
                if (funct3_o = "000") then 
                    isByte_o <= '1';
                elsif (funct3_o = "001") then
                    isHalf_o <= '1';
                end if;

            when "0110011" =>
                isALUreg_o <='1';

            when "0010011" =>
                null;

            when "1100011" =>
                isBranch_o <='1';

            when "1110011" =>
                isSYSTEM_o <='1';
                if (imm12sys = x"001") or (imm12sys = x"000") then --RAJOUT de ECALL instruction sinon le test ne passait pas ligne 2710
                    isEBreak_o <= '1';
                end if;

            when "1101111" =>
                isJAL_o <='1';
                isJALorJALR_o <='1';

            when "1100111" =>
                isJALR_o <='1';
                isJALorJALR_o <='1';

            when "0010111" =>
                isAuipc_o <='1';
            
            when "0110111" =>
                isLui_o <='1';

            when others =>
                isCustom_o <= '1';
        
        end case;

    end process;

end arch;
 
