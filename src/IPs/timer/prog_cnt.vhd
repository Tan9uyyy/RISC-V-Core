library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity prog_cnt is
Port ( 
   CLK       : in  STD_LOGIC;
   reset     : in  STD_LOGIC;
   load_en   : in  STD_LOGIC;
   data_i    : in  STD_LOGIC_VECTOR (31 downto 0);
   counter_v : out STD_LOGIC_VECTOR (31 downto 0)
 );
end prog_cnt; 


architecture arch of prog_cnt is

    SIGNAL count  : UNSIGNED (31 downto 0);

begin

    process(clk)
    begin   
        if rising_edge(clk) then
            if reset = '1' then
                count  <= to_unsigned(0, 32);
            elsif load_en = '1' then
                count  <= UNSIGNED(data_i);
            else
                IF count /= to_unsigned(0, 32) then 
                    count  <= count - to_unsigned(1, 32);
                END IF;
            end if;
        end if;
    end process;

    counter_v <= STD_LOGIC_VECTOR( count );

end arch;
