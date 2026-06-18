library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

use work.riscv_types.all;
use work.riscv_config.all;

use work.decoder_5stg_pkg.all;
use work.mem_load_pkg.all;
use work.mem_store_pkg.all;
use work.csr_registers_pkg.all;
use work.mem_ram_pkg.all; --useless
use work.mem_ram_dp_pkg.all;
use work.mem_rom_pkg.all;
use work.immediate_pkg.all;
use work.addr_stack_pkg.all;
use work.alu_pkg.all;
use work.alu_mult_pkg.all;
use work.alu_div_pkg.all;
use work.registers_pass_pkg.all;

use std.env.finish; -- allows to stop the simulation on ebreak

entity riscv_5stg is
Port ( 
   CLK           : in  STD_LOGIC;
   resetn        : in  STD_LOGIC;
   IO_mem_addr   : out STD_LOGIC_VECTOR (31 downto 0);
   IO_mem_rdata  : in  STD_LOGIC_VECTOR (31 downto 0);
   IO_mem_wdata  : out STD_LOGIC_VECTOR (31 downto 0);
   IO_mem_rd     : out STD_LOGIC; -- TODO
   IO_mem_wr     : out STD_LOGIC
); 
end riscv_5stg;

-- /******************************************************************************/
-- 
-- 
--    Reminder for the 10 RISC-V codeops
--    ----------------------------------
--    5'b01100 | ALUreg  | rd <- rs1 OP rs2   
--    5'b00100 | ALUimm  | rd <- rs1 OP Iimm
--    5'b11000 | Branch  | if(rs1 OP rs2) PC<-PC+Bimm
--    5'b11001 | JALR    | rd <- PC+4; PC<-rs1+Iimm
--    5'b11011 | JAL     | rd <- PC+4; PC<-PC+Jimm
--    5'b00101 | AUIPC   | rd <- PC + Uimm
--    5'b01101 | LUI     | rd <- Uimm   
--    5'b00000 | Load    | rd <- mem[rs1+Iimm]
--    5'b01000 | Store   | mem[rs1+Simm] <- rs2
--    5'b11100 | SYSTEM  | special
-- 
-- 
-- /******************************************************************************/

