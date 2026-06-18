-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity alu_div_tb is
end;

architecture bench of alu_div_tb is

  component alu_div
    PORT (
      clk_i      :  in STD_LOGIC;
      rstn_i     :  in STD_LOGIC;
      rs1_i      :  in STD_LOGIC_VECTOR (31 downto 0);
      rs2_i      :  in STD_LOGIC_VECTOR (31 downto 0);
      en_i       :  in STD_LOGIC;
      func3_i    :  in STD_LOGIC_VECTOR ( 2 downto 0);
      div_o      : out STD_LOGIC_VECTOR (31 downto 0);
      finished_o : out STD_LOGIC;                       -- computation is finished
      busy_o     : out STD_LOGIC
   );
  end component;

  signal clk_i      : STD_LOGIC;
  signal rstn_i     : STD_LOGIC;
  signal rs1_i      : STD_LOGIC_VECTOR (31 downto 0);
  signal rs2_i      : STD_LOGIC_VECTOR (31 downto 0);
  signal en_i       : STD_LOGIC;
  signal func3_i    : STD_LOGIC_VECTOR ( 2 downto 0);
  signal div_o      : STD_LOGIC_VECTOR (31 downto 0);
  signal finished_o : STD_LOGIC ;
  signal busy_o     : STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

  constant op_div_c    : std_logic_vector(2 downto 0) := "100"; -- div
  constant op_divu_c   : std_logic_vector(2 downto 0) := "101"; -- divu
  constant op_rem_c    : std_logic_vector(2 downto 0) := "110"; -- rem
  constant op_remu_c   : std_logic_vector(2 downto 0) := "111"; -- remu

begin

  uut: alu_div port map (  clk_i      => clk_i,
                           rstn_i     => rstn_i,
                           rs1_i      => rs1_i,
                           rs2_i      => rs2_i,
                           en_i       => en_i,
                           func3_i    => func3_i,
                           div_o      => div_o,
                           finished_o => finished_o,
                           busy_o     => busy_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  0, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  0, 32) );
    rstn_i     <= '0';
    en_i       <= '0';
    func3_i    <= op_divu_c;
    wait for 2 * clock_period;
  
    rstn_i     <= '1';
    en_i       <= '0';
    wait for 2 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  1, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  1, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;
    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  2, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  1, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;
    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 23, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  1, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;
    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 12, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  2, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;
    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 13, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  2, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;
    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  2, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 13, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;

    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 1024, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 1024, 32) );
    en_i       <= '1';
    func3_i    <= op_divu_c;
    wait for 1 * clock_period;

    en_i       <= '0';
    wait for 40 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED(  5, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 23, 32) );
    en_i       <= '1';
    func3_i    <= "110";
    wait for 1 * clock_period;

    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 0, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 0, 32) );
    en_i       <= '0';
    wait for 40 * clock_period;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk_i <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

