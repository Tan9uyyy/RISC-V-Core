library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.riscv_config.all;

package mem_rom_pkg is

    COMPONENT mem_rom is 
    Port ( 
        CLOCK   : IN  STD_LOGIC;
        ENABLE  : IN  STD_LOGIC;
        ADDR_R  : IN  STD_LOGIC_VECTOR(ROM_ADDR-1  DOWNTO 0);
        DATA_O  : OUT STD_LOGIC_VECTOR(ROM_WIDTH-1 DOWNTO 0)
     );
    end COMPONENT;

end package;