architecture arch of riscv_5stg is

   -- Pipeline control
   -- Note: E_stall and M_flush are only used if RV32M is configured
   -- (multicycle ALU).
   
   --localparam NOP = 32'b0000000_00000_00000_000_00000_0110011; 
   constant NOP    : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000110011";

   SIGNAL F_stall   : STD_LOGIC;
   SIGNAL F_stalln  : STD_LOGIC;
   SIGNAL D_stall   : STD_LOGIC;
   SIGNAL E_stall   : STD_LOGIC;

   SIGNAL D_flush   : STD_LOGIC;
   SIGNAL E_flush   : STD_LOGIC;
   SIGNAL M_flush   : STD_LOGIC;

   SIGNAL halt      : STD_LOGIC; -- Halt execution (on ebreak)

   -- FETCH SIGNALS

   SIGNAL F_PC      : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL   PC      : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL F_PCplus4 : STD_LOGIC_VECTOR (31 downto 0);

   ---------------------------------------------------------------------------------------------------
   --
   -- Signaux rebouclants de l'etage MEMORY => FETCH/DECODE
   --

   SIGNAL wbEnable   : STD_LOGIC;
   SIGNAL wbData     : STD_LOGIC_VECTOR(31 DOWNTO  0);
   SIGNAL wbRdId     : STD_LOGIC_VECTOR( 4 DOWNTO  0);
   
   ---------------------------------------------------------------------------------------------------
   --
   -- Signaux utilisés dans dans l'étage de DECODE
   --

   SIGNAL FD_PC         : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL FD_instr      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL FD_nop        : STD_LOGIC; -- Needed because I cannot directly write NOP to FD_instr
                                     -- because FD_instr is plugged to PROGROM's output port.
   SIGNAL D_isLoad      : STD_LOGIC;
   SIGNAL D_isStore     : STD_LOGIC;
   SIGNAL D_isALUreg    : STD_LOGIC;
   SIGNAL D_isBranch    : STD_LOGIC;
   SIGNAL D_isSYSTEM    : STD_LOGIC;
   SIGNAL D_isJAL       : STD_LOGIC;
   SIGNAL D_isJALR      : STD_LOGIC;
   SIGNAL D_isJALorJALR : STD_LOGIC;
   SIGNAL D_isAuipc     : STD_LOGIC;
   SIGNAL D_isLui       : STD_LOGIC;
   SIGNAL D_isCustom    : STD_LOGIC; -- custom instruction
   SIGNAL D_isCSRRS     : STD_LOGIC;
   SIGNAL D_isEBreak    : STD_LOGIC;
   SIGNAL D_isByte      : STD_LOGIC;
   SIGNAL D_isHalf      : STD_LOGIC;
   SIGNAL D_isRV32M     : STD_LOGIC;
   SIGNAL D_isMUL       : STD_LOGIC;
   SIGNAL D_isDIV       : STD_LOGIC;
   SIGNAL D_funct3      : STD_LOGIC_VECTOR ( 2 downto 0);
   SIGNAL D_funct7      : STD_LOGIC_VECTOR ( 6 downto 0);
   SIGNAL D_csrId       : STD_LOGIC_VECTOR ( 1 downto 0);
   SIGNAL D_rs1         : STD_LOGIC_VECTOR ( 4 downto 0);
   SIGNAL D_isRs1Used   : STD_LOGIC;
   SIGNAL D_rs2         : STD_LOGIC_VECTOR ( 4 downto 0);
   SIGNAL D_isRs2Used   : STD_LOGIC;
   SIGNAL D_rdId        : STD_LOGIC_VECTOR ( 4 downto 0);
                                   
   SIGNAL D_predictPC     : STD_LOGIC;

   SIGNAL D_imm           : STD_LOGIC_VECTOR(31 DOWNTO 0);

   SIGNAL D_PCplus4orBimm : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL D_PCplus4       : STD_LOGIC_VECTOR(31 DOWNTO 0);

   SIGNAL d_stack_push_i  : STD_LOGIC;
   SIGNAL d_stack_pop_i   : STD_LOGIC;

   SIGNAL D_predictBranch : STD_LOGIC;
   SIGNAL D_PCprediction  : STD_LOGIC_VECTOR(31 DOWNTO 0);

   SIGNAL D_predictRA     : STD_LOGIC_VECTOR(31 DOWNTO 0);

   ---------------------------------------------------------------------------------------------------
   --
   -- Signaux utilisés dans dans l'étage de DECODE => EXECUTE
   --

   SIGNAL DE_nop              : STD_LOGIC;
   SIGNAL DE_rdId             : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL DE_rs1Id            : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL DE_rs2Id            : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL DE_csrId            : STD_LOGIC_VECTOR( 1 DOWNTO 0);
   SIGNAL DE_funct3           : STD_LOGIC_VECTOR( 2 DOWNTO 0);
   SIGNAL DE_funct7           : STD_LOGIC_VECTOR( 6 DOWNTO 0); 
   SIGNAL DE_Imm              : STD_LOGIC_VECTOR(31 DOWNTO 0); 
   SIGNAL DE_isALUreg         : STD_LOGIC;
   SIGNAL DE_isBranch         : STD_LOGIC;
   SIGNAL DE_isJALR           : STD_LOGIC;
   SIGNAL DE_isJAL            : STD_LOGIC;
   SIGNAL DE_isLoad           : STD_LOGIC;
   SIGNAL DE_isStore          : STD_LOGIC;
   SIGNAL DE_isCSRRS          : STD_LOGIC;
   SIGNAL DE_isEBREAK         : STD_LOGIC;
   SIGNAL DE_isRV32M          : STD_LOGIC;
   SIGNAL DE_isMUL            : STD_LOGIC;
   SIGNAL DE_isDIV            : STD_LOGIC;
   SIGNAL DE_isCustom         : STD_LOGIC; -- custom instruction
   SIGNAL DE_wbEnable         : STD_LOGIC;
   SIGNAL DE_predictBranch    : STD_LOGIC;
   SIGNAL DE_rs1Id_eq_EM_rdId : STD_LOGIC;
   SIGNAL DE_rs1Id_eq_MW_rdId : STD_LOGIC;
   SIGNAL DE_rs2Id_eq_EM_rdId : STD_LOGIC;
   SIGNAL DE_rs2Id_eq_MW_rdId : STD_LOGIC;
   SIGNAL DE_PCplus4orBimm    : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL DE_predictRA        : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL DE_PCplus4orUimm    : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL DE_isJALorJALRorLUIorAUIPC : STD_LOGIC;

   SIGNAL DE_rs1              : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL DE_rs2              : STD_LOGIC_VECTOR(31 DOWNTO 0);


   ---------------------------------------------------------------------------------------------------
   --
   -- E->M: Execute to Memory registers (pipeline)
   --

   SIGNAL EM_nop          : STD_LOGIC; -- Needed by instret in W stage   
   SIGNAL EM_rdId         : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL EM_funct3       : STD_LOGIC_VECTOR( 2 DOWNTO 0);
   SIGNAL EM_rs2          : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL EM_Eresult      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL EM_addr         : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL EM_Mdata        : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL EM_isStore      : STD_LOGIC;
   SIGNAL EM_isLoad       : STD_LOGIC;
   SIGNAL EM_isCSRRS      : STD_LOGIC;
   SIGNAL EM_wbEnable     : STD_LOGIC;
   SIGNAL EM_correctPC    : STD_LOGIC;
   SIGNAL EM_PCcorrection : STD_LOGIC_VECTOR(31 DOWNTO 0);

   ---------------------------------------------------------------------------------------------------
   --
   -- E: Execute stage
   --

   SIGNAL E_M_fwd_rs1 : STD_LOGIC;
   SIGNAL E_W_fwd_rs1 : STD_LOGIC;
   SIGNAL E_M_fwd_rs2 : STD_LOGIC;
   SIGNAL E_W_fwd_rs2 : STD_LOGIC;

   SIGNAL E_rs1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL E_rs2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
   
   SIGNAL E_aluOut_base : STD_LOGIC_VECTOR(31 DOWNTO 0); 

   SIGNAL E_isMULH        : STD_LOGIC;
   SIGNAL E_isMULHSU      : STD_LOGIC;
   SIGNAL E_mul_sign1     : STD_LOGIC;
   SIGNAL E_mul_sign2     : STD_LOGIC;
   SIGNAL E_mul_signed1   : STD_LOGIC_VECTOR(32 DOWNTO 0);
   SIGNAL E_mul_signed2   : STD_LOGIC_VECTOR(32 DOWNTO 0);
   SIGNAL E_multiply      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL EE_dividend     : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL EE_divBusy      : STD_LOGIC;
   SIGNAL EE_mulFinished  : STD_LOGIC;
   SIGNAL EE_mulBusy      : STD_LOGIC;
   SIGNAL EE_divFinished  : STD_LOGIC;
   SIGNAL E_divstep_do    : STD_LOGIC;
   SIGNAL E_divsel        : STD_LOGIC_VECTOR( 2 DOWNTO 0);
   SIGNAL E_divide        : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL E_aluOut        : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL aluBusy         : STD_LOGIC;
   SIGNAL E_takeBranch    : STD_LOGIC;
   SIGNAL E_JALRaddr      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL E_correctPC     : STD_LOGIC;
   SIGNAL E_PCcorrection  : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL E_result        : STD_LOGIC_VECTOR(31 DOWNTO 0); 
   SIGNAL E_addr          : STD_LOGIC_VECTOR(31 DOWNTO 0);
   
   
   ---------------------------------------------------------------------------------------------------
   --
   -- M: Memory stage
   --

   SIGNAL M_isB        : STD_LOGIC;
   SIGNAL M_isH        : STD_LOGIC;
