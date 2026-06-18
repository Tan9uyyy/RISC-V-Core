library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

package csr_registers_pkg is

    COMPONENT csr_registers is
    Port ( 
        CLK      :  in STD_LOGIC;
        resetn   :  in STD_LOGIC;
        instr_en :  in STD_LOGIC;
        csr_id   :  in STD_LOGIC_VECTOR ( 1 downto 0);
        word_v   : out STD_LOGIC_VECTOR (31 downto 0)
    );
    end COMPONENT;

end package;
