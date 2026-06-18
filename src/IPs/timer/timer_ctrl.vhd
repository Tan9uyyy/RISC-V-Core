library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity timer_ctrl is
Port ( 
   clock    : IN STD_LOGIC;
   reset    : IN STD_LOGIC;
   data_i   : IN   STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données à écrire
   data_o   : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données lues à l'adresse
   write_en : IN   STD_LOGIC;                     -- validation d'écriture
   addr_lsb : IN  STD_LOGIC_VECTOR ( 3 downto 0)
 );
end timer_ctrl;


architecture arch of timer_ctrl is

    COMPONENT cycle_cnt is
    Port ( 
       CLK       : in  STD_LOGIC;
       reset     : in  STD_LOGIC;
       counter_v : out STD_LOGIC_VECTOR (31 downto 0)
     );
    end COMPONENT;
    
    COMPONENT prog_cnt is
    Port ( 
       CLK       : in  STD_LOGIC;
       reset     : in  STD_LOGIC;
       load_en   : in  STD_LOGIC;
       data_i    : in  STD_LOGIC_VECTOR (31 downto 0);
       counter_v : out STD_LOGIC_VECTOR (31 downto 0)
    );
    end COMPONENT;

   SIGNAL cycle   : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL instret : STD_LOGIC_VECTOR (31 downto 0);

   SIGNAL load_en : STD_LOGIC;

begin


    process(clock)
    begin   
        if rising_edge(clock) then
            case addr_lsb(3 downto 2) is
                when "00"   => data_o <= cycle;
                when OTHERS => data_o <= instret;
            end case;
        end if;
    end process;

    count_cycles : cycle_cnt 
    PORT MAP ( 
        CLK       => clock,
        reset     => reset, 
        counter_v => cycle
    );

    count_prog : prog_cnt
    PORT MAP ( 
        CLK       => clock,
        reset     => reset, 
        load_en   => load_en,
        data_i    => data_i,
        counter_v => instret
    );

    load_en <= write_en when addr_lsb(3 downto 2) = "01" else '0';

end arch;
