library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Package Declaration Section
package riscv_types is

 type TYPE_INSTR is (R_type, I_TYPE, S_TYPE, B_TYPE, U_TYPE, J_TYPE);

 type TYPE_OPR is (
    ADD_r,     SUB_r, XOR_r, OR_r, AND_r, SLL_r, SRL_r, SRA_r, LT_r, LTu_r,
    ADD_i,     SUB_i, XOR_i, OR_i, AND_i, SLL_i, SRL_i, SRA_i, LT_i, LTu_i,
    LOAD_b,    LOAD_h, LOAD_w, LOADu_b, LOADu_h, STORE_b, STORE_h, STORE_w,
    BRANCH_EQ, BRANCH_NEQ, BRANCH_LT, BRANCH_GEQ, BRANCHu_LT, BRANCHu_GEQ,
    JAL,       JALR, LUI, AUIPC, ECALL, EBREAK,
    MUL_r,     MULH_r, MULSu_r, MULu_r, DIV_r, DIVU_r, REM_r, REMU_r 
    );

 type TYPE_REG is (
    x0_zero,    x1_ra,      x2_sp,      x3_gp,
    x4_tp,      x5_t0,      x6_t1,      x7_t2,
    x8_s0,      x9_s1,      x10_a0,     x11_a1,
    x12_a2,     x13_a3,     x14_a4,     x15_a5,
    x16_a6,     x17_a7,     x18_s2,     x19_s3,
    x20_s4,     x21_s5,     x22_s6,     x23_s7,
    x24_s8,     x25_s9,     x26_s10,    x27_s11,
    x28_t3,     x29_t4,     x30_t5,     x31_t6
  );


    function instr_is_jal    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_jalr   ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_lui    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_auipc  ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_branch ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_alu_reg( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_alu_imm( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    
    function instr_is_load   ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_store  ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_system ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_ebreak ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    function instr_is_csrrs  ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;

    function instr_is_m_ext  ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;

    function instr_is_custom ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;
    
    function instr_funct3    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;
    function instr_funct7    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;
    function instr_opcode    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;

    function funct7_is_SRA   ( FUNC7: STD_LOGIC_VECTOR( 6 DOWNTO 0) ) return std_logic;
    function funct7_is_SUB   ( FUNC7: STD_LOGIC_VECTOR( 6 DOWNTO 0) ) return std_logic;

    function funct3_is_word  ( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic;
    function funct3_is_half  ( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic;
    function funct3_is_byte  ( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic;
    function funct3_is_zero_ext( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic;
    function funct3_is_sign_ext( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic;


    --
    ------------------------------------------------------------------------------------
    --

    function instr_alu_ress( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic;

    --
    ------------------------------------------------------------------------------------
    --

    function instr_rs1_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;
    function instr_rs2_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;
    function instr_rd_id ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;
    function instr_csr_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR;


    --
    ------------------------------------------------------------------------------------
    --


--  type t_decoder is record
--    instr    : STD_LOGIC_VECTOR (31 downto 0);
--    pc_value : STD_LOGIC_VECTOR (31 downto 0);

--    opcode   : STD_LOGIC_VECTOR ( 6 downto 0);
--    func3    : STD_LOGIC_VECTOR ( 2 downto 0);
--    func7    : STD_LOGIC_VECTOR ( 6 downto 0);
    
--    rs1_id   : STD_LOGIC_VECTOR ( 4 downto 0);
--    rs2_id   : STD_LOGIC_VECTOR ( 4 downto 0);
--    rd_id    : STD_LOGIC_VECTOR ( 4 downto 0);
--    csr_id   : STD_LOGIC_VECTOR ( 1 downto 0);
    
--    isALUregInstr           : STD_LOGIC;    -- 2nd operande = rs2
--    isALUimmInstr           : STD_LOGIC;    -- 2nd operande = imm
--    isLoadInstr             : STD_LOGIC;
--    isStoreInstr            : STD_LOGIC;
--    isBranchInstr           : STD_LOGIC;
--    isJALInstr              : STD_LOGIC;
--    isJALRInstr             : STD_LOGIC;
--    isLUIInstr              : STD_LOGIC;
--    isAUIPCInstr            : STD_LOGIC;
--    isSystemInstr           : STD_LOGIC;

--    isCSRRS                 : STD_LOGIC;
--    isEBREAK                : STD_LOGIC;
--    isJALorJALRorLUIorAUIPC : STD_LOGIC;
--    isJALorJALR             : STD_LOGIC;

--    isAluSubstraction       : STD_LOGIC;

--    isByteInstr             : STD_LOGIC;
--    isHalfInstr             : STD_LOGIC;
  
--  end record;


    function stdlv_add_s32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: STD_LOGIC_VECTOR(31 downto 0)
        )
        return STD_LOGIC_VECTOR;

    function stdlv_add_s32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: integer
        )
        return STD_LOGIC_VECTOR;
        
    function stdlv_add_u32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: STD_LOGIC_VECTOR(31 downto 0)
        )
        return STD_LOGIC_VECTOR;

    function stdlv_add_u32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: integer
        )
        return STD_LOGIC_VECTOR;

    function stdlv_add_u64(
            A: STD_LOGIC_VECTOR(63 downto 0);
            B: integer
        )
        return STD_LOGIC_VECTOR;

    --
    ------------------------------------------------------------------------------------
    --

    function repeat_bit(B: std_logic; N: natural) return std_logic_vector;

    function to_stdl(L: BOOLEAN) return std_ulogic;

    --
    ------------------------------------------------------------------------------------
    --

end package riscv_types;

--
--
-- Package Body Section
--
--

package body riscv_types is

    function instr_is_jal( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "11011" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_jalr( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "11001" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_lui( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "01101" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_auipc( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "00101" then
            return '1';
        else
            return '0';
        end if;
    end;
    
    function instr_is_branch( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "11000" then
            return '1';
        else
            return '0';
        end if;
    end;
    
    function instr_is_alu_reg( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "01100" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_alu_imm( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "00100" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_load( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "00000" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_store( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "01000" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_system( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "11100" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_ebreak( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if (INSTR(14 downto 12) = "000") and (instr_is_system(INSTR) = '1') then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_csrrs( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if (INSTR(14 downto 12) = "010") and (instr_is_system(INSTR) = '1') then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_custom( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "01011" then
            return '1';
        else
            return '0';
        end if;
    end;
    
    function instr_is_m_ext( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "01100" then
            return '1';
        else
            return '0';
        end if;
    end;
        
    --
    ------------------------------------------------------------------------------------
    --

    function instr_funct3    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR is
    begin
        return INSTR(14 downto 12);
    end;

    function instr_funct7    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR is
    begin
        return INSTR(31 downto 25);
    end;

    function instr_opcode    ( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return STD_LOGIC_VECTOR is
    begin
        return INSTR(6 downto 0);
    end;

    --
    ------------------------------------------------------------------------------------
    --

    function funct7_is_SRA   ( FUNC7: STD_LOGIC_VECTOR( 6 DOWNTO 0) ) return std_logic is
    begin
        if (FUNC7(5) = '1') then
            return '1';
        else
            return '0';
        end if;
    end;

    function funct7_is_SUB   ( FUNC7: STD_LOGIC_VECTOR( 6 DOWNTO 0) ) return std_logic is
    begin
        if (FUNC7(5) = '1') then
            return '1';
        else
            return '0';
        end if;
    end;

    --
    ------------------------------------------------------------------------------------
    --

    function funct3_is_word   ( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic is
    begin
        if (FUNC3(1 downto 0) = "10") then
            return '1';
        else
            return '0';
        end if;
    end;

    function funct3_is_half   ( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic is
    begin
        if (FUNC3(1 downto 0) = "01") then
            return '1';
        else
            return '0';
        end if;
    end;

    function funct3_is_byte   ( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic is
    begin
        if (FUNC3(1 downto 0) = "00") then
            return '1';
        else
            return '0';
        end if;
    end;

    function funct3_is_zero_ext( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic is
    begin
        return FUNC3(2);
    end;

    function funct3_is_sign_ext( FUNC3: STD_LOGIC_VECTOR( 2 DOWNTO 0) ) return std_logic is
    begin
        return NOT funct3_is_zero_ext(FUNC3);
    end;

    --
    ------------------------------------------------------------------------------------
    --

    function instr_alu_ress( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(6 downto 2) = "11100" then
            return '1';
        else
            return '0';
        end if;
    end;

    --
    ------------------------------------------------------------------------------------
    --

    function instr_rs1_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) )
        return STD_LOGIC_VECTOR is
    begin
        return INSTR(19 downto 15); 
    end;

    function instr_rs2_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) )
        return STD_LOGIC_VECTOR is
    begin
        return INSTR(24 downto 20);
    end;

    function instr_rd_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) )
        return STD_LOGIC_VECTOR is
    begin
        return INSTR(11 downto  7);
    end;

    function instr_csr_id( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) )
        return STD_LOGIC_VECTOR is
    begin
        return INSTR(27) & INSTR(21);
    end;

    --
    ------------------------------------------------------------------------------------
    --

    function instr_is_byte( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(13 downto 12) = "00" then
            return '1';
        else
            return '0';
        end if;
    end;

    function instr_is_half( INSTR: STD_LOGIC_VECTOR(31 DOWNTO 0) ) return std_logic is
    begin
        if INSTR(13 downto 12) = "01" then
            return '1';
        else
            return '0';
        end if;
    end;

    --
    ------------------------------------------------------------------------------------
    --

    function stdlv_add_s32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: STD_LOGIC_VECTOR(31 downto 0)
        )
        return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR( UNSIGNED(a) + UNSIGNED(b) );
    end function stdlv_add_s32;


    function stdlv_add_s32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: integer
        )
        return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR( SIGNED(a) + TO_SIGNED(b, 32) );
    end function stdlv_add_s32;


    function stdlv_add_u32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: STD_LOGIC_VECTOR(31 downto 0)
        )
        return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR( UNSIGNED(a) + UNSIGNED(b) );
    end function stdlv_add_u32;


    function stdlv_add_u32(
            A: STD_LOGIC_VECTOR(31 downto 0);
            B: integer
        )
        return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR( UNSIGNED(a) + TO_UNSIGNED(b, 32) );
    end function stdlv_add_u32;


    function stdlv_add_u64(
            A: STD_LOGIC_VECTOR(63 downto 0);
            B: integer
        )
        return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR( UNSIGNED(a) + TO_UNSIGNED(b, 32) );
    end function stdlv_add_u64;


    --
    ------------------------------------------------------------------------------------
    --

    function repeat_bit(B: std_logic; N: natural) return std_logic_vector is
        variable result: std_logic_vector(1 to N);
    begin
        for i in 1 to N loop
            result(i) := B;
        end loop;
        return result;
    end;  

    --
    ------------------------------------------------------------------------------------
    --

    function to_stdl(L: BOOLEAN) return std_ulogic is
    begin
        if L then
            return('1');
        else
            return('0');
        end if;
    end;


end package body riscv_types;
