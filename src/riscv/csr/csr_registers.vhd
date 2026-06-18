library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

entity csr_registers is
Port ( 
   CLK      :  in STD_LOGIC;
   resetn   :  in STD_LOGIC;
   instr_en :  in STD_LOGIC;
   csr_id   :  in STD_LOGIC_VECTOR ( 1 downto 0);
   word_v   : out STD_LOGIC_VECTOR (31 downto 0)
 );
end csr_registers;


architecture arch of csr_registers is

    COMPONENT cnt_cycles is
    Port ( 
       CLK       : in  STD_LOGIC;
       resetn    : in  STD_LOGIC;
       counter_v : out STD_LOGIC_VECTOR (63 downto 0)
     );
    end COMPONENT;
    
    COMPONENT cnt_instr is
    Port ( 
       CLK       : in  STD_LOGIC;
       resetn    : in  STD_LOGIC;
       enable    : in  STD_LOGIC;
       counter_v : out STD_LOGIC_VECTOR (63 downto 0)
     );
    end COMPONENT;

   SIGNAL cycle   : STD_LOGIC_VECTOR (63 downto 0);
   SIGNAL instret : STD_LOGIC_VECTOR (63 downto 0);

begin


    process(clk)
    begin   
        if rising_edge(clk) then
            case csr_id is
                when "00"   => word_v <= cycle  (31 downto  0);
                when "10"   => word_v <= cycle  (63 downto 32);
                when "01"   => word_v <= instret(31 downto  0);
--              when "11"   => EM_CSRdata <= instret(63 downto 32);	 
                when OTHERS => word_v <= instret(63 downto 32);	 
            end case;
        end if;
    end process;


    count_cycles : cnt_cycles
    PORT MAP ( 
        CLK       => clk,
        resetn    => resetn, 
        counter_v => cycle
    );


    count_instr : cnt_instr
    PORT MAP ( 
        CLK       => clk,
        resetn    => resetn, 
        enable    => instr_en, 
        counter_v => instret
    );

end arch;
