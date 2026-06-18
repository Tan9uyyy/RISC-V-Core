-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity alu_tb is
end;

architecture bench of alu_tb is

  component alu
  Port ( 
     rs1_v             : in  STD_LOGIC_VECTOR (31 downto 0);
     rs2_v             : in  STD_LOGIC_VECTOR (31 downto 0);
     isALUreg          : in  STD_LOGIC;
     isBranch          : in  STD_LOGIC;
     isAluSubstraction : in  STD_LOGIC;
     isCustom          : in  STD_LOGIC;
     func3             : in  STD_LOGIC_VECTOR ( 2 downto 0);
     func7             : in  STD_LOGIC_VECTOR ( 6 downto 0);
     imm_v             : in  STD_LOGIC_VECTOR (31 downto 0);
     aluOut_v          : out STD_LOGIC_VECTOR (31 downto 0);
     aluPlus_v         : out STD_LOGIC_VECTOR (31 downto 0);
     takeBranch        : out STD_LOGIC
   );
  end component;

  signal rs1_v             : STD_LOGIC_VECTOR (31 downto 0);
  signal rs2_v             : STD_LOGIC_VECTOR (31 downto 0);
  signal isALUreg          : STD_LOGIC;
  signal isBranch          : STD_LOGIC;
  signal isAluSubstraction : STD_LOGIC;
  signal isCustom          : STD_LOGIC;
  signal func3             : STD_LOGIC_VECTOR ( 2 downto 0);
  signal func7             : STD_LOGIC_VECTOR ( 6 downto 0);
  signal imm_v             : STD_LOGIC_VECTOR (31 downto 0);
  signal aluOut_v          : STD_LOGIC_VECTOR (31 downto 0);
  signal aluPlus_v         : STD_LOGIC_VECTOR (31 downto 0);
  signal takeBranch        : STD_LOGIC ;

