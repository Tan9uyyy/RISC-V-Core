library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

entity cnt_cycles is
Port ( 
   CLK       : in  STD_LOGIC;
   resetn    : in  STD_LOGIC;
   counter_v : out STD_LOGIC_VECTOR (63 downto 0)
 );
end cnt_cycles; 


architecture arch of cnt_cycles is

    SIGNAL count  : UNSIGNED (63 downto 0);

begin

    process(clk)
    begin   
        if rising_edge(clk) then
            if resetn = '0' then
                count  <= to_unsigned(0, 64);
            else
                count  <= count + to_unsigned(1, 64);
            end if;
        end if;
    end process;

    counter_v <= STD_LOGIC_VECTOR( count );

end arch;
 
