library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

package addr_stack_pkg is 

    COMPONENT addr_stack is
    Port ( 
        CLK     : in  STD_LOGIC;
        resetn  : in  STD_LOGIC;
        addr_i  : in  STD_LOGIC_VECTOR (31 downto 0);
        push_i  : in  STD_LOGIC;
        pop_i   : in  STD_LOGIC;
        addr_o  : out STD_LOGIC_VECTOR (31 downto 0)
    );
    end COMPONENT;

end package;
