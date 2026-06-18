library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package mem_store_pkg is

   component mem_store is 
      Port ( 
         ADDR_W     : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
         DATA_W     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
         is_byte    : IN  STD_LOGIC;
         is_half    : IN  STD_LOGIC;
         data_mask  : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
         data_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
   end component;

end package;