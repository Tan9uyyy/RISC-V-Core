library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package registers_pass_pkg is

   COMPONENT registers_pass is
   Port ( 
      CLOCK    : in   STD_LOGIC;
      RESET    : in   STD_LOGIC;
      RS1_id   : IN   STD_LOGIC_VECTOR( 4 DOWNTO 0);
      RS2_id   : IN   STD_LOGIC_VECTOR( 4 DOWNTO 0);
      e_hold   : IN   STD_LOGIC;
      RD_id    : IN   STD_LOGIC_VECTOR( 4 DOWNTO 0);
      RD_id_we : IN   STD_LOGIC;
      DATA_rd  : IN   STD_LOGIC_VECTOR(31 DOWNTO 0);
      DATA_rs1 : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
      DATA_rs2 : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
   );
   end COMPONENT;

end package;
