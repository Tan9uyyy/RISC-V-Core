-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity alu_mult_tb is
end;

architecture bench of alu_mult_tb is

  component alu_mult
    PORT (
      clk_i      :  in STD_LOGIC;
      rstn_i     :  in STD_LOGIC;
      rs1_i      :  in STD_LOGIC_VECTOR (31 downto 0);
      rs2_i      :  in STD_LOGIC_VECTOR (31 downto 0);
      en_i       :  in STD_LOGIC;
      func3_i    :  in STD_LOGIC_VECTOR ( 2 downto 0);
      mul_o      : out STD_LOGIC_VECTOR (31 downto 0);
      finished_o : out STD_LOGIC;
      busy_o     : out STD_LOGIC
   );
  end component;

  signal clk_i      : STD_LOGIC;
  signal rstn_i     : STD_LOGIC;
  signal rs1_i      : STD_LOGIC_VECTOR (31 downto 0);
  signal rs2_i      : STD_LOGIC_VECTOR (31 downto 0);
  signal en_i       : STD_LOGIC;
  signal func3_i    : STD_LOGIC_VECTOR ( 2 downto 0);
  signal mul_o      : STD_LOGIC_VECTOR (31 downto 0);
  signal finished_o : STD_LOGIC ;
  signal busy_o     : STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: alu_mult port map ( clk_i      => clk_i,
                           rstn_i     => rstn_i,
                           rs1_i      => rs1_i,
                           rs2_i      => rs2_i,
                           en_i       => en_i,
                           func3_i    => func3_i,
                           mul_o      => mul_o,
                           finished_o => finished_o,
                           busy_o     => busy_o );

  stimulus: process
  begin  
    rstn_i     <= '0';

  -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED(  0, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED(  0, 32) );
    func3_i    <= "000"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;
  
    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED(  1, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED(  1, 32) );
    func3_i    <= "000"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED( 11, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED( 11, 32) );
    func3_i    <= "000"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;

    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED( 255, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_UNSIGNED( 255, 32) );
    func3_i    <= "000"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;


    -- Put initialisation code here
    rs1_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 65535, 32) );
    rs2_i      <= STD_LOGIC_VECTOR( TO_SIGNED( 65535, 32) );
    func3_i    <= "000"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;

    -- Put initialisation code here
    rs1_i      <= x"00010000";
    rs2_i      <= x"00010000";
    func3_i    <= "000"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;

    -- Put initialisation code here
    rs1_i      <= x"00010000";
    rs2_i      <= x"00010000";
    func3_i    <= "001"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;

    -- Put initialisation code here
    rs1_i      <= x"00100000";
    rs2_i      <= x"00100000";
    func3_i    <= "001"; -- 32 bits de poids faible
    en_i       <= '1'; wait for 1 * clock_period;
    en_i       <= '0'; wait for 4 * clock_period;

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

