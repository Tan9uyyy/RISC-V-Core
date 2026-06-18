library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity mem_store is 
    Port ( 
        ADDR_W     : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
        DATA_W     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        is_byte    : IN  STD_LOGIC;
        is_half    : IN  STD_LOGIC;
        data_mask  : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
        data_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
     );
end mem_store;


architecture arch of mem_store is

begin

   process(ADDR_W, DATA_W, is_byte, is_half)
   begin
      data_mask  <= "1111";
      data_value <= DATA_W;

      if is_byte = '1' then
         case ADDR_W is
            when "00" => 
               data_mask  <= "0001";
               data_value <= x"000000" & DATA_W(7 downto 0);
            when "01" => 
               data_mask  <= "0010";
               data_value <= x"0000" & DATA_W(7 downto 0) & x"00";
            when "10" => 
               data_mask  <= "0100";
               data_value <= x"00" & DATA_W(7 downto 0) & x"0000";
            when "11" => 
               data_mask  <= "1000";
               data_value <= DATA_W(7 downto 0) & x"000000";
            when others =>
               data_mask  <= "0000";
               data_value <= (others => '0');
         end case;

      elsif is_half = '1' then
         if ADDR_W(1) = '0' then
            data_mask  <= "0011";
            data_value <= x"0000" & DATA_W(15 downto 0);
         else
            data_mask  <= "1100";
            data_value <= DATA_W(15 downto 0) & x"0000";
         end if;
      end if;
   end process;
   
end arch;
