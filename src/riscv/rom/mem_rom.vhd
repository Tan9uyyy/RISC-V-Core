library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

use work.riscv_types.all;
use work.riscv_config.all;

entity mem_rom is 
    Port ( 
        CLOCK   : IN  STD_LOGIC;
        ENABLE  : IN  STD_LOGIC;
        ADDR_R  : IN  STD_LOGIC_VECTOR(ROM_ADDR-1  DOWNTO 0); -- -2 bits because 32b words and not bytes
        DATA_O  : OUT STD_LOGIC_VECTOR(ROM_WIDTH-1 DOWNTO 0)
     );
end mem_rom;


architecture arch of mem_rom is

    TYPE rom_type IS ARRAY (0 TO (ROM_DEPTH-1)) OF STD_LOGIC_VECTOR (ROM_WIDTH-1 DOWNTO 0);

    impure function InitRomFromFile(RamFileName : in string)
      return rom_type is
        file RomFile         : text open read_mode is RamFileName;
        variable RomFileLine : line;
        variable ROM         : rom_type;
    begin
        --REPORT "-- PROGRAM MEMORY ROM";
        --REPORT "-- ROM_ADDR  = " & integer'image(ROM_ADDR);
        --REPORT "-- ROM_DEPTH = " & integer'image(ROM_DEPTH);
        --REPORT "-- ROM_WIDTH = " & integer'image(ROM_WIDTH);
        --REPORT "-- ROM_FILE  = " & ROM_FILE;
        for I in rom_type'range loop
            readline(RomFile, RomFileLine);
            hread(RomFileLine, ROM(I));
        end loop;
        --REPORT "-- FIN DE CHARGEMENT";
        return ROM;
    end function;

    SIGNAL memory : rom_type := InitRomFromFile( ROM_FILE );
    SIGNAL ADDR   : STD_LOGIC_VECTOR(ROM_ADDR-2-1 DOWNTO 0); -- -2 bits because 32b words and not bytes

begin

    ADDR <= ADDR_R(ROM_ADDR-1 downto 2);

    process(CLOCK)
    begin 
        if rising_edge(CLOCK) then 
            if ENABLE = '1' then
                DATA_O <= memory(to_integer(unsigned(ADDR)));
            end if;
        end if;
    end process;
   
end arch;