--   SIGNAL E_STORE_data : STD_LOGIC_VECTOR(31 DOWNTO 0);

   SIGNAL M_isIO         : STD_LOGIC;
   SIGNAL M_isRAM        : STD_LOGIC;
   SIGNAL M_wbData       : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL M_STORE_data   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL M_wmask        : STD_LOGIC_VECTOR( 3 DOWNTO 0);
   SIGNAL M_word_addr    : STD_LOGIC_VECTOR(13 DOWNTO 0);
   SIGNAL M_STORE_wmask  : STD_LOGIC_VECTOR( 3 DOWNTO 0);
   SIGNAL M_CSR_data     : STD_LOGIC_VECTOR(31 DOWNTO 0);


   SIGNAL M_LOAD_H       : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL M_LOAD_B       : STD_LOGIC_VECTOR( 7 DOWNTO 0);
   SIGNAL M_sext         : STD_LOGIC;
   SIGNAL M_LOAD_sign    : STD_LOGIC;
   SIGNAL M_Mdata        : STD_LOGIC_VECTOR(31 DOWNTO 0);

   ---------------------------------------------------------------------------------------------------
   --
   -- W: WriteBack stage
   --
   SIGNAL MW_nop         : STD_LOGIC;
   SIGNAL MW_rdId        : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL MW_wbData      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL MW_wbEnable    : STD_LOGIC;

   ---------------------------------------------------------------------------------------------------
   --
   -- Other signals
   --

   signal rs1Hazard      : STD_LOGIC;
   signal rs2Hazard      : STD_LOGIC;
   signal dataHazard     : STD_LOGIC;
    
   ---------------------------------------------------------------------------------------------------
   --
   -- Registre utilisés entre les étages de DECODE => EXECUTE
   --
  
-- /******************************************************************************/

    function to_stdl(L: BOOLEAN) return std_ulogic is
    begin
        if L then
            return('1');
       else
           return('0');
       end if;
   end;

    function repeat_bit(B: std_logic; N: natural) return std_logic_vector is
        variable result: std_logic_vector(1 to N);
    begin
        for i in 1 to N loop
            result(i) := B;
        end loop;
        return result;
    end;  

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

   -- /******************************************************************************/

begin

-- /******************************************************************************/
-- 
--
-- 

   PROCESS(clk)
      VARIABLE addr : INTEGER;
   BEGIN   
         if rising_edge(clk) then
            FD_nop <= D_flush OR (NOT resetn);
         end if;
   END PROCESS;

   
