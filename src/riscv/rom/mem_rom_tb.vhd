-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.riscv_types.all;
use work.riscv_config.all;

entity mem_rom_tb is
end;

architecture bench of mem_rom_tb is

  constant RAM_ADDR_BITS : integer := 14;

  component mem_rom 
      Port ( 
          CLOCK   : IN  STD_LOGIC;
          ENABLE  : IN  STD_LOGIC;
          ADDR_R  : IN  STD_LOGIC_VECTOR(ROM_ADDR-1 DOWNTO 0);
          DATA_O  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
       );
  end component;

  signal CLOCK: STD_LOGIC;
  signal ENABLE: STD_LOGIC;
  signal ADDR_R: STD_LOGIC_VECTOR(ROM_ADDR-1 DOWNTO 0);
  signal DATA_O: STD_LOGIC_VECTOR(31 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: mem_rom   port map ( CLOCK         => CLOCK,
                            ENABLE        => ENABLE,
                            ADDR_R        => ADDR_R,
                            DATA_O        => DATA_O );

  stimulus: process
  begin
    
    ENABLE <= '0';
    ADDR_R <= (others => '0');
    wait for clock_period;

    -- ==========================================
    -- ATTENTION : En fonction de firmware/PROGROM.mem, l'instruction 1 est différente ! (à faire concorder les 2 pour avoir un bon test).
    -- ==========================================

    -- ==========================================
    -- TEST 1 : On vérifie qu'à l'adresse 4, on ressort bien l'instruction 1.
    -- ==========================================
    ENABLE <= '1';
    ADDR_R <= std_logic_vector(to_unsigned(4, ROM_ADDR));
    wait for clock_period;
    assert DATA_O = x"04800713" report "DATA_O ne vaut pas l'instruction 1 : 04800713" severity error;

    -- ==========================================
    -- TEST 2 : On vérifie qu'à ENABLE='0', DATA_O n'est pas modifié.
    -- ==========================================
    ENABLE <= '0';
    ADDR_R <= std_logic_vector(to_unsigned(0, ROM_ADDR));
    wait for clock_period;
    assert DATA_O = x"04800713" report "DATA_O ne vaut pas l'instruction 1 : 04800713 (il a été modifié malgré ENABLE=0)" severity error;

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

