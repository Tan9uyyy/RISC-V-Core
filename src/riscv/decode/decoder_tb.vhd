-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity decoder_tb is
end;

architecture bench of decoder_tb is

  component decoder
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

    -- sign extension pour le load 

    funct3_o      : out STD_LOGIC_VECTOR ( 2 downto 0);
    funct7_o      : out STD_LOGIC_VECTOR ( 6 downto 0);

    csrId_o       : out STD_LOGIC_VECTOR ( 1 downto 0);

    rs1_o         : out STD_LOGIC_VECTOR ( 4 downto 0);
    rs2_o         : out STD_LOGIC_VECTOR ( 4 downto 0);
    rdId_o        : out STD_LOGIC_VECTOR ( 4 downto 0)
   );
  end component;

  signal instr_i: STD_LOGIC_VECTOR (31 downto 0);
  signal isLoad_o: STD_LOGIC;
  signal isStore_o: STD_LOGIC;
  signal isALUreg_o: STD_LOGIC;
  signal isBranch_o: STD_LOGIC;
  signal isSYSTEM_o: STD_LOGIC;
  signal isJAL_o: STD_LOGIC;
  signal isJALR_o: STD_LOGIC;
  signal isJALorJALR_o: STD_LOGIC;
  signal isAuipc_o: STD_LOGIC;
  signal isLui_o: STD_LOGIC;
  signal isCustom_o: STD_LOGIC;
  signal isCSRRS_o: STD_LOGIC;
  signal isEBreak_o: STD_LOGIC;
  signal isByte_o: STD_LOGIC;
  signal isHalf_o: STD_LOGIC;
  signal funct3_o: STD_LOGIC_VECTOR ( 2 downto 0);
  signal funct7_o: STD_LOGIC_VECTOR ( 6 downto 0);
  signal csrId_o: STD_LOGIC_VECTOR ( 1 downto 0);
  signal rs1_o: STD_LOGIC_VECTOR ( 4 downto 0);
  signal rs2_o: STD_LOGIC_VECTOR ( 4 downto 0);
  signal rdId_o: STD_LOGIC_VECTOR ( 4 downto 0) ;