-- /******************************************************************************/
-- 
--                       F: Instruction fetch
-- 

   --
   -- L'étage de fetch est il gelé à cause du pipeline ?
   --
   F_stalln <= NOT F_stall;

   --
   -- Choix de l'adresse de la prochaine instruction, on by-pass si necessaire
   -- la valeur du PC calculée au cycle précédent
   --
   F_PC <= D_PCprediction  when D_predictPC  = '1' else -- Prediction faite dans le décodeur
           EM_PCcorrection when EM_correctPC = '1' else -- Correction provenant de l'étage d'exec
           PC;                                          -- La valeur normale du PC

   prog_rom : mem_rom
   PORT MAP ( 
       CLOCK  => clk,
       ENABLE => F_stalln,         -- an enable bit 
       ADDR_R => F_PC(15 downto 0),
       DATA_O => FD_instr
    );

   --
   -- On calcule la prochaine adresse "normale" du PC a partir de la valeur choisie
   -- precedement
   --
   F_PCplus4 <= stdlv_add_u32( F_PC, 4 );

   --
   --
   ------------------------------------------------------------------------------
   --
   --

   process(clk)
      VARIABLE addr : INTEGER;
   begin   
      if rising_edge(clk) then
         if resetn = '0' then
            FD_PC    <= (others => '0');
            PC       <= (others => '0');
         elsif F_stall = '0' then
            FD_PC    <= F_PC;          -- La valeur du PC          => decode
            PC       <= F_PCplus4;     -- La valeur du prochain PC => fetch
         end if;
         FD_nop <= D_flush OR (NOT resetn);
      end if;
   end process;

   ------------------------------------------------------------------------------
   --
   --                     D: Instruction decode
   --

   dec : decoder_5stg
   PORT MAP(
      instr_i       => FD_instr,    -- le code operation qui rentre dans le decoder

      isLoad_o      => D_isLoad,    -- l'instruction est de type load
      isStore_o     => D_isStore,   -- l'instruction est de type store
      isALUreg_o    => D_isALUreg,  -- l'instruction utilise rs1 ET rs2
      isBranch_o    => D_isBranch, 
      isSYSTEM_o    => D_isSYSTEM,
      isJAL_o       => D_isJAL,
      isJALR_o      => D_isJALR,
      isJALorJALR_o => D_isJALorJALR,
      isAuipc_o     => D_isAuipc,
      isLui_o       => D_isLui,
      isCSRRS_o     => D_isCSRRS,
      isEBreak_o    => D_isEBreak,
      isByte_o      => D_isByte,
      isHalf_o      => D_isHalf,

      funct3_o      => D_funct3,
      funct7_o      => D_funct7,

      rs1_o         => D_rs1,
      isRs1Used_o   => D_isRs1Used,
      rs2_o         => D_rs2,
      isRs2Used_o   => D_isRs2Used,
      rdId_o        => D_rdId,
      csrId_o       => D_csrId,

      isRV32M_o     => D_isRV32M,   -- l'instruction appartient à l'extension M
      isMUL_o       => D_isMUL,     -- il s'agit d'une multiplication
      isDIV_o       => D_isDIV,     -- il s'agit d'une division
      isCustom_o    => D_isCustom   -- c'est une instruction custom (cf. sujet de TP)
   );
   

   imm : immediate
   PORT MAP(
      INSTR    => FD_instr,
      isStore  => D_isStore,
      isLoad   => D_isLoad,
      isbranch => D_isbranch,
      isJAL    => D_isJAL,
      isAuipc  => D_isAuipc,
      isLui    => D_isLui,
      imm      => D_imm
   );   

   -- No GSHARE branch predictor,
   -- use BTFNT (Backwards taken forwards not taken)
   -- I[31]=Bimm sgn (pred bkwd branch taken)   

   -- code below is equivalent (in this context) to:
   --   D_isJAL || D_isJALR || (D_isBranch && D_predictBranch) 
   -- JAL:    11011
   -- JALR:   11001
   -- Branch: 11000
   -- The three start by 110, and it is the only ones
   D_predictPC       <= '1' WHEN (FD_nop = '0')
                           AND (FD_instr(6 downto 4) = "110")               -- D_isJAL || D_isJALR
                           AND (FD_instr(2) = '1' OR D_predictBranch = '1') 
                           ELSE '0';
   D_predictBranch   <= FD_instr(31);

   --
   -- Return address stack
   --
   D_PCprediction <= D_predictRA                   WHEN FD_instr(3 downto 2) = "01" ELSE -- is jalr
                     stdlv_add_u32(FD_PC, D_imm)   WHEN D_isJAL = '1'               ELSE -- is jal
                     stdlv_add_u32(FD_PC, D_imm);                                        -- branch instruction

   D_PCplus4       <= stdlv_add_u32(FD_PC, 4);
                     
   D_PCplus4orBimm <= D_PCplus4 WHEN D_predictBranch = '1' ELSE
                      stdlv_add_u32(FD_PC, D_imm);


   --
   --
   ------------------------------------------------------------------------------
   --
   --

   process(clk)
   begin   
      if rising_edge(clk) then

         if resetn = '0' then

            DE_nop              <= '1';
            DE_rdId             <= (others => '0');
            DE_rs1Id            <= (others => '0');
            DE_rs2Id            <= (others => '0');
            DE_csrId            <= (others => '0');

            DE_rs1Id_eq_EM_rdId <= '0';
            DE_rs1Id_eq_MW_rdId <= '0';

            DE_rs2Id_eq_EM_rdId <= '0';
            DE_rs2Id_eq_MW_rdId <= '0';

            DE_funct7           <= (others => '0');
            DE_funct3           <= (others => '0');

            DE_isRV32M          <= '0';
            DE_isMUL            <= '0';
            DE_isDIV            <= '0';
            DE_isCustom         <= '0';
	         DE_isALUreg         <= '0';
            DE_isBranch         <= '0';
            DE_isJALR           <= '0';

            DE_isJAL            <= '0';

            DE_isLoad           <= '0';
            DE_isStore          <= '0';
            DE_isCSRRS          <= '0';
            DE_isEBREAK         <= '0';

            DE_wbEnable         <= '0';
            DE_imm              <= (others => '0');

            DE_PCplus4orBimm    <= (others => '0');
            DE_predictBranch    <= '0';

            DE_predictRA        <= (others => '0');

            DE_PCplus4orUimm           <= (others => '0');
            DE_isJALorJALRorLUIorAUIPC <= FD_instr(2);

        ---------------------------------------------------------------------------------------------

         elsif E_flush = '1' OR FD_nop = '1' then

            DE_nop      <= '1';
            DE_isALUreg <= '0';
            DE_isBranch <= '0';
            DE_isJALR   <= '0';
            DE_isJAL    <= '0';
            DE_isLoad   <= '0';
            DE_isStore  <= '0';
            DE_isCSRRS  <= '0';
            DE_isEBREAK <= '0';
            DE_wbEnable <= '0';
            DE_isRV32M  <= '0';
            DE_isMUL    <= '0';	 
            DE_isDIV    <= '0';
            DE_isCustom <= '0';
            DE_isJALorJALRorLUIorAUIPC <= '0';

        ---------------------------------------------------------------------------------------------

         elsif D_stall = '0' then
         
            DE_rdId             <= D_rdId;
            DE_rs1Id            <= D_rs1;
            DE_rs2Id            <= D_rs2;
            DE_csrId            <= D_csrId;

            DE_rs1Id_eq_EM_rdId <= to_stdl(D_rs1 = DE_rdId); -- Pipelined register Id comparison for
            DE_rs1Id_eq_MW_rdId <= to_stdl(D_rs1 = EM_rdId); -- register forwarding.

            DE_rs2Id_eq_EM_rdId <= to_stdl(D_rs2 = DE_rdId);
            DE_rs2Id_eq_MW_rdId <= to_stdl(D_rs2 = EM_rdId);

            DE_funct7           <= D_funct7;-- isSub
            DE_funct3           <= D_funct3;

            DE_isRV32M  <= D_isRV32M;
            DE_isMUL    <= D_isMUL;
            DE_isDIV    <= D_isDIV;
            DE_isCustom <= D_isCustom;

            DE_nop      <= '0';
            DE_isALUreg <= D_isALUreg;
            DE_isBranch <= D_isBranch;
            DE_isJALR   <= D_isJALR;

            DE_isJAL    <= D_isJAL;

            DE_isLoad   <= D_isLoad;
            DE_isStore  <= D_isStore;
            DE_isCSRRS  <= D_isCSRRS;
            DE_isEBREAK <= D_isEBreak;

	         -- wbEnable = !isBranch & !isStore
            -- Note: EM_wbEnable = DE_wbEnable && (rdId != 0)
            DE_wbEnable <= to_stdl(FD_instr(5 downto 2) /= "1000");

            DE_imm      <= D_imm;
