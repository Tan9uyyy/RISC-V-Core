library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.riscv_types.all;

entity mem_load is 
    Port ( 
        ADDR_R      : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
        DATA_R      : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        is_byte     : IN  STD_LOGIC;
        is_half     : IN  STD_LOGIC;
        is_sign_ext : IN  STD_LOGIC;
        data_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
     );
end mem_load;


architecture arch of mem_load is

   SIGNAL M_LOAD_H    : STD_LOGIC_VECTOR (15 downto 0);
   SIGNAL M_LOAD_B    : STD_LOGIC_VECTOR ( 7 downto 0);

begin

   with ADDR_R select
        M_LOAD_B <= DATA_R( 7 downto  0) when "00",
                    DATA_R(15 downto  8) when "01",
                    DATA_R(23 downto 16) when "10",
                    DATA_R(31 downto 24) when others;

   with ADDR_R(1) select
         M_LOAD_H <= DATA_R(31 downto 16) when '1',
                     DATA_R(15 downto 0) when others;

   process(DATA_R, M_LOAD_B, M_LOAD_H, is_byte, is_half, is_sign_ext)
   begin 
      if is_byte = '1' then
         if is_sign_ext = '1' and M_LOAD_B(7) = '1' then
            data_value <= x"FFFFFF" & M_LOAD_B;
         else 
            data_value <= x"000000" & M_LOAD_B;
         end if;
      elsif is_half ='1' then 
         if is_sign_ext = '1' and M_LOAD_H(15) = '1' then
            data_value <= x"FFFF" & M_LOAD_H;
         else 
            data_value <= x"0000" & M_LOAD_H;
         end if;
      else 
         data_value <= DATA_R;
      end if;
   end process;
   
end arch;
