library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

use work.riscv_config.all;

entity mem_ram_dp is
    Port ( 
        CLOCK    : IN  STD_LOGIC;

        ADDR_R   : IN  STD_LOGIC_VECTOR(RAM_ADDR-1  DOWNTO 0);
        DATA_R   : OUT STD_LOGIC_VECTOR(RAM_WIDTH-1 DOWNTO 0);

        ADDR_W   : IN  STD_LOGIC_VECTOR(RAM_ADDR-1  DOWNTO 0);
        DATA_W   : IN  STD_LOGIC_VECTOR(RAM_WIDTH-1 DOWNTO 0);
        WRITE_M  : IN  STD_LOGIC_VECTOR(          3 DOWNTO 0)
     );
end mem_ram_dp;


architecture arch of mem_ram_dp is

    TYPE   ram_type IS ARRAY (0 TO (RAM_DEPTH-1)) OF STD_LOGIC_VECTOR (31 DOWNTO 0);

   impure function InitRomFromFile(RamFileName : in string)
      return ram_type is
--       FILE RamFile         : text is in RamFileName;
         file RamFile         : text open read_mode is RamFileName;
         variable RamFileLine : line;
         variable RAM         : ram_type;
   begin
      for I in ram_type'range loop
         readline(RamFile, RamFileLine);
         hread(RamFileLine, RAM(I));
      end loop;
      return RAM;
   end function;

   SIGNAL memory : ram_type := InitRomFromFile( RAM_FILE );

   SIGNAL R_ADDR : STD_LOGIC_VECTOR(RAM_ADDR-2-1 DOWNTO 0); -- -2 bits because 32b words and not bytes
   SIGNAL W_ADDR : STD_LOGIC_VECTOR(RAM_ADDR-2-1 DOWNTO 0); -- -2 bits because 32b words and not bytes

begin

   R_ADDR <= ADDR_R(RAM_ADDR-1 downto 2);
   W_ADDR <= ADDR_W(RAM_ADDR-1 downto 2);

   process(CLOCK)
      variable w_index : integer;
   begin
      if rising_edge(CLOCK) then
         -- Read port (synchronous read)
         DATA_R <= memory(to_integer(unsigned(R_ADDR)));

         -- Write port with byte-level write mask
         w_index := to_integer(unsigned(W_ADDR));
         if WRITE_M(0) = '1' then
            memory(w_index)( 7 downto  0) <= DATA_W( 7 downto  0);
         end if;
         if WRITE_M(1) = '1' then
            memory(w_index)(15 downto  8) <= DATA_W(15 downto  8);
         end if;
         if WRITE_M(2) = '1' then
            memory(w_index)(23 downto 16) <= DATA_W(23 downto 16);
         end if;
         if WRITE_M(3) = '1' then
            memory(w_index)(31 downto 24) <= DATA_W(31 downto 24);
         end if;
      end if;
   end process;

end arch;
