library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

entity addr_stack is
Port ( 
   CLK     : in  STD_LOGIC;
   resetn  : in  STD_LOGIC;
   addr_i  : in  STD_LOGIC_VECTOR (31 downto 0);
   push_i  : in  STD_LOGIC;
   pop_i   : in  STD_LOGIC;
   addr_o  : out STD_LOGIC_VECTOR (31 downto 0)
 );
end addr_stack;


architecture arch of addr_stack is

   SIGNAL RetAddrStack_0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL RetAddrStack_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL RetAddrStack_2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL RetAddrStack_3 : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

    process(clk)
    begin   
        if rising_edge(clk) then
            if resetn = '0' then

                RetAddrStack_3      <= (others => '0');
                RetAddrStack_2      <= (others => '0');
                RetAddrStack_1      <= (others => '0');
                RetAddrStack_0      <= (others => '0');

            elsif push_i = '1' then

	            RetAddrStack_3 <= RetAddrStack_2;
	            RetAddrStack_2 <= RetAddrStack_1;
	            RetAddrStack_1 <= RetAddrStack_0;
	            RetAddrStack_0 <= addr_i;

            elsif pop_i = '1' then

	            RetAddrStack_0 <= RetAddrStack_1;
	            RetAddrStack_1 <= RetAddrStack_2;
	            RetAddrStack_2 <= RetAddrStack_3;
	            RetAddrStack_3 <= (others => '0');

            end if;
        end if;
    end process;

    addr_o <= RetAddrStack_0;

end arch;
 
