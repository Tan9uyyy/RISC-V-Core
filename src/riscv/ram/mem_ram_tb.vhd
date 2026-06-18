-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.riscv_config.all;

entity mem_ram_tb is
end;

architecture bench of mem_ram_tb is

  constant RAM_ADDR_BITS : integer := 14;

  component mem_ram
      Port ( 
          CLOCK   : IN  STD_LOGIC;
          ADDR_RW : IN  STD_LOGIC_VECTOR(RAM_ADDR-1 DOWNTO 0);
          ENABLE  : IN  STD_LOGIC;
          WRITE_M : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
          DATA_W  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
          DATA_R  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
       );
  end component;

  signal CLOCK: STD_LOGIC;
  signal ADDR_RW: STD_LOGIC_VECTOR(RAM_ADDR-1 DOWNTO 0);
  signal ENABLE: STD_LOGIC;
  signal WRITE_M: STD_LOGIC_VECTOR( 3 DOWNTO 0);
  signal DATA_W: STD_LOGIC_VECTOR(31 DOWNTO 0);
  signal DATA_R: STD_LOGIC_VECTOR(31 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: mem_ram port map ( CLOCK         => CLOCK,
                          ADDR_RW       => ADDR_RW,
                          ENABLE        => ENABLE,
                          WRITE_M       => WRITE_M,
                          DATA_W        => DATA_W,
                          DATA_R        => DATA_R );

  stimulus: process
  begin
  
    -- Put initialisation code here
    ADDR_RW <= (others => '0');
    ENABLE <= '0';
    WRITE_M <= (others => '0');
    DATA_W <= (others => '0');
    wait for clock_period;

    -- Put test bench stimulus code here

    -- ==========================================
    -- ATTENTION : En fonction de firmware/DATARAM.mem, la donnée est différente ! (à faire concorder les 2 pour avoir un bon test).
    -- ==========================================

    -- ==========================================
    -- TEST 1 : On vérifie qu'à l'adresse 4, on ressort bien la donnée 1.
    -- ==========================================
    ENABLE <= '1';
    ADDR_RW <= std_logic_vector(to_unsigned(4, RAM_ADDR));
    wait for clock_period;
    assert DATA_R = x"00000000" report "DATA_R ne vaut pas l'instruction 1 : 00020137" severity error;

    -- ==========================================
    -- TEST 2 : On vérifie qu'à ENABLE='0', DATA_O n'est pas modifié.
    -- ==========================================
    ENABLE <= '0';
    ADDR_RW <= std_logic_vector(to_unsigned(0, RAM_ADDR));
    wait for clock_period;
    assert DATA_R = x"00000000" report "DATA_R ne vaut pas la donnée 1 : 00020137 (il a été modifié malgré ENABLE=0)" severity error;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLOCK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

