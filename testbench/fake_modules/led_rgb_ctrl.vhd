----------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Author:  Bertrand LE GAL
--          Copyright 2023 ENSSAT / University of Rennes / IRISA lab.
----------------------------------------------------------------------------
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:
--
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity led_rgb_ctrl is
  Port ( 
    clock     : in   STD_LOGIC;
    reset     : in   STD_LOGIC;
    data_i    : IN   STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données à écrire
    data_o    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données lues à l'adresse
    write_en  : IN   STD_LOGIC;                     -- validation d'écriture
    led_r_o   : OUT  STD_LOGIC;
    led_g_o   : OUT  STD_LOGIC;
    led_b_o   : OUT  STD_LOGIC
  );
end led_rgb_ctrl;


architecture arch of led_rgb_ctrl is

    SIGNAL buff_data_i   : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL unique_i  : integer := 0;

begin

    --
    --
    --

    process(clock)
      variable rr : integer;
      variable gg : integer;
      variable bb : integer;
    begin
      if rising_edge(clock) then
          IF (RESET = '1') and (unique_i = 0) THEN
              buff_data_i   <= x"00000000";
              printf("(--)\n");
              printf("(--) RGB LED controler\n");
              printf("(--)\n");
        elsif write_en = '1' then
              buff_data_i   <= data_i;
              rr := to_integer( unsigned( data_i( 7 downto  0)) );
              gg := to_integer( unsigned( data_i(15 downto  8)) );
              bb := to_integer( unsigned( data_i(23 downto 16)) );
              printf("(--) RGB LED controler write");
              printf("(R = %3.3d : ", rr);
              printf(" G = %3.3d : ", gg);
              printf(" B = %3.3d)\n", bb);
          end if;
      end if;
  end process;

  data_o <= buff_data_i;

end arch;
 

