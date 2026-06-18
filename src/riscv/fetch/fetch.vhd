library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fetch is
Port ( 
   CLK                 : in  STD_LOGIC;
   resetn              : in  STD_LOGIC;
   enable_f            : in  STD_LOGIC;
   enable_m            : in  STD_LOGIC;
   jumpOrBranchAddress : in  STD_LOGIC_VECTOR (31 downto 0);
   jumpOrBranch        : in  STD_LOGIC;
   pc_value            : out STD_LOGIC_VECTOR (31 downto 0)
 );
end fetch;


architecture arch of fetch is

   SIGNAL pc_addr : UNSIGNED (31 downto 0);

begin

   process (CLK)
   begin
      if rising_edge(clk) then 
         -- Soit un reset classique
         if resetn = '0' then
            pc_addr <= (others => '0');

         -- incrément classique du PC
         elsif enable_f = '1' then
            pc_addr <= pc_addr + to_unsigned(4, 32);

         --jump ou branchement
         elsif enable_m = '1' and jumporbranch = '1' then
            pc_addr <= unsigned (jumporbranchaddress);
         end if;
      end if;
   end process;

   -- On lie le signal interne pc_addr à la sortie pc_value
   pc_value <= std_logic_vector(pc_addr);
   
end arch;
 