--`ifdef CONFIG_PC_PREDICT      
	       -- Used in case of misprediction: 
	       -- PC + Bimm if predict not taken, PC+4 if predict taken
	         DE_PCplus4orBimm <= D_PCplus4orBimm;
            DE_predictBranch <= D_predictBranch;

            DE_predictRA     <= D_predictRA; -- On memorise la prediction de branche que l'on a faite

            IF D_isJALorJALR = '1' THEN
                DE_PCplus4orUimm <= STD_LOGIC_VECTOR( SIGNED(repeat_bit( to_stdl(FD_instr(6 downto 5) /= "01"), 32) and FD_PC) + TO_SIGNED(4, 32));
            ELSE
                DE_PCplus4orUimm <= STD_LOGIC_VECTOR( SIGNED(repeat_bit( to_stdl(FD_instr(6 downto 5) /= "01"), 32) and FD_PC) + SIGNED(D_imm));
            END IF;
            
            DE_isJALorJALRorLUIorAUIPC <= FD_instr(2);
            
            end if;
        end if;
    end process;


   --
   --
   ------------------------------------------------------------------------------
   --
   -- prediction de branchement 
   --

   d_stack_push_i <= '1' WHEN (D_stall = '0') AND (FD_nop = '0') AND (D_flush = '0') AND (D_isJAL  = '1') AND (D_rdId = "00001")                                          ELSE '0';
   d_stack_pop_i  <= '1' WHEN (D_stall = '0') AND (FD_nop = '0') AND (D_flush = '0') AND (D_isJALR = '1') AND (D_rdId = "00000") AND (D_rs1 = "00001" OR D_rs1 = "00101") ELSE '0';

   stack : addr_stack
   PORT MAP(
      CLK     => clk,            -- horloge du processeur
      resetn  => resetn,         -- le signal de reset
      addr_i  => D_PCplus4,      -- la valeur de PC (actuel + 4) = la prochaine instruction (adresse de retourd en cas de JAL/JALR)
      push_i  => d_stack_push_i, -- l'instruction en cours en un JAL/JALR donc on memorise l'adresse de retour pour plus tard
      pop_i   => d_stack_pop_i,  -- l'instruction en cours est un RET, on depile l'adresse de retour car on vient de l'utiliser
      addr_o  => D_predictRA     -- adresse du PC prédite en cas de RET
   );

   --
   --
   ------------------------------------------------------------------------------
   --
   -- Les registres avec un by-pass (rd => rs1 ou rs2)
   --

    regs : registers_pass
    PORT MAP(
       CLOCK    => clk,
       reset    => '0',      -- to change
       RS1_id   => D_rs1,    -- id du registre dans le decode
       RS2_id   => D_rs2,    -- id du registre dans le decode
       e_hold   => D_stall,  -- signal de stall provenant du décodeur, freeze la mise a jour de DE_rs1, DE_rs2
       RD_id    => wbRdId,   -- id du registre dans le write back
       RD_id_we => wbEnable, -- validation de l'écriture dans le write back
       DATA_rd  => wbData,   -- donnée a écrire dans le write back
       DATA_rs1 => DE_rs1,   -- donnée lue => execute stage
       DATA_rs2 => DE_rs2    -- donnée lue => execute stage
    );

   --
   --
   ------------------------------------------------------------------------------
   --
   --                     /*** E: Execute ***/
   --

   --  Registrer forwarding from EX_2_MEM or MEM_2_WRITE pipeline stages

   E_M_fwd_rs1  <= EM_wbEnable AND DE_rs1Id_eq_EM_rdId;
   E_W_fwd_rs1  <= MW_wbEnable AND DE_rs1Id_eq_MW_rdId;

   E_M_fwd_rs2  <= EM_wbEnable AND DE_rs2Id_eq_EM_rdId;
   E_W_fwd_rs2  <= MW_wbEnable AND DE_rs2Id_eq_MW_rdId;

   E_rs1 <= EM_Eresult when E_M_fwd_rs1 = '1' else
            wbData     when E_W_fwd_rs1 = '1' else 
            DE_rs1;

   E_rs2 <= EM_Eresult when E_M_fwd_rs2 = '1' else
            wbData     when E_W_fwd_rs2 = '1' else 
            DE_rs2;
   
   --
   --
   ------------------------------------------------------------------------------
   --
   --                     /*** the ALU ***/
   --

   i_alu : alu
   PORT MAP(
      rs1_v             => E_rs1,
      rs2_v             => E_rs2,
      isALUreg          => DE_isALUreg,  -- todo
      isCustom          => DE_isCustom,  -- custom instruction
      isBranch          => DE_isBranch,  -- todo
      isAluSubstraction => DE_funct7(5), -- funct7_is_SUB( DE_funct7 ),
      func7             => DE_funct7,
      func3             => DE_funct3,
      imm_v             => DE_imm,
      aluOut_v          => E_aluOut_base,
      aluPlus_v         => open,
      takeBranch        => E_takeBranch
   );
              
   --
   --
   ------------------------------------------------------------------------------
   --
   --                     /*** the MULT ***/
   --
   
	multiplier : alu_mult
	PORT MAP(
		clk_i      => clk,
		rstn_i     => resetn,
		rs1_i      => E_rs1,
		rs2_i      => E_rs2,
		en_i       => DE_isRV32M AND DE_isMUL AND (NOT EE_mulFinished),
		func3_i    => DE_funct3,
		mul_o      => E_multiply,
		finished_o => EE_mulFinished,
		busy_o     => EE_mulBusy
	);
	
   --
   --
   ------------------------------------------------------------------------------
   --
   --                     /*** the DIV ***/
   --

	divider : alu_div
	PORT MAP(
		clk_i      => clk,
		rstn_i     => resetn,
		rs1_i      => E_rs1,
		rs2_i      => E_rs2,
		en_i       => DE_isRV32M AND DE_isDIV and (NOT EE_divFinished) ,
		func3_i    => DE_funct3,
		div_o      => E_divide,
		finished_o => EE_divFinished,
		busy_o     => EE_divBusy
	);
	
   E_aluOut <= E_divide       when DE_isRV32M = '1' and DE_isDIV = '1' ELSE
               E_multiply     when DE_isRV32M = '1' and DE_isMUL = '1' ELSE
               E_aluOut_base;

   aluBusy  <= 	(DE_isRV32M and DE_isDIV AND (NOT EE_divFinished))    -- gestion du stall dans le pipeline
   				OR (DE_isRV32M and DE_isMUL AND (NOT EE_mulFinished));   -- gestion du stall dans le pipeline

--   /*********** Branch, JAL, JALR ***********************************/

   E_JALRaddr     <= stdlv_add_u32(E_rs1, DE_imm)(31 downto 1) & "0";


   E_correctPC   <=  (DE_isJALR   AND to_stdl(DE_predictRA /= E_JALRaddr))
                  OR (DE_isBranch AND (E_takeBranch XOR DE_predictBranch));
                
   
   E_PCcorrection <= DE_PCplus4orBimm when DE_isBranch = '1' ELSE E_JALRaddr;
   
   
   E_result       <= DE_PCplus4orUimm WHEN DE_isJALorJALRorLUIorAUIPC ='1' ELSE E_aluOut; 
   E_addr         <= stdlv_add_u32( E_rs1, DE_Imm );
   
--   /**************************************************************/

   process(clk)
   begin   
      if rising_edge(clk) then

         if resetn = '0' then
            EM_nop          <= '1';
            EM_isLoad       <= '0';
            EM_isStore      <= '0';
            EM_isCSRRS      <= '0';
            EM_wbEnable     <= '0';
            EM_correctPC    <= '0';
            EM_rdId         <= (others => '0');
            EM_funct3       <= (others => '0');
            EM_rs2          <= (others => '0');
            EM_Eresult      <= (others => '0');
            EM_addr         <= (others => '0');
            EM_PCcorrection <= (others => '0');

         elsif M_flush = '1' then

            -- Pourquoi pas comme pour le RESET ?
            EM_nop          <= '1';
            EM_isLoad       <= '0';
            EM_isStore      <= '0';
            EM_isCSRRS      <= '0';
            EM_wbEnable     <= '0';
            EM_correctPC    <= '0';

         elsif E_stall = '0' then

            EM_nop          <= DE_nop;
            EM_isLoad       <= DE_isLoad;
            EM_isStore      <= DE_isStore;
            EM_isCSRRS      <= DE_isCSRRS;
            EM_wbEnable     <= DE_wbEnable AND to_stdl(DE_rdId /= "00000"); -- a deplacer ? a intégrer dans la reg. file ?
            EM_correctPC    <= E_correctPC;
            EM_rdId         <= DE_rdId;
            EM_funct3       <= DE_funct3;
            EM_rs2          <= E_rs2;
            EM_Eresult      <= E_result;
            EM_addr         <= E_addr;
            EM_PCcorrection <= E_PCcorrection;
         end if;
      end if;
   end process;

   --
   -- Gestion de l'arret du processeur (ou plutot de la simulation du processeur)
   --
   halt <= resetn AND DE_isEBREAK;

   ---------------------------------------------------------------------------------------------------
   --
   -- Terminate the simulation when ECALL instruction is executed
   --

   process(clk)
   begin   
      if rising_edge(clk) then
         if DE_isEBREAK = '1' then
            finish; -- stopping the simulation !
            --report "It means that the simulation end NORMALLY !" severity failure;
         end if;
      end if;
   end process;


   ---------------------------------------------------------------------------------------------------
   --
   -- W: Memory stage
   --

   M_isB <= '1' WHEN EM_funct3(1 downto 0) = "00" ELSE '0';
   M_isH <= '1' WHEN EM_funct3(1 downto 0) = "01" ELSE '0';

   --*************** STORE **************************/

   M_STORE_data( 7 downto  0) <= EM_rs2(7 downto 0);
   M_STORE_data(15 downto  8) <= EM_rs2(7 downto 0) when EM_addr(0) = '1' else EM_rs2(15 downto  8);
   M_STORE_data(23 downto 16) <= EM_rs2(7 downto 0) when EM_addr(1) = '1' else EM_rs2(23 downto 16);
   M_STORE_data(31 downto 24) <= EM_rs2(7 downto 0) when EM_addr(0) = '1' else EM_rs2(15 downto  8) when EM_addr(1) = '1' else EM_rs2(31 downto 24);

   M_STORE_wmask <= "1000" when M_isB = '1' and EM_addr(1 downto 0) = "11" ELSE
                    "0100" when M_isB = '1' and EM_addr(1 downto 0) = "10" ELSE
                    "0010" when M_isB = '1' and EM_addr(1 downto 0) = "01" ELSE
                    "0001" when M_isB = '1' and EM_addr(1 downto 0) = "00" ELSE
                    "1100" when M_isH = '1' and EM_addr(1) = '1'           ELSE
                    "0011" when M_isH = '1' and EM_addr(1) = '0'           ELSE
                    "1111";

   M_isIO       <= to_stdl( EM_addr(31 downto 24) /= x"00"); -- BLG, why IO ?
   M_isRAM      <= NOT M_isIO;
   IO_mem_addr  <= EM_addr;

   IO_mem_wr    <= EM_isStore AND M_isIO;
   IO_mem_rd    <= EM_isLoad  AND M_isIO;

   IO_mem_wdata <= EM_rs2;
   M_wmask      <= M_STORE_wmask WHEN EM_isStore = '1' AND M_isRAM = '1' ELSE "0000";
   M_word_addr  <= EM_addr(15 downto 2);

   --
   --
   ------------------------------------------------------------------------------
   --
   --                     /*** the ALU ***/
   --

   data_ram_dp : mem_ram_dp
   PORT MAP( 
      CLOCK   => clk,
      ADDR_R  => E_addr(15 downto 0),      -- adresse en lecture (execute)
      DATA_R  => EM_Mdata,                 -- data pour l'etage memoire
      WRITE_M => M_wmask,                  -- masque pour l'écriture 
      ADDR_W  => EM_addr(15 downto 0),     -- adresse en lecture / ecriture
      DATA_W  => M_STORE_data              -- la donnée à écrire
   );

   --
   --
   -------------------------------(  LOAD  )-------------------------------------
   --
   --

   load : mem_load
   PORT MAP(
      ADDR_R      => EM_addr(1 DOWNTO 0),
      DATA_R      => EM_Mdata,
      is_byte     => M_isB,
      is_half     => M_isH,
      is_sign_ext => M_sext,
      data_value  => M_Mdata
   );
   
   --
   -- Synchronous module, need 1 clock cycle
   -- 
   csr_reg : csr_registers
   PORT MAP ( 
      CLK      => clk,
      resetn   => resetn,
      instr_en => NOT MW_nop,  -- indique lorsqu'une instruction a ete consommme par le u-proc
      csr_id   => DE_csrId,    -- from decode 
      word_v   => M_CSR_data   -- to execute
   );
  
   
   --
   --
   ------------------------------------------------------------------------------
   --
   --

   M_wbData <= IO_mem_rdata WHEN EM_isLoad  = '1' AND M_isIO = '1' ELSE
               M_Mdata      WHEN EM_isLoad  = '1' AND M_isIO = '0' ELSE
               M_CSR_data   WHEN EM_isCSRRS = '1'                  ELSE
               EM_Eresult;

   process(clk)
   begin   
    if rising_edge(clk) then
        if resetn = '0' then
            MW_nop       <= '1';
            MW_rdId      <= (others => '0');
            MW_wbData    <= (others => '0');
            MW_wbEnable  <= '0';
        else      
            MW_nop       <= EM_nop;       -- is nop operation
            MW_rdId      <= EM_rdId;      -- id of the register to write
            MW_wbData    <= M_wbData;     -- data to write
            MW_wbEnable  <= EM_wbEnable;  -- enable the write operation
          end if;
       end if;
   end process;


   ---------------------------------------------------------------------------------------------------
   --
   -- W: WriteBack stage
   --
		     
   wbData   <= MW_wbData;     --
   wbEnable <= MW_wbEnable;   --
   wbRdId   <= MW_rdId;       --
   
--/******************************************************************************/

   -- we do not test rdId == 0 because in general, one loads data to
   -- a register, not to zero !

   rs1Hazard <= D_isRs1Used AND to_stdl(D_rs1 = DE_rdId);
   rs2Hazard <= D_isRs2Used AND to_stdl(D_rs2 = DE_rdId);

   -- we could generate slightly more bubble with
   -- simpler test (to be used if critical path is here)
   -- -> keeping this one (seems it has no influence on CPI,
   --   and results in slightly better timings)
   -- wire  rs1Hazard = (D_rs1Id == DE_rdId);
   -- wire  rs2Hazard = (D_rs2Id == DE_rdId);
   
   -- we are not obliged to compare all bits ! 
   -- wire rs1Hazard = (D_rs1Id[3:0] == DE_rdId[3:0]);
   -- wire rs2Hazard = (D_rs2Id[3:0] == DE_rdId[3:0]);
   
   -- Add bubble if next instr uses result of latency-2 instr
   -- Or load right after store (problem only if same address, 
   -- we could also test but D does not know address yet)
   --  (we need here load after store test because mem read access is done
   --   in E. It was not the case in the non-optimized version)
   
   dataHazard <= (NOT FD_nop) AND ( ( (DE_isLoad OR DE_isCSRRS) AND (rs1Hazard OR rs2Hazard) ) OR ( D_isLoad AND DE_isStore) ); 
   -- TODO: more subtle for load-store, add bypass if same addr

   -- (other option: always add bubble after latency-2 instr 
   -- like Samsoniuk's DarkRiscV). Increases CPI and may reduce critical path.
   --wire dataHazard = !FD_nop &&  (  
   --   (DE_isLoad || DE_isCSRRS) || (D_isLoad && DE_isStore)  
   --);

   F_stall <= aluBusy OR dataHazard OR halt;
   D_stall <= aluBusy OR dataHazard OR halt;
   E_stall <= aluBusy;

   -- Here we need to use E_correctPC (the registered version
   -- DE_correctPC is not ready on time).

   D_flush <= E_correctPC;
   E_flush <= E_correctPC OR dataHazard;
   M_flush <= aluBusy;

   -- Note: E_stall and M_flush are only used with the
   -- multi-cycle ALU (RV32M)
   
--/******************************************************************************/
      
end arch;
