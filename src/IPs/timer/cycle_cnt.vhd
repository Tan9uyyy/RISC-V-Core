library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity cycle_cnt is
Port ( 
   CLK       : in  STD_LOGIC;
   reset     : in  STD_LOGIC;
   counter_v : out STD_LOGIC_VECTOR (31 downto 0)
 );
end cycle_cnt; 


architecture arch of cycle_cnt is

    SIGNAL count  : UNSIGNED (31 downto 0);

begin

    process(clk)
    begin   
        if rising_edge(clk) then
            if reset = '1' then
                count  <= to_unsigned(0, 32);
            else
                count  <= count + to_unsigned(1, 32);
            end if;
        end if;
    end process;

    counter_v <= STD_LOGIC_VECTOR( count );

end arch;
 
