library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.riscv_config.all;

package mem_ram_pkg is

    COMPONENT mem_ram is
    Port ( 
        CLOCK   : IN  STD_LOGIC;
        ADDR_RW : IN  STD_LOGIC_VECTOR(RAM_ADDR-1  DOWNTO 0);
        ENABLE  : IN  STD_LOGIC;
        WRITE_M : IN  STD_LOGIC_VECTOR(          3 DOWNTO 0);
        DATA_W  : IN  STD_LOGIC_VECTOR(RAM_WIDTH-1 DOWNTO 0);
        DATA_R  : OUT STD_LOGIC_VECTOR(RAM_WIDTH-1 DOWNTO 0)
     );
    end COMPONENT;

end package;
