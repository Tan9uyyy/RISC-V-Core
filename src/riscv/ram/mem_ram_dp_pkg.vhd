library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

use work.riscv_config.all;

package mem_ram_dp_pkg is 

    COMPONENT mem_ram_dp is
        Port ( 
            CLOCK    : IN  STD_LOGIC;

            ADDR_R   : IN  STD_LOGIC_VECTOR(RAM_ADDR-1 DOWNTO 0);
            DATA_R   : OUT STD_LOGIC_VECTOR(RAM_WIDTH-1 DOWNTO 0);

            ADDR_W   : IN  STD_LOGIC_VECTOR(RAM_ADDR-1 DOWNTO 0);
            DATA_W   : IN  STD_LOGIC_VECTOR(RAM_WIDTH-1 DOWNTO 0);
            WRITE_M  : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0)
        );
    end COMPONENT;

end package;