begin

  uut: decoder port map ( instr_i       => instr_i,
                          isLoad_o      => isLoad_o,
                          isStore_o     => isStore_o,
                          isALUreg_o    => isALUreg_o,
                          isBranch_o    => isBranch_o,
                          isSYSTEM_o    => isSYSTEM_o,
                          isJAL_o       => isJAL_o,
                          isJALR_o      => isJALR_o,
                          isJALorJALR_o => isJALorJALR_o,
                          isAuipc_o     => isAuipc_o,
                          isLui_o       => isLui_o,
                          isCustom_o    => isCustom_o,
                          isCSRRS_o     => isCSRRS_o,
                          isEBreak_o    => isEBreak_o,
                          isByte_o      => isByte_o,
                          isHalf_o      => isHalf_o,
                          funct3_o      => funct3_o,
                          funct7_o      => funct7_o,
                          csrId_o       => csrId_o,
                          rs1_o         => rs1_o,
                          rs2_o         => rs2_o,
                          rdId_o        => rdId_o );

  stimulus: process
  begin
  
    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing LUI instruction (U-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------

    instr_i <= "00000000000000000000000000110111"; -- lui x0, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '1'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for LUI instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for LUI instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for LUI instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for LUI instruction" severity error;
--  assert rs1_o         = "00000"   report "rs1_o is not '00000' for LUI instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for LUI instruction" severity error;
    assert rdId_o        = "00000"   report "rdId_o is not '00000' for LUI instruction" severity error;

    instr_i <= "00000000000000000100000010110111"; -- lui x1, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '1'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for LUI instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for LUI instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for LUI instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for LUI instruction" severity error;
--  assert rs1_o         = "00000"   report "rs1_o is not '00000' for LUI instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for LUI instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for LUI instruction" severity error;

    -- Put test bench stimulus code here
    instr_i <= "11111111111111111111111110110111"; -- lui x31, -1
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '1'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for LUI instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for LUI instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for LUI instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for LUI instruction" severity error;
--  assert rs1_o         = "00000"   report "rs1_o is not '00000' for LUI instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for LUI instruction" severity error;
    assert rdId_o        = "11111"   report "rdId_o is not '11111' for LUI instruction" severity error;


    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing ADD instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------

    instr_i <= "00000000000000000000000010110011"; -- ADD x1, x0, x0
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for ADD instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for ADD instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for ADD instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for ADD instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for ADD instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for ADD instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for ADD instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for ADD instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for ADD instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for ADD instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for ADD instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for ADD instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for ADD instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for ADD instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for ADD instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for ADD instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for ADD instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for ADD instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for ADD instruction" severity error;
    assert rs2_o         = "00000"   report "rs2_o is not '00000' for ADD instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for ADD instruction" severity error;

    instr_i <= "00000000010100010000000010110011"; -- add x1, x2, x5
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for ADD instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for ADD instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for ADD instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for ADD instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for ADD instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for ADD instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for ADD instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for ADD instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for ADD instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for ADD instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for ADD instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for ADD instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for ADD instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for ADD instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for ADD instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for ADD instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for ADD instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for ADD instruction" severity error;
    assert rs1_o         = "00010"   report "rs1_o is not '00000' for ADD instruction" severity error;
    assert rs2_o         = "00101"   report "rs2_o is not '00000' for ADD instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for ADD instruction" severity error;

    instr_i <= "00000000000101111000111110110011"; -- add x31, x15, x1
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for ADD instruction"        severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for ADD instruction"          severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for ADD instruction"         severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for ADD instruction"        severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for ADD instruction"        severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for ADD instruction"           severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for ADD instruction"          severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for ADD instruction"     severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for ADD instruction"         severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for ADD instruction"           severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for ADD instruction"        severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for ADD instruction"         severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for ADD instruction"        severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for ADD instruction"          severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for ADD instruction"          severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for ADD instruction"      severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for ADD instruction"  severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for ADD instruction"        severity error;
    assert rs1_o         = "01111"   report "rs1_o is not '00000' for ADD instruction"       severity error;
    assert rs2_o         = "00001"   report "rs2_o is not '00000' for ADD instruction"       severity error;
    assert rdId_o        = "11111"   report "rdId_o is not '00001' for ADD instruction"      severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing SUB instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------

    instr_i <= "01000000000000000000000010110011"; -- sub x1, x0, x0
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for SUB instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for SUB instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for SUB instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for SUB instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for SUB instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for SUB instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for SUB instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for SUB instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for SUB instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for SUB instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for SUB instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for SUB instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for SUB instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for SUB instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for SUB instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for SUB instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for SUB instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for SUB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SUB instruction" severity error;
    assert rs2_o         = "00000"   report "rs2_o is not '00000' for SUB instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for SUB instruction" severity error;

    instr_i <= "01000000010100010000000010110011"; -- sub x1, x2,  x5
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for SUB instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for SUB instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for SUB instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for SUB instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for SUB instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for SUB instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for SUB instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for SUB instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for SUB instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for SUB instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for SUB instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for SUB instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for SUB instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for SUB instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for SUB instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for SUB instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for SUB instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for SUB instruction" severity error;
    assert rs1_o         = "00010"   report "rs1_o is not '00000' for SUB instruction" severity error;
    assert rs2_o         = "00101"   report "rs2_o is not '00000' for SUB instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for SUB instruction" severity error;

    instr_i <= "01000000000101111000111110110011"; -- sub x31, x15, x1
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for SUB instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for SUB instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for SUB instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for SUB instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for SUB instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for SUB instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for SUB instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for SUB instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for SUB instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for SUB instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for SUB instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for SUB instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for SUB instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for SUB instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for SUB instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for SUB instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for SUB instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for SUB instruction" severity error;
    assert rs1_o         = "01111"   report "rs1_o is not '01111' for SUB instruction" severity error;
    assert rs2_o         = "00001"   report "rs2_o is not '00001' for SUB instruction" severity error;
    assert rdId_o        = "11111"   report "rdId_o is not '11111' for SUB instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing XOR instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------

    instr_i <= "00000000011000100100000110110011"; -- xor x3, x4, x6
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for XOR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for XOR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for XOR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for XOR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for XOR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for XOR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for XOR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for XOR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for XOR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for XOR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for XOR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for XOR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for XOR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for XOR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for XOR instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for XOR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for XOR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for XOR instruction" severity error;
    assert rs1_o         = "00100"   report "rs1_o is not '00100' for XOR instruction" severity error;
    assert rs2_o         = "00110"   report "rs2_o is not '00110' for XOR instruction" severity error;
    assert rdId_o        = "00011"   report "rdId_o is not '00011' for XOR instruction" severity error;

    instr_i <= "00000000111101011100001110110011"; -- xor x7, x11, x15
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for XOR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for XOR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for XOR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for XOR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for XOR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for XOR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for XOR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for XOR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for XOR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for XOR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for XOR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for XOR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for XOR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for XOR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for XOR instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for XOR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for XOR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for XOR instruction" severity error;
    assert rs1_o         = "01011"   report "rs1_o is not '01011' for XOR instruction" severity error;
    assert rs2_o         = "01111"   report "rs2_o is not '01111' for XOR instruction" severity error;
    assert rdId_o        = "00111"   report "rdId_o is not '00111' for XOR instruction" severity error;

    instr_i <= "00000001011110001100111110110011"; -- xor x31, x17, x23
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for XOR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for XOR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for XOR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for XOR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for XOR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for XOR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for XOR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for XOR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for XOR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for XOR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for XOR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for XOR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for XOR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for XOR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for XOR instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for XOR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for XOR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for XOR instruction" severity error;
    assert rs1_o         = "10001"   report "rs1_o is not '10001' for XOR instruction" severity error;
    assert rs2_o         = "10111"   report "rs2_o is not '10111' for XOR instruction" severity error;
    assert rdId_o        = "11111"   report "rdId_o is not '11111' for XOR instruction" severity error;

    
    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing OR instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------

    instr_i <= "00000001000001110110101110110011"; -- or x23, x14, x16
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01110"   report "rs1_o is not '01110' for OR instruction" severity error;
    assert rs2_o         = "10000"   report "rs2_o is not '10000' for OR instruction" severity error;
    assert rdId_o        = "10111"   report "rdId_o is not '10111' for OR instruction" severity error;

    instr_i <= "00000000010100001110110110110011"; -- or x27, x1,  x5
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for OR instruction" severity error;
    assert rs2_o         = "00101"   report "rs2_o is not '00101' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    instr_i <= "00000001010100111110101010110011"; -- or x21, x7, x21
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for OR instruction" severity error;
    assert rs2_o         = "10101"   report "rs2_o is not '10101' for OR instruction" severity error;
    assert rdId_o        = "10101"   report "rdId_o is not '10101' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Shift Left Logical instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    
    instr_i <= "00000000100100000001111100110011"; -- sll x30, x0, x9
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "01001"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11110"   report "rdId_o is not '11110' for OR instruction" severity error;

    instr_i <= "00000000100001011001011110110011"; -- sll x15, x11,  x8
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01011"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "01000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "01111"   report "rdId_o is not '11110' for OR instruction" severity error;

    instr_i <= "00000001011010011001100010110011"; -- sll x17, x19, x22
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10011"   report "rs1_o is not '10011' for OR instruction" severity error;
    assert rs2_o         = "10110"   report "rs2_o is not '10110' for OR instruction" severity error;
    assert rdId_o        = "10001"   report "rdId_o is not '10001' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Shift Right Logical instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000100100000101111100110011"; -- srl x30, x0, x9
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "01001"   report "rs2_o is not '01001' for OR instruction" severity error;
    assert rdId_o        = "11110"   report "rdId_o is not '11110' for OR instruction" severity error;

    instr_i <= "00000000100001011101011110110011"; -- srl x15, x11,  x8
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01011"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "01000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "01111"   report "rdId_o is not '11110' for OR instruction" severity error;

    instr_i <= "00000001011010011101100010110011"; -- srl x17, x19, x22
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10011"   report "rs1_o is not '10011' for OR instruction" severity error;
    assert rs2_o         = "10110"   report "rs2_o is not '10110' for OR instruction" severity error;
    assert rdId_o        = "10001"   report "rdId_o is not '10001' for OR instruction" severity error;


    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Shift Right Arith* instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "01000001110111110101101000110011"; -- sra x20, x30, x29
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '11110' for OR instruction" severity error;

    instr_i <= "01000001110010101101001010110011"; -- sra x5, x21, x28
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
    assert rs2_o         = "11100"   report "rs2_o is not '11100' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '11110' for OR instruction" severity error;
    
    instr_i <= "01000000001001001101110110110011"; -- sra x27, x9, x2
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '01001' for OR instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00010' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11110' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Set Less Than instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000001110111110010101000110011"; -- slt x20, x30, x29
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '11110' for OR instruction" severity error;
    
    instr_i <= "00000001110010101010001010110011"; -- slt x5, x21, x28
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "11100"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '11110' for OR instruction" severity error;
    
    instr_i <= "00000000001001001010110110110011"; -- slt x27, x9, x2
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '00000' for OR instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11110' for OR instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Set Less Than (U) instruction (R-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000001110111110011101000110011"; -- sltu x20, x30, x29
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for sltu instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for sltu instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for sltu instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for sltu instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for sltu instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for sltu instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for sltu instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for sltu instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for sltu instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for sltu instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for sltu instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for sltu instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for sltu instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for sltu instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for sltu instruction" severity error;
    assert funct3_o      = "011"     report "funct3_o is not '011' for sltu instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for sltu instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for sltu instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for sltu instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '11011' for sltu instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '11110' for sltu instruction" severity error;

    instr_i <= "00000001110010101011001010110011"; -- sltu x5, x21, x28
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "011"     report "funct3_o is not '011' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
    assert rs2_o         = "11100"   report "rs2_o is not '11100' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "00000000001001001011110110110011"; -- sltu x27, x9, x2
    wait for 10 ns;
    assert isALUreg_o    = '1'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "011"     report "funct3_o is not '011' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '01001' for OR instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00010' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing ADD Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110000101000010011"; -- addi x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;
    
    instr_i <= "00000000010010101000001010010011"; -- addi x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction"   severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction"  severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction"  severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "11111111110001001000110110010011"; -- addi x27, x9, -4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for OR instruction" severity error;
--  assert funct7_o      = "1111111" report "funct7_o is not '1111111' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '01001' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;
    
    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing XOR Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110100101000010011"; -- xori x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '000' for OR instruction" severity error;
--  assert funct7_o      = "1111111" report "funct7_o is not '1111111' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;
    
    instr_i <= "00000000010010101100001010010011"; -- xori x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '000' for OR instruction" severity error;
--  assert funct7_o      = "1111111" report "funct7_o is not '1111111' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;

    instr_i <= "11111111110001001100110110010011"; -- xori x27, x9, -4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '000' for OR instruction" severity error;
--  assert funct7_o      = "1111111" report "funct7_o is not '1111111' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;


    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing OR Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110110101000010011"; -- ori x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;

    instr_i <= "00000000010010101110001010010011"; -- ori x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "11111111110001001110110110010011"; -- ori x27, x9, -4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '01001' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing AND Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110111101000010011"; -- andi x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "111"     report "funct3_o is not '111' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;

    instr_i <= "00000000010010101111001010010011"; -- andi x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "111"     report "funct3_o is not '111' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "11111111110001001111110110010011"; -- andi x27, x9, -4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "111"     report "funct3_o is not '111' for OR instruction" severity error;
--  assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Shift Left Logical Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110001101000010011"; -- slli x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;
    
    instr_i <= "00000000010010101001001010010011"; -- slli x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "00000001111101001001110110010011"; -- slli x27, x9, 31
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Shift Right Logical Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110101101000010011"; -- srli x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;
    
    instr_i <= "00000000010010101101001010010011"; -- srli x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "00000001111101001101110110010011"; -- srli x27, x9, 31
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Shift Right Arith Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "01000000000011110101101000010011"; -- srai x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;

    instr_i <= "01000000010010101101001010010011"; -- srai x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "01000001111101001101110110010011"; -- srai x27, x9, 31
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for OR instruction" severity error;
    assert funct7_o      = "0100000" report "funct7_o is not '0100000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Set Less Than Arith Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110010101000010011"; -- slti x20, x30, 0
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for OR instruction" severity error;
    
    instr_i <= "00000000010010101010001010010011"; -- slti x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for OR instruction" severity error;
    
    instr_i <= "00000001111101001010110110010011"; -- slti x27, x9, 31
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for OR instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for OR instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for OR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for OR instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for OR instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for OR instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for OR instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for OR instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for OR instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for OR instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for OR instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for OR instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for OR instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for OR instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for OR instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for OR instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for OR instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for OR instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for OR instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for OR instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for OR instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    --
    -- Testing Set Less Than (U) Arith Immediate instruction (I-type)
    --
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000011110011101000010011"; -- sltiu x20, x30, 0
    wait for 10 ns;
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for sltiu instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for sltiu instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for sltiu instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for sltiu instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for sltiu instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for sltiu instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for sltiu instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for sltiu instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for sltiu instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for sltiu instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for sltiu instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for sltiu instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for sltiu instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for sltiu instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for sltiu instruction" severity error;
    assert funct3_o      = "011"     report "funct3_o is not '011' for sltiu instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for sltiu instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for sltiu instruction" severity error;
    assert rs1_o         = "11110"   report "rs1_o is not '11110' for sltiu instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for sltiu instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for sltiu instruction" severity error;
    
    instr_i <= "00000000010010101011001010010011"; -- sltiu x5, x21, 4
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for sltiu instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for sltiu instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for sltiu instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for sltiu instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for sltiu instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for sltiu instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for sltiu instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for sltiu instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for sltiu instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for sltiu instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for sltiu instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for sltiu instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for sltiu instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for sltiu instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for sltiu instruction" severity error;
    assert funct3_o      = "011"     report "funct3_o is not '011' for sltiu instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for sltiu instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for sltiu instruction" severity error;
    assert rs1_o         = "10101"   report "rs1_o is not '10101' for sltiu instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for sltiu instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for sltiu instruction" severity error;
    
    instr_i <= "00000001111101001011110110010011"; -- sltiu x27, x9, 31
    wait for 10 ns;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '1' for sltiu instruction" severity error;
    assert isLoad_o      = '0'       report "Load_o is not '0' for sltiu instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for sltiu instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for sltiu instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for sltiu instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for sltiu instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for sltiu instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for sltiu instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for sltiu instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '0' for sltiu instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for sltiu instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for sltiu instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for sltiu instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for sltiu instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for sltiu instruction" severity error;
    assert funct3_o      = "011"     report "funct3_o is not '011' for sltiu instruction" severity error;
    assert funct7_o      = "0000000" report "funct7_o is not '0000000' for sltiu instruction" severity error;
--  assert csrId_o       = "00"      report "csrId_o is not '00' for sltiu instruction" severity error;
    assert rs1_o         = "01001"   report "rs1_o is not '10101' for sltiu instruction" severity error;
--  assert rs2_o         = "00000"   report "rs2_o is not '00000' for sltiu instruction" severity error;
    assert rdId_o        = "11011"   report "rdId_o is not '11011' for sltiu instruction" severity error;
    ---------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Load Byte instruction (I-type)
    -- Testing Load Byte instruction (I-type)
    --
    ---------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000000000000010000011"; -- lb x1, 0(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LB instruction" severity error;    
    assert isByte_o      = '1'       report "Byte_o is not '1' for LB instruction" severity error;instr_i <= "00000000010000000000001010000011"; -- lb x5, 4(x0)
    assert isHalf_o      = '0'       report "Half_o is not '0' for LB instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for LB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LB instruction" severity error;instr_i <= "11111111110000000000001110000011"; -- lb x7, -4(x0)
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for LB instruction" severity error;

    instr_i <= "00000000010000000000001010000011"; -- lb x5, 4(x0)---------------------------------------------------------------------------------------------------------
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LB instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for LB instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LB instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for LB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LB instruction" severity error;-------------------------------------------------------------------------------------------------------
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for LB instruction" severity error;

    instr_i <= "11111111110000000000001110000011"; -- lb x7, -4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LB instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for LB instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LB instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for LB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LB instruction" severity error;
    assert rdId_o        = "00111"   report "rdId_o is not '00111' for LB instruction" severity error;    ---------------------------------------------------------------------------------------------------------

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Load Half Immediate instruction (I-type)
    --
    ---------------------------------------------------------------------------------------------------------

    instr_i <= "00000000000000000001000010000011"; -- lh x1, 0(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LH instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LH instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '1' for LH instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for LH instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LH instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for LH instruction" severity error;
    
    instr_i <= "00000000010000000001001010000011"; -- lh x5, 4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LH instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LH instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '1' for LH instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for LH instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LH instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for LH instruction" severity error;
    
    instr_i <= "11111111110000000001001110000011"; -- lh x7, -4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LH instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LH instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '1' for LH instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for LH instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LH instruction" severity error;
    assert rdId_o        = "00111"   report "rdId_o is not '00111' for LH instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Load Word Immediate instruction (I-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000000010000010000011"; -- lw x1, 0(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LW instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LW instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for LW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LW instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for LW instruction" severity error;
    
    instr_i <= "00000000010000000010001010000011"; -- lw x5, 4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LW instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for LW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LW instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for LW instruction" severity error;
    
    instr_i <= "11111111110000000010001110000011"; -- lw x7, -4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LW instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '010' for LW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LW instruction" severity error;
    assert rdId_o        = "00111"   report "rdId_o is not '00111' for LW instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Load Byte (U) Immediate instruction (I-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000000100000010000011"; -- lbu x1, 0(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LBU instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for LBU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LBU instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for LBU instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LBU instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for LBU instruction" severity error;
    
    instr_i <= "00000000010000000100001010000011"; -- lbu x5, 4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LBU instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for LBU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LBU instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for LBU instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LBU instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for LBU instruction" severity error;
    
    instr_i <= "11111111110000000100001110000011"; -- lbu x7, -4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LBU instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for LBU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for LBU instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for LBU instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LBU instruction" severity error;
    assert rdId_o        = "00111"   report "rdId_o is not '00111' for LBU instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Load Half (U) Immediate instruction (I-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000000101000010000011"; -- lhu x1, 0(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LHU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LHU instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '1' for LHU instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for LHU instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LHU instruction" severity error;
    assert rdId_o        = "00001"   report "rdId_o is not '00001' for LHU instruction" severity error;

    instr_i <= "00000000010000000101001010000011"; -- lhu x5, 4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LHU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LHU instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '1' for LHU instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for LHU instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LHU instruction" severity error;
    assert rdId_o        = "00101"   report "rdId_o is not '00101' for LHU instruction" severity error;

    instr_i <= "11111111110000000101001110000011"; -- lhu x7, -4(x0)
    wait for 10 ns;
    assert isLoad_o      = '1'       report "Load_o is not '1' for LHU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for LHU instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '1' for LHU instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for LHU instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for LHU instruction" severity error;
    assert rdId_o        = "00111"   report "rdId_o is not '00111' for LHU instruction" severity error;
     

--    assert isLoad_o      = '0'       report "Load_o is not '0' for LUI instruction" severity error;
--    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
--    assert isStore_o     = '0'       report "Store_o is not '0' for LUI instruction" severity error;
--    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
--    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
--    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
--    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
--    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
--    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
--    assert isLui_o       = '1'       report "Lui_o is not '1' for LUI instruction" severity error;
--    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
--    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
--    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Store Byte instruction (S-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000100000000000000100011"; -- sb x1, 0(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SB instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for SB instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for SB instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for SB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SB instruction" severity error;
    assert rs2_o         = "00001"   report "rs2_o is not '00001' for SB instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000000010100000000001000100011"; -- sb x5, 4(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SB instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for SB instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for SB instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for SB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SB instruction" severity error;
    assert rs2_o         = "00101"   report "rs2_o is not '00101' for SB instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111110011100000000111000100011"; -- sb x7, -4(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SB instruction" severity error;
    assert isByte_o      = '1'       report "Byte_o is not '1' for SB instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for SB instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for SB instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SB instruction" severity error;
    assert rs2_o         = "00111"   report "rs2_o is not '00111' for SB instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Store Half instruction (S-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000100000001000000100011"; -- sh x1, 0(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for SW instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '0' for SW instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for SW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SW instruction" severity error;
    assert rs2_o         = "00001"    report "rs2_o is not '00001' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000000010100000001001000100011"; -- sh x5, 4(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for SW instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '0' for SW instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for SW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SW instruction" severity error;
    assert rs2_o         = "00101"    report "rs2_o is not '00101' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111110011100000001111000100011"; -- sh x7, -4(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for SW instruction" severity error;
    assert isHalf_o      = '1'       report "Half_o is not '0' for SW instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for SW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SW instruction" severity error;
    assert rs2_o         = "00111"    report "rs2_o is not '00111' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Store Word instruction (S-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000100000010000000100011"; -- sw x1, 0(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for SW instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for SW instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '001' for SW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SW instruction" severity error;
    assert rs2_o         = "00001"    report "rs2_o is not '00001' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000000010100000010001000100011"; -- sw x5, 4(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for SW instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for SW instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '001' for SW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SW instruction" severity error;
    assert rs2_o         = "00101"    report "rs2_o is not '00101' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111110011100000010111000100011"; -- sw x7, -4(x0)
    wait for 10 ns;
    assert isStore_o     = '1'       report "Store_o is not '1' for SW instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for SW instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for SW instruction" severity error;
    assert funct3_o      = "010"     report "funct3_o is not '001' for SW instruction" severity error;
    assert rs1_o         = "00000"   report "rs1_o is not '00000' for SW instruction" severity error;
    assert rs2_o         = "00111"    report "rs2_o is not '00111' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Branch == instruction (B-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000001000001000001001100011"; -- beq x1, x2,  4
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BEQ instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BEQ instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BEQ instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for BEQ instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for BEQ instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00010' for BEQ instruction" severity error;

    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000111110111011000001001100011"; -- beq x27, x29, 100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BEQ instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BEQ instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BEQ instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for BEQ instruction" severity error;
    assert rs1_o         = "11011"   report "rs1_o is not '11011' for BEQ instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '11101' for BEQ instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001001100111000111011100011"; -- beq x7, x19, -100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BEQ instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BEQ instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BEQ instruction" severity error;
    assert funct3_o      = "000"     report "funct3_o is not '000' for BEQ instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for BEQ instruction" severity error;
    assert rs2_o         = "10011"   report "rs2_o is not '10011' for BEQ instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Branch != instruction (B-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000001000001001001001100011"; -- bne x1, x2,  4
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BNE instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BNE instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BNE instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for BNE instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for BNE instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00010' for BNE instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000111110111011001001001100011"; -- bne x27, x29, 100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BNE instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BNE instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BNE instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for BNE instruction" severity error;
    assert rs1_o         = "11011"   report "rs1_o is not '11011' for BNE instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '11101' for BNE instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001001100111001111011100011"; -- bne x7, x19, -100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BNE instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BNE instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BNE instruction" severity error;
    assert funct3_o      = "001"     report "funct3_o is not '001' for BNE instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for BNE instruction" severity error;
    assert rs2_o         = "10011"   report "rs2_o is not '10011' for BNE instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Branch < instruction (B-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000001000001100001001100011"; -- blt x1, x2,  4
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BLT instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BLT instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BLT instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for BLT instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for BLT instruction" severity error;
    assert rs2_o         = "00010"   report "rdId_o is not '00010' for BLT instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000111110111011100001001100011"; -- blt x27, x29, 100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BLT instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BLT instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BLT instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for BLT instruction" severity error;
    assert rs1_o         = "11011"   report "rs1_o is not '11011' for BLT instruction" severity error;
    assert rs2_o         = "11101"   report "rdId_o is not '11101' for BLT instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001001100111100111011100011"; -- blt x7, x19, -100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BLT instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BLT instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BLT instruction" severity error;
    assert funct3_o      = "100"     report "funct3_o is not '100' for BLT instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for BLT instruction" severity error;
    assert rs2_o         = "10011"   report "rdId_o is not '10011' for BLT instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Branch ≥ instruction (B-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000001000001101001001100011"; -- bge x1, x2,  4
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BGE instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BGE instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BGE instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for BGE instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for BGE instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00010' for BGE instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000111110111011101001001100011"; -- bge x27, x29, 100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BGE instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BGE instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BGE instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for BGE instruction" severity error;
    assert rs1_o         = "11011"   report "rs1_o is not '11011' for BGE instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '11101' for BGE instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001001100111101111011100011"; -- bge x7, x19, -100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BGE instruction" severity error;
--  assert isByte_o      = '0'       report "Byte_o is not '0' for BGE instruction" severity error;
--  assert isHalf_o      = '0'       report "Half_o is not '0' for BGE instruction" severity error;
    assert funct3_o      = "101"     report "funct3_o is not '101' for BGE instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for BGE instruction" severity error;
    assert rs2_o         = "10011"   report "rs2_o is not '10011' for BGE instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Branch < (U) instruction (B-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000001000001110001001100011"; -- bltu x1, x2,  4
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BLTU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for BLTU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for BLTU instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for BLTU instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for BLTU instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00010' for BLTU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000111110111011110001001100011"; -- bltu x27, x29, 100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BLTU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for BLTU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for BLTU instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for BLTU instruction" severity error;
    assert rs1_o         = "11011"   report "rs1_o is not '11011' for BLTU instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '11101' for BLTU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001001100111110111011100011"; -- bltu x7, x19, -100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BLTU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for BLTU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for BLTU instruction" severity error;
    assert funct3_o      = "110"     report "funct3_o is not '110' for BLTU instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for BLTU instruction" severity error;
    assert rs2_o         = "10011"   report "rs2_o is not '10011' for BLTU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
     
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Branch ≥ (U) instruction (B-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000001000001111001001100011"; -- bgeu x1, x2,  4
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for BGEU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for BGEU instruction" severity error;
    assert funct3_o      = "111"     report "funct3_o is not '111' for BGEU instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00001' for BGEU instruction" severity error;
    assert rs2_o         = "00010"   report "rs2_o is not '00001' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000111110111011111001001100011"; -- bgeu x27, x29, 100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for BGEU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for BGEU instruction" severity error;
    assert funct3_o      = "111"     report "funct3_o is not '111' for BGEU instruction" severity error;
    assert rs1_o         = "11011"   report "rs1_o is not '11011' for BGEU instruction" severity error;
    assert rs2_o         = "11101"   report "rs2_o is not '11101' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001001100111111111011100011"; -- bgeu x7, x19, -100
    wait for 10 ns;
    assert isBranch_o    = '1'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isByte_o      = '0'       report "Byte_o is not '0' for BGEU instruction" severity error;
    assert isHalf_o      = '0'       report "Half_o is not '0' for BGEU instruction" severity error;
    assert funct3_o      = "111"     report "funct3_o is not '111' for BGEU instruction" severity error;
    assert rs1_o         = "00111"   report "rs1_o is not '00111' for BGEU instruction" severity error;
    assert rs2_o         = "10011"   report "rs2_o is not '10011' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isJAL_o       = '0'       report "JAL_o is not '0' for LUI instruction" severity error;
    assert isJALR_o      = '0'       report "JALR_o is not '0' for LUI instruction" severity error;
    assert isJALorJALR_o = '0'       report "JALorJALR_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Jump And Link instruction (J-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000010000000000000001101111"; -- jal x0, 4
    wait for 10 ns;
    assert isJAL_o       = '1'      report "Jump_o is not '1' for JAL instruction" severity error;
    assert isJALR_o      = '0'      report "JumpReg_o is not '0' for JAL instruction" severity error;
    assert isJALorJALR_o = '1'      report "JALorJALR_o is not '0' for LUI instruction" severity error;
--  assert funct3_o     = "000"     report "funct3_o is not '000' for JAL instruction" severity error;
--  assert rs1_o        = "00000"   report "rs1_o is not '00000' for JAL instruction" severity error;
    assert rdId_o       = "00000"   report "rdId_o is not '00001' for JAL instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000110010000000000010101101111"; -- jal x10, 100
    wait for 10 ns;
    assert isJAL_o       = '1'       report "Jump_o is not '1' for JAL instruction" severity error;
    assert isJALR_o      = '0'       report "JumpReg_o is not '0' for JAL instruction" severity error;
    assert isJALorJALR_o = '1'      report "JALorJALR_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for JAL instruction" severity error;
--  assert rs1_o         = "00000"   report "rs1_o is not '00000' for JAL instruction" severity error;
    assert rdId_o        = "01010"   report "rdId_o is not '01010' for JAL instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001110111111111101001101111"; -- jal x20, -100
    wait for 10 ns;
    assert isJAL_o       = '1'       report "Jump_o is not '1' for JAL instruction" severity error;
    assert isJALR_o      = '0'       report "JumpReg_o is not '0' for JAL instruction" severity error;
    assert isJALorJALR_o = '1'      report "JALorJALR_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for JAL instruction" severity error;
--  assert rs1_o         = "00000"   report "rs1_o is not '00000' for JAL instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '10100' for JAL instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Jump And Link Reg instruction (I-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000001000101001100111"; -- jalr x20, 0(x1)
    wait for 10 ns;
    assert isJAL_o       = '0'       report "Jump_o is not '1' for JALR instruction" severity error;
    assert isJALR_o      = '1'       report "JumpReg_o is not '1' for JALR instruction" severity error;
    assert isJALorJALR_o = '1'      report "JALorJALR_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for JALR instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00000' for JALR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '00110' for JALR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "00000110010000001000101001100111"; -- jalr x20, 100(x1)
    wait for 10 ns;
    assert isJAL_o       = '0'       report "Jump_o is not '1' for JALR instruction" severity error;
    assert isJALR_o      = '1'       report "JumpReg_o is not '1' for JALR instruction" severity error;
    assert isJALorJALR_o = '1'      report "JALorJALR_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for JALR instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00000' for JALR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '00110' for JALR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;

    instr_i <= "11111001110000001000101001100111"; -- jalr x20, -100(x1)
    wait for 10 ns;
    assert isJAL_o       = '0'       report "Jump_o is not '1' for JALR instruction" severity error;
    assert isJALR_o      = '1'       report "JumpReg_o is not '1' for JALR instruction" severity error;
    assert isJALorJALR_o = '1'      report "JALorJALR_o is not '0' for LUI instruction" severity error;
--  assert funct3_o      = "000"     report "funct3_o is not '000' for JALR instruction" severity error;
    assert rs1_o         = "00001"   report "rs1_o is not '00000' for JALR instruction" severity error;
    assert rdId_o        = "10100"   report "rdId_o is not '00110' for JALR instruction" severity error;
    assert isBranch_o    = '0'       report "Branch_o is not '1' for BGEU instruction" severity error;
    assert isStore_o     = '0'       report "Store_o is not '1' for SW instruction" severity error;
    assert isALUreg_o    = '0'       report "ALUreg_o is not '0' for LUI instruction" severity error;
    assert isSYSTEM_o    = '0'       report "SYSTEM_o is not '0' for LUI instruction" severity error;
    assert isAuipc_o     = '0'       report "Auipc_o is not '0' for LUI instruction" severity error;
    assert isLui_o       = '0'       report "Lui_o is not '1' for LUI instruction" severity error;
    assert isCustom_o    = '0'       report "Custom_o is not '0' for LUI instruction" severity error;
    assert isCSRRS_o     = '0'       report "CSRRS_o is not '0' for LUI instruction" severity error;
    assert isEBreak_o    = '0'       report "EBreak_o is not '0' for LUI instruction" severity error;
    
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Add Upper Imm to PC instruction (U-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000000000010110010111"; -- auipc x11, 0
    wait for 10 ns;
    assert isAuipc_o    = '1'       report "AddUpper_o is not '1' for AUIPC instruction" severity error;
    assert isJALR_o     = '0'       report "JumpReg_o is not '0' for AUIPC instruction" severity error;
--  assert funct3_o     = "000"     report "funct3_o is not '000' for AUIPC instruction" severity error;
--  assert rs1_o        = "00000"   report "rs1_o is not '00000' for AUIPC instruction" severity error;
    assert rdId_o       = "01011"   report "rdId_o is not '01011' for AUIPC instruction" severity error;

    instr_i <= "00000000000000000001011000010111"; -- auipc x12, 1
    wait for 10 ns;
    assert isAuipc_o    = '1'       report "AddUpper_o is not '1' for AUIPC instruction" severity error;
    assert isJALR_o     = '0'       report "JumpReg_o is not '0' for AUIPC instruction" severity error;
--  assert funct3_o     = "000"     report "funct3_o is not '000' for AUIPC instruction" severity error;
--  assert rs1_o        = "00000"   report "rs1_o is not '00000' for AUIPC instruction" severity error;
    assert rdId_o       = "01100"   report "rdId_o is not '01100' for AUIPC instruction" severity error;

    instr_i <= "11111111111111111111011010010111"; -- auipc x13, -1
    wait for 10 ns;
    assert isAuipc_o    = '1'       report "AddUpper_o is not '1' for AUIPC instruction" severity error;
    assert isJALR_o     = '0'       report "JumpReg_o is not '0' for AUIPC instruction" severity error;
--  assert funct3_o     = "000"     report "funct3_o is not '000' for AUIPC instruction" severity error;
--  assert rs1_o        = "00000"   report "rs1_o is not '00000' for AUIPC instruction" severity error;
    assert rdId_o       = "01101"   report "rdId_o is not '01101' for AUIPC instruction" severity error;
    
    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Environment Call (I-type) 
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000000000000000001110011"; -- ecallu
    wait for 10 ns;
    assert isEBreak_o   = '1'       report "EnvCall_o is not '1' for ECALL instruction" severity error;
    assert isJALR_o     = '0'       report "JumpReg_o is not '0' for ECALL instruction" severity error;
    assert funct3_o     = "000"     report "funct3_o is not '000' for ECALL instruction" severity error;
    assert funct7_o     = "0000000" report "funct7_o is not '0000000' for ECALL instruction" severity error;
    assert rs1_o        = "00000"   report "rs1_o is not '00000' for ECALL instruction" severity error;
    assert rs2_o        = "00000"   report "rs1_o is not '00000' for ECALL instruction" severity error;
    assert rdId_o       = "00000"   report "rdId_o is not '00000' for ECALL instruction" severity error;

    ---------------------------------------------------------------------------------------------------------
    --
    -- Testing Environment Break (I-type)
    --
    ---------------------------------------------------------------------------------------------------------
    instr_i <= "00000000000100000000000001110011"; -- ebreak
    wait for 10 ns;
    assert isEBreak_o   = '1'       report "EnvBreak_o is not '1' for EBREAK instruction" severity error;
    assert isJALR_o     = '0'       report "JumpReg_o is not '0' for EBREAK instruction" severity error;
    assert funct3_o     = "000"     report "funct3_o is not '000' for EBREAK instruction" severity error;
    assert funct7_o     = "0000000" report "funct7_o is not '0000000' for EBREAK instruction" severity error;
    assert rs1_o        = "00000"   report "rs1_o is not '00000' for EBREAK instruction" severity error;
    assert rs2_o        = "00001"   report "rs1_o is not '00001' for EBREAK instruction" severity error;
    assert rdId_o       = "00000"   report "rdId_o is not '00000' for EBREAK instruction" severity error;   

--    mul 
--    mulh 
--    mulsu
--    mulu
--    div
--    divu
--    rem
--    remu

    wait;
  end process;


end;

