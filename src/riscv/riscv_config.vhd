library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Package Declaration Section
package riscv_config is

    constant ROM_ADDR  : integer := 16; -- exprimée en bytes !
    constant ROM_DEPTH : integer := 2**(ROM_ADDR-2); -- words
    constant ROM_WIDTH : integer := 32;
    constant ROM_FILE  : string  := "../firmware/PROGROM.mem";

    constant RAM_ADDR  : integer := 16; -- exprimée en bytes !
    constant RAM_DEPTH : integer := 2**(RAM_ADDR-2); -- words
    constant RAM_WIDTH : integer := 32;
    constant RAM_FILE  : string  :=  "../firmware/DATARAM.mem";

end package riscv_config;

--
--
-- Package Body Section
--
--

package body riscv_config is


end package body riscv_config;