begin

  uut: alu port map ( rs1_v             => rs1_v,
                      rs2_v             => rs2_v,
                      isALUreg          => isALUreg,
                      isBranch          => isBranch,
                      isAluSubstraction => isAluSubstraction,
                      isCustom          => isCustom,
                      func3             => func3,
                      func7             => func7,
                      imm_v             => imm_v,
                      aluOut_v          => aluOut_v,
                      aluPlus_v         => aluPlus_v,
                      takeBranch        => takeBranch );

  stimulus: process
  begin
  
    ------------------------------------------------------------------------
    --
    --
    -- ADD (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "000";
    func7             <= "0000000";

    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000" ) report "Test failed" severity error;
    assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";
  
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000002" ) report "Test failed" severity error;
    assert(aluPlus_v =  x"00000002" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"00000007";
    rs2_v             <= x"00000003";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"0000000A" ) report "Test failed" severity error;
    assert(aluPlus_v =  x"0000000A" ) report "Test failed" severity error;
--  takeBranch        <= "";

    ------------------------------------------------------------------------
    --
    --
    -- ADD (rs_1 + imm)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "000";
    func7             <= "0000000";

    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000" ) report "Test failed" severity error;
    assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";
  
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000002" ) report "Test failed" severity error;
    assert(aluPlus_v =  x"00000002" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"00000007";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000003";
    wait for 10 ns;
    assert(aluOut_v  =  x"0000000A" ) report "Test failed" severity error;
    assert(aluPlus_v =  x"0000000A" ) report "Test failed" severity error;
--  takeBranch        <= "";

    ------------------------------------------------------------------------
    --
    --
    -- AND (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "111";
    func7             <= "0000000";

    rs1_v             <= x"ff00ff00";
    rs2_v             <= x"0f0f0f0f";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"0f000f00" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";
  
    rs1_v             <= x"0ff00ff0";
    rs2_v             <= x"f0f0f0f0";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00f000f0" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"00ff00ff";
    rs2_v             <= x"0f0f0f0f";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"000f000f" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"f00ff00f";
    rs2_v             <= x"f0f0f0f0";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"f000f000" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    ------------------------------------------------------------------------
    --
    --
    -- AND (rs_1 + imm)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "111";
    func7             <= "0000000";

    rs1_v             <= x"ff00ff00";
    rs2_v             <= x"00000000";
    imm_v             <= x"ff00ff00";
    wait for 10 ns;
    assert(aluOut_v  =  x"ff00ff00" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";
  
    rs1_v             <= x"0ff00ff0";
    rs2_v             <= x"00000000";
    imm_v             <= x"000000f0";
    wait for 10 ns;
    assert(aluOut_v  =  x"000000f0" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"00ff00ff";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000070f";
    wait for 10 ns;
    assert(aluOut_v  =  x"0000000f" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"f00ff00f";
    rs2_v             <= x"00000000";
    imm_v             <= x"000000f0";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    ------------------------------------------------------------------------
    --
    --
    -- OR (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "110";
    func7             <= "0000000";

    rs1_v             <= x"ff00ff00";
    rs2_v             <= x"0f0f0f0f";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"ff0fff0f" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";
  
    rs1_v             <= x"0ff00ff0";
    rs2_v             <= x"f0f0f0f0";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"fff0fff0" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"00ff00ff";
    rs2_v             <= x"0f0f0f0f";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"0fff0fff" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"f00ff00f";
    rs2_v             <= x"f0f0f0f0";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"f0fff0ff" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";


    ------------------------------------------------------------------------
    --
    --
    -- OR (rs_1 + imm)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "110";
    func7             <= "0000000";

    rs1_v             <= x"ff00ff00";
    rs2_v             <= x"00000000";
    imm_v             <= x"ffffff0f";
    wait for 10 ns;
    assert(aluOut_v  =  x"ffffff0f" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";
  
    rs1_v             <= x"0ff00ff0";
    rs2_v             <= x"00000000";
    imm_v             <= x"000000f0";
    wait for 10 ns;
    assert(aluOut_v  =  x"0ff00ff0" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"00ff00ff";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000070f";
    wait for 10 ns;
    assert(aluOut_v  =  x"00ff07ff" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    rs1_v             <= x"f00ff00f";
    rs2_v             <= x"00000000";
    imm_v             <= x"000000f0";
    wait for 10 ns;
    assert(aluOut_v  =  x"f00ff0ff" ) report "Test failed" severity error;
--  assert(aluPlus_v =  x"00000000" ) report "Test failed" severity error;
--  takeBranch        <= "";

    ------------------------------------------------------------------------
    --
    --
    -- SLL (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "001";
    func7             <= "0000000";

    --TEST_RR_OP ( 23, sll,   0x00000001, 0x00000001, 0  );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001" ) report "Test failed" severity error;
  
    --TEST_RR_OP ( 24, sll,   0x00000002, 0x00000001, 1  );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000001"; -- 1
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000002" ) report "Test failed" severity error;

    --TEST_RR_OP ( 25, sll,   0x00000080, 0x00000001, 7  );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000007"; -- 7
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000080" ) report "Test failed" severity error;

    --TEST_RR_OP ( 26, sll,   0x00004000, 0x00000001, 14 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"0000000E"; -- 14
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00004000" ) report "Test failed" severity error;

    --TEST_RR_OP ( 27, sll,   0x80000000, 0x00000001, 31 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"0000001F"; -- 31
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000" ) report "Test failed" severity error;

    --TEST_RR_OP ( 28, sll,   0xffffffff, 0xffffffff, 0  );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"ffffffff" ) report "Test failed" severity error;

    --TEST_RR_OP ( 29, sll,   0xfffffffe, 0xffffffff, 1  );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000001"; -- 1
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"fffffffe" ) report "Test failed" severity error;

    --TEST_RR_OP ( 30, sll,   0xffffff80, 0xffffffff, 7  );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000007"; -- 7
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"ffffff80" ) report "Test failed" severity error;

    --TEST_RR_OP ( 31, sll,   0xffffc000, 0xffffffff, 14 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"0000000E"; -- 14
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"ffffc000" ) report "Test failed" severity error;

    --TEST_RR_OP ( 32, sll,   0x80000000, 0xffffffff, 31 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"0000001F"; -- 31
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000" ) report "Test failed" severity error;

    --TEST_RR_OP ( 33, sll,   0x21212121, 0x21212121, 0  );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"21212121" ) report "Test failed" severity error;

    --TEST_RR_OP ( 34, sll,   0x42424242, 0x21212121, 1  );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000001"; -- 1
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"42424242" ) report "Test failed" severity error;

    --TEST_RR_OP ( 35, sll,   0x90909080, 0x21212121, 7  );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000007"; -- 7
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"90909080" ) report "Test failed" severity error;

    --TEST_RR_OP ( 36, sll,   0x48484000, 0x21212121, 14 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"0000000E"; -- 14
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"48484000" ) report "Test failed" severity error;

    --TEST_RR_OP ( 37, sll,   0x80000000, 0x21212121, 31 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"0000001F"; -- 31
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000" ) report "Test failed" severity error;

    --TEST_RR_OP ( 38, sll,   0x21212121, 0x21212121, 0xffffffc0 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"ffffffc0"; -- ?
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"21212121" ) report "Test failed" severity error;

    --TEST_RR_OP ( 39, sll,   0x42424242, 0x21212121, 0xffffffc1 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"ffffffc1"; -- ?
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"42424242" ) report "Test failed" severity error;

    --TEST_RR_OP ( 40, sll,   0x90909080, 0x21212121, 0xffffffc7 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"ffffffc7"; -- ?
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"90909080" ) report "Test failed" severity error;

    --TEST_RR_OP ( 41, sll,   0x48484000, 0x21212121, 0xffffffce );
    rs1_v             <= x"21212121";
    rs2_v             <= x"ffffffce"; -- ?
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"48484000" ) report "Test failed" severity error; 

    ------------------------------------------------------------------------
    --
    --
    -- SLL (rs_1 + imm)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "001";
    func7             <= "0000000";
    
    -- TEST_IMM_OP( 42, slli,  0x00000001, 0x00000001, 0  ); 
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP( 43, slli,  0x00000002, 0x00000001, 1  );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001"; -- 1
    wait for 10 ns;
    assert(aluOut_v  =  x"00000002") report "Test failed" severity error;

    -- TEST_IMM_OP( 44, slli,  0x00000080, 0x00000001, 7  );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000007"; -- 7
    wait for 10 ns;
    assert(aluOut_v  =  x"00000080") report "Test failed" severity error;

    -- TEST_IMM_OP( 45, slli,  0x00004000, 0x00000001, 14 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000000E"; -- 14
    wait for 10 ns;
    assert(aluOut_v  =  x"00004000") report "Test failed" severity error;

    -- TEST_IMM_OP( 46, slli,  0x80000000, 0x00000001, 31 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000001F"; -- 31
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000") report "Test failed" severity error;

    -- TEST_IMM_OP( 47, slli,  0xffffffff, 0xffffffff, 0  );
    rs1_v             <= x"FFFFFFFF";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFF") report "Test failed" severity error;

    -- TEST_IMM_OP( 48, slli,  0xfffffffe, 0xffffffff, 1  );
    rs1_v             <= x"FFFFFFFF";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001"; -- 1
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFE") report "Test failed" severity error;

    -- TEST_IMM_OP( 49, slli,  0xffffff80, 0xffffffff, 7  );
    rs1_v             <= x"FFFFFFFF";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000007"; -- 7
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFF80") report "Test failed" severity error;

    -- TEST_IMM_OP( 50, slli,  0xffffc000, 0xffffffff, 14 );
    rs1_v             <= x"FFFFFFFF";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000000E"; -- 14
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFC000") report "Test failed" severity error;

    -- TEST_IMM_OP( 51, slli,  0x80000000, 0xffffffff, 31 );
    rs1_v             <= x"FFFFFFFF";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000001F"; -- 31
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000") report "Test failed" severity error;

    -- TEST_IMM_OP( 52, slli,  0x21212121, 0x21212121, 0  );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"21212121") report "Test failed" severity error;

    -- TEST_IMM_OP( 53, slli,  0x42424242, 0x21212121, 1  );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001"; -- 1
    wait for 10 ns;
    assert(aluOut_v  =  x"42424242") report "Test failed" severity error;

    -- TEST_IMM_OP( 54, slli,  0x90909080, 0x21212121, 7  );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000007"; -- 7
    wait for 10 ns;
    assert(aluOut_v  =  x"90909080") report "Test failed" severity error;

    -- TEST_IMM_OP( 55, slli,  0x48484000, 0x21212121, 14 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000000E"; -- 14
    wait for 10 ns;
    assert(aluOut_v  =  x"48484000") report "Test failed" severity error;

    -- TEST_IMM_OP( 56, slli,  0x80000000, 0x21212121, 31 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000001F"; -- 31
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SLL (rs_1 + imm)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '1';
    isCustom          <= '0';
    func3             <= "101";
    func7             <= "0100000";
        
    --TEST_RR_OP ( 57,  sra,  0x80000000, 0x80000000, 0  ); 
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000") report "Test failed" severity error;

    --TEST_RR_OP ( 58,  sra,  0xc0000000, 0x80000000, 1  );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000001"; -- 1
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"C0000000") report "Test failed" severity error;

    --TEST_RR_OP ( 59,  sra,  0xff000000, 0x80000000, 7  );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000007"; -- 7
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FF000000") report "Test failed" severity error;

    --TEST_RR_OP ( 60,  sra,  0xfffe0000, 0x80000000, 14 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"0000000E"; -- 14
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFE0000") report "Test failed" severity error;

    --TEST_RR_OP ( 61,  sra,  0xffffffff, 0x80000001, 31 );
    rs1_v             <= x"80000001";
    rs2_v             <= x"0000001F"; -- 31
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFF") report "Test failed" severity error;

    --TEST_RR_OP ( 62,  sra,  0x7fffffff, 0x7fffffff, 0  );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"7FFFFFFF") report "Test failed" severity error;

    --TEST_RR_OP ( 63,  sra,  0x3fffffff, 0x7fffffff, 1  );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000001"; -- 1
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"3FFFFFFF") report "Test failed" severity error;

    --TEST_RR_OP ( 64,  sra,  0x00ffffff, 0x7fffffff, 7  );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000007"; -- 7
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00FFFFFF") report "Test failed" severity error;

    --TEST_RR_OP ( 65,  sra,  0x0001ffff, 0x7fffffff, 14 );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"0000000E"; -- 14
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"0001FFFF") report "Test failed" severity error;

    --TEST_RR_OP ( 66,  sra,  0x00000000, 0x7fffffff, 31 );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"0000001F"; -- 31
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP ( 67,  sra,  0x81818181, 0x81818181, 0  );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"81818181") report "Test failed" severity error;

    --TEST_RR_OP ( 68,  sra,  0xc0c0c0c0, 0x81818181, 1  );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000001"; -- 1
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"C0C0C0C0") report "Test failed" severity error;

    --TEST_RR_OP ( 69,  sra,  0xff030303, 0x81818181, 7  );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000007"; -- 7
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FF030303") report "Test failed" severity error;

    --TEST_RR_OP ( 70,  sra,  0xfffe0606, 0x81818181, 14 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"0000000E"; -- 14
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFE0606") report "Test failed" severity error;

    --TEST_RR_OP ( 71,  sra,  0xffffffff, 0x81818181, 31 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"0000001F"; -- 31
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFF") report "Test failed" severity error;

    --TEST_RR_OP ( 72,  sra,  0x81818181, 0x81818181, 0xffffffc0 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"FFFFFFC0"; -- -64 (interpreted as 0)
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"81818181") report "Test failed" severity error;

    --TEST_RR_OP ( 73,  sra,  0xc0c0c0c0, 0x81818181, 0xffffffc1 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"FFFFFFC1"; -- -63 (interpreted as 1)
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"C0C0C0C0") report "Test failed" severity error;

    --TEST_RR_OP ( 74,  sra,  0xff030303, 0x81818181, 0xffffffc7 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"FFFFFFC7"; -- -57 (interpreted as 7)
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FF030303") report "Test failed" severity error;

    --TEST_RR_OP ( 75,  sra,  0xfffe0606, 0x81818181, 0xffffffce );
    rs1_v             <= x"81818181";
    rs2_v             <= x"FFFFFFCE"; -- -50 (interpreted as 14)
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFE0606") report "Test failed" severity error;

    --TEST_RR_OP ( 76,  sra,  0xffffffff, 0x81818181, 0xffffffff );
    rs1_v             <= x"81818181";
    rs2_v             <= x"FFFFFFFF"; -- -1 (interpreted as 31)
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFF") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SRAI (rs_1 + imm)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';
    isBranch          <= '0';
    isAluSubstraction <= '1';
    isCustom          <= '0';
    func3             <= "101";
    func7             <= "0100000";

    --TEST_IMM_OP( 77,  srai, 0x00000000, 0x00000000, 0  );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_IMM_OP( 78,  srai, 0xc0000000, 0x80000000, 1  );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000"; -- 1
    imm_v             <= x"00000001"; -- 1
    wait for 10 ns;
    assert(aluOut_v  =  x"C0000000") report "Test failed" severity error;

    --TEST_IMM_OP( 79,  srai, 0xff000000, 0x80000000, 7  );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000"; -- 7
    imm_v             <= x"00000007"; -- 7
    wait for 10 ns;
    assert(aluOut_v  =  x"FF000000") report "Test failed" severity error;

    --TEST_IMM_OP( 80,  srai, 0xfffe0000, 0x80000000, 14 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000"; -- 14
    imm_v             <= x"0000000E"; -- 14
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFE0000") report "Test failed" severity error;

    --TEST_IMM_OP( 81,  srai, 0xffffffff, 0x80000001, 31 );
    rs1_v             <= x"80000001";
    rs2_v             <= x"00000000"; -- 31
    imm_v             <= x"0000001F"; -- 31
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFF") report "Test failed" severity error;

    --TEST_IMM_OP( 82,  srai, 0x7fffffff, 0x7fffffff, 0  );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"7FFFFFFF") report "Test failed" severity error;

    --TEST_IMM_OP( 83,  srai, 0x3fffffff, 0x7fffffff, 1  );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000000"; -- 1
    imm_v             <= x"00000001"; -- 1
    wait for 10 ns;
    assert(aluOut_v  =  x"3FFFFFFF") report "Test failed" severity error;

    --TEST_IMM_OP( 84,  srai, 0x00ffffff, 0x7fffffff, 7  );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000000"; -- 7
    imm_v             <= x"00000007"; -- 7
    wait for 10 ns;
    assert(aluOut_v  =  x"00FFFFFF") report "Test failed" severity error;

    --TEST_IMM_OP( 85,  srai, 0x0001ffff, 0x7fffffff, 14 );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000000"; -- 14
    imm_v             <= x"0000000E"; -- 14
    wait for 10 ns;
    assert(aluOut_v  =  x"0001FFFF") report "Test failed" severity error;

    --TEST_IMM_OP( 86,  srai, 0x00000000, 0x7fffffff, 31 );
    rs1_v             <= x"7FFFFFFF";
    rs2_v             <= x"00000000"; -- 31
    imm_v             <= x"0000001F"; -- 31
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_IMM_OP( 87,  srai, 0x81818181, 0x81818181, 0  );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000000"; -- 0
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"81818181") report "Test failed" severity error;

    --TEST_IMM_OP( 88,  srai, 0xc0c0c0c0, 0x81818181, 1  );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000000"; -- 1
    imm_v             <= x"00000001"; -- 1
    wait for 10 ns;
    assert(aluOut_v  =  x"C0C0C0C0") report "Test failed" severity error;

    --TEST_IMM_OP( 89,  srai, 0xff030303, 0x81818181, 7  );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000000"; -- 7
    imm_v             <= x"00000007"; -- 7
    wait for 10 ns;
    assert(aluOut_v  =  x"FF030303") report "Test failed" severity error;

    --TEST_IMM_OP( 90,  srai, 0xfffe0606, 0x81818181, 14 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000000"; -- 14
    imm_v             <= x"0000000E"; -- 14
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFE0606") report "Test failed" severity error;

    --TEST_IMM_OP( 91,  srai, 0xffffffff, 0x81818181, 31 );
    rs1_v             <= x"81818181";
    rs2_v             <= x"00000000"; -- 31
    imm_v             <= x"0000001F"; -- 31
    wait for 10 ns;
    assert(aluOut_v  =  x"FFFFFFFF") report "Test failed" severity error;
 

    ------------------------------------------------------------------------
    --
    --
    -- SRL (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "101";
    func7             <= "0100000";


    --TEST_RR_OP ( 92,  srl,  0x21212121, 0x21212121, 0xffffffc0 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"FFFFFFC0"; -- -64
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"21212121") report "Test failed" severity error;

    --TEST_RR_OP ( 93,  srl,  0x10909090, 0x21212121, 0xffffffc1 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"FFFFFFC1"; -- -63 (interpreted as 1)
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"10909090") report "Test failed" severity error;

    --TEST_RR_OP ( 94,  srl,  0x00424242, 0x21212121, 0xffffffc7 );
    rs1_v             <= x"21212121";
    rs2_v             <= x"FFFFFFC7"; -- -57 (interpreted as 7)
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"00424242") report "Test failed" severity error;

    --TEST_RR_OP ( 95,  srl,  0x00008484, 0x21212121, 0xffffffce );
    rs1_v             <= x"21212121";
    rs2_v             <= x"FFFFFFCE"; -- -50 (interpreted as 14)
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"00008484") report "Test failed" severity error;

    --TEST_RR_OP ( 96,  srl,  0x00000000, 0x21212121, 0xffffffff );
    rs1_v             <= x"21212121";
    rs2_v             <= x"FFFFFFFF"; -- -1 (interpreted as 31)
    imm_v             <= x"00000000"; -- 0
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SRL (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '0';
    isCustom          <= '0';
    func3             <= "101";
    func7             <= "0100000";

--    TEST_SRLI  ( 97,        0x80000000, 0  );
--    TEST_SRLI  ( 98,        0x80000000, 1  );
--    TEST_SRLI  ( 99,        0x80000000, 7  );
--    TEST_SRLI  (100,        0x80000000, 14 );
--    TEST_SRLI  (101,        0x80000001, 31 );
--    TEST_SRLI  (102,        0xffffffff, 0  );
--    TEST_SRLI  (103,        0xffffffff, 1  );
--    TEST_SRLI  (104,        0xffffffff, 7  );
--    TEST_SRLI  (105,        0xffffffff, 14 );
--    TEST_SRLI  (106,        0xffffffff, 31 );
--    TEST_SRLI  (107,        0x21212121, 0  );
--    TEST_SRLI  (108,        0x21212121, 1  );
--    TEST_SRLI  (109,        0x21212121, 7  );
--    TEST_SRLI  (110,        0x21212121, 14 );
--    TEST_SRLI  (111,        0x21212121, 31 );
 
    ------------------------------------------------------------------------
    --
    --
    -- SRL (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';
    isBranch          <= '0';
    isAluSubstraction <= '1';
    isCustom          <= '0';
    func3             <= "000";
    func7             <= "0100000";

--  TEST_RR_OP (112,  sub,  0x00000000, 0x00000000, 0x00000000 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

--  TEST_RR_OP (113,  sub,  0x00000000, 0x00000001, 0x00000001 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000"; -- Non utilisé ici
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

--  TEST_RR_OP (114,  sub,  0xfffffffc, 0x00000003, 0x00000007 );
    rs1_v             <= x"00000003";
    rs2_v             <= x"00000007";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"fffffffc") report "Test failed" severity error;

    -- TEST_RR_OP (115,  sub,  0x00008000, 0x00000000, 0xffff8000 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000"; -- Non utilisé ici
    wait for 10 ns;
    assert(aluOut_v  =  x"00008000") report "Test failed" severity error;

    -- TEST_RR_OP (116,  sub,  0x80000000, 0x80000000, 0x00000000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80000000") report "Test failed" severity error;

    -- TEST_RR_OP (117,  sub,  0x80008000, 0x80000000, 0xffff8000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80008000") report "Test failed" severity error;

    -- TEST_RR_OP (118,  sub,  0xffff8001, 0x00000000, 0x00007fff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"ffff8001") report "Test failed" severity error;

    -- TEST_RR_OP (119,  sub,  0x7fffffff, 0x7fffffff, 0x00000000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"7fffffff") report "Test failed" severity error;

    -- TEST_RR_OP (120,  sub,  0x7fff8000, 0x7fffffff, 0x00007fff );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"7fff8000") report "Test failed" severity error;

    -- TEST_RR_OP (121,  sub,  0x7fff8001, 0x80000000, 0x00007fff );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"7fff8001") report "Test failed" severity error;

    -- TEST_RR_OP (122,  sub,  0x80007fff, 0x7fffffff, 0xffff8000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"80007fff") report "Test failed" severity error;

    -- TEST_RR_OP (123,  sub,  0x00000001, 0x00000000, 0xffffffff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"ffffffff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (124,  sub,  0xfffffffe, 0xffffffff, 0x00000001 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"fffffffe") report "Test failed" severity error;

    -- TEST_RR_OP (125,  sub,  0x00000000, 0xffffffff, 0xffffffff );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"ffffffff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- XOR (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';       -- rs_1 and rs_2
    isBranch          <= '0';       --
    isAluSubstraction <= '0';       --
    isCustom          <= '0';       --
    func3             <= "100";     -- XOR
    func7             <= "0000000"; --

    -- TEST_RR_OP (126,  xor,  0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
    rs1_v             <= x"ff00ff00";
    rs2_v             <= x"0f0f0f0f";
    imm_v             <= x"00000000"; -- Non utilisé ici
    wait for 10 ns;
    assert(aluOut_v  =  x"f00ff00f") report "Test failed" severity error;

    -- TEST_RR_OP (127,  xor,  0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
    rs1_v             <= x"0ff00ff0";
    rs2_v             <= x"f0f0f0f0";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"ff00ff00") report "Test failed" severity error;

    -- TEST_RR_OP (128,  xor,  0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
    rs1_v             <= x"00ff00ff";
    rs2_v             <= x"0f0f0f0f";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"0ff00ff0") report "Test failed" severity error;

    -- TEST_RR_OP (129,  xor,  0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );
    rs1_v             <= x"f00ff00f";
    rs2_v             <= x"f0f0f0f0";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00ff00ff") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- XORI (rs_1 + imm_v)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';       -- rs_1 and imm_v
    isBranch          <= '0';       --
    isAluSubstraction <= '0';       --
    isCustom          <= '0';       --
    func3             <= "100";     -- XOR
    func7             <= "0000000"; --

    -- TEST_IMM_OP(130,  xori, 0xff00f00f, 0x00ff0f00, 0xffffff0f );
    rs1_v             <= x"00ff0f00";
    rs2_v             <= x"00000000";
    imm_v             <= x"ffffff0f";
    wait for 10 ns;
    assert(aluOut_v  =  x"ff00f00f") report "Test failed" severity error;
 
    -- TEST_IMM_OP(131,  xori, 0x0ff00f00, 0x0ff00ff0, 0x000000f0 );
    rs1_v             <= x"0ff00ff0";
    rs2_v             <= x"00000000";
    imm_v             <= x"000000f0";
    wait for 10 ns;
    assert(aluOut_v  =  x"0ff00f00") report "Test failed" severity error;

    -- TEST_IMM_OP(132,  xori, 0x00ff0ff0, 0x00ff08ff, 0x0000070f );
    rs1_v             <= x"00ff08ff";
    rs2_v             <= x"00000000";
    imm_v             <= x"0000070f";
    wait for 10 ns;
    assert(aluOut_v  =  x"00ff0ff0") report "Test failed" severity error;

    -- TEST_IMM_OP(133,  xori, 0xf00ff0ff, 0xf00ff00f, 0x000000f0 );
    rs1_v             <= x"f00ff00f";
    rs2_v             <= x"00000000";
    imm_v             <= x"000000f0";
    wait for 10 ns;
    assert(aluOut_v  =  x"f00ff0ff") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SLT (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';       -- rs_1 and rs_2
    isBranch          <= '0';       --
    isAluSubstraction <= '0';       --
    isCustom          <= '0';       --
    func3             <= "010";     -- SLT
    func7             <= "0000000"; --

    -- TEST_RR_OP (134,  slt,   0, 0x00000000, 0x00000000 ); 
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (135,  slt,   0, 0x00000001, 0x00000001 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (136,  slt,   1, 0x00000003, 0x00000007 );
    rs1_v             <= x"00000003";
    rs2_v             <= x"00000007";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (137,  slt,   0, 0x00000007, 0x00000003 );
    rs1_v             <= x"00000007";
    rs2_v             <= x"00000003";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (138,  slt,   0, 0x00000000, 0xffff8000 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (139,  slt,   1, 0x80000000, 0x00000000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (140,  slt,   1, 0x80000000, 0xffff8000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (141,  slt,   1, 0x00000000, 0x00007fff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (142,  slt,   0, 0x7fffffff, 0x00000000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (143,  slt,   0, 0x7fffffff, 0x00007fff );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (144,  slt,   1, 0x80000000, 0x00007fff );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (145,  slt,   0, 0x7fffffff, 0xffff8000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (146,  slt,   0, 0x00000000, 0xffffffff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"ffffffff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_RR_OP (147,  slt,   1, 0xffffffff, 0x00000001 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_RR_OP (148,  slt,   0, 0xffffffff, 0xffffffff );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"ffffffff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SLTI (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';       -- rs_1 and rs_2
    isBranch          <= '0';       --
    isAluSubstraction <= '0';       --
    isCustom          <= '0';       --
    func3             <= "010";     -- SLT
    func7             <= "0000000"; --

    -- TEST_IMM_OP(149,  slti,  0, 0x00000000, 0x00000000 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(150,  slti,  0, 0x00000001, 0x00000001 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(151,  slti,  1, 0x00000003, 0x00000007 );
    rs1_v             <= x"00000003";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000007";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(152,  slti,  0, 0x00000007, 0x00000003 );
    rs1_v             <= x"00000007";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000003";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(153,  slti,  0, 0x00000000, 0xfffff800 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"fffff800";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(154,  slti,  1, 0x80000000, 0x00000000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(155,  slti,  1, 0x80000000, 0xfffff800 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"fffff800";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(156,  slti,  1, 0x00000000, 0x000007ff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"000007ff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(157,  slti,  0, 0x7fffffff, 0x00000000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(158,  slti,  0, 0x7fffffff, 0x000007ff );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"000007ff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(159,  slti,  1, 0x80000000, 0x000007ff );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"000007ff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(160,  slti,  0, 0x7fffffff, 0xfffff800 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"fffff800";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(161,  slti,  0, 0x00000000, 0xffffffff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"ffffffff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(162,  slti,  1, 0xffffffff, 0x00000001 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(163,  slti,  0, 0xffffffff, 0xffffffff );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"ffffffff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SLTU (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '1';       -- rs_1 and rs_2
    isBranch          <= '0';       --
    isAluSubstraction <= '0';       --
    isCustom          <= '0';       --
    func3             <= "011";     -- SLTU
    func7             <= "0000000"; --

    --TEST_RR_OP (164,  sltu,  0, 0x00000000, 0x00000000 ); 
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (165,  sltu,  0, 0x00000001, 0x00000001 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (166,  sltu,  1, 0x00000003, 0x00000007 );
    rs1_v             <= x"00000003";
    rs2_v             <= x"00000007";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    --TEST_RR_OP (167,  sltu,  0, 0x00000007, 0x00000003 );
    rs1_v             <= x"00000007";
    rs2_v             <= x"00000003";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (168,  sltu,  1, 0x00000000, 0xffff8000 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    --TEST_RR_OP (169,  sltu,  0, 0x80000000, 0x00000000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (170,  sltu,  1, 0x80000000, 0xffff8000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    --TEST_RR_OP (171,  sltu,  1, 0x00000000, 0x00007fff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    --TEST_RR_OP (172,  sltu,  0, 0x7fffffff, 0x00000000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (173,  sltu,  0, 0x7fffffff, 0x00007fff );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (174,  sltu,  0, 0x80000000, 0x00007fff );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00007fff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (175,  sltu,  1, 0x7fffffff, 0xffff8000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"ffff8000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    --TEST_RR_OP (176,  sltu,  1, 0x00000000, 0xffffffff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"ffffffff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    --TEST_RR_OP (177,  sltu,  0, 0xffffffff, 0x00000001 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000001";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    --TEST_RR_OP (178,  sltu,  0, 0xffffffff, 0xffffffff );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"ffffffff";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- SLTU (rs_1 + rs_2)
    --
    --
    ------------------------------------------------------------------------

    isALUreg          <= '0';       -- rs_1 and rs_2
    isBranch          <= '0';       --
    isAluSubstraction <= '0';       --
    isCustom          <= '0';       --
    func3             <= "011";     -- SLTU
    func7             <= "0000000"; --

    -- TEST_IMM_OP(179,  sltiu, 0, 0x00000000, 0x00000000 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(180,  sltiu, 0, 0x00000001, 0x00000001 );
    rs1_v             <= x"00000001";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(181,  sltiu, 1, 0x00000003, 0x00000007 );
    rs1_v             <= x"00000003";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000007";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(182,  sltiu, 0, 0x00000007, 0x00000003 );
    rs1_v             <= x"00000007";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000003";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(183,  sltiu, 1, 0x00000000, 0xfffff800 );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"fffff800";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(184,  sltiu, 0, 0x80000000, 0x00000000 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(185,  sltiu, 1, 0x80000000, 0xfffff800 );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"fffff800";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(186,  sltiu, 1, 0x00000000, 0x000007ff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"000007ff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(187,  sltiu, 0, 0x7fffffff, 0x00000000 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000000";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(188,  sltiu, 0, 0x7fffffff, 0x000007ff );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"000007ff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(189,  sltiu, 0, 0x80000000, 0x000007ff );
    rs1_v             <= x"80000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"000007ff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(190,  sltiu, 1, 0x7fffffff, 0xfffff800 );
    rs1_v             <= x"7fffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"fffff800";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(191,  sltiu, 1, 0x00000000, 0xffffffff );
    rs1_v             <= x"00000000";
    rs2_v             <= x"00000000";
    imm_v             <= x"ffffffff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000001") report "Test failed" severity error;

    -- TEST_IMM_OP(192,  sltiu, 0, 0xffffffff, 0x00000001 );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"00000001";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    -- TEST_IMM_OP(193,  sltiu, 0, 0xffffffff, 0xffffffff );
    rs1_v             <= x"ffffffff";
    rs2_v             <= x"00000000";
    imm_v             <= x"ffffffff";
    wait for 10 ns;
    assert(aluOut_v  =  x"00000000") report "Test failed" severity error;

    ------------------------------------------------------------------------
    --
    --
    -- Fin des tests non exhaustifs car il manque par exemple les BRANCHs
    --
    --
    ------------------------------------------------------------------------

    wait;
  end process;


end;

