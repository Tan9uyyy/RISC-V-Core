library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package immediate_pkg is

    COMPONENT immediate is
    Port ( 
        INSTR    : in  STD_LOGIC_VECTOR (31 downto 0);
        isStore  : in  STD_LOGIC;
        isLoad   : in  STD_LOGIC;
        isbranch : in  STD_LOGIC;
        isJAL    : in  STD_LOGIC;
        isAuipc  : in  STD_LOGIC;
        isLui    : in  STD_LOGIC;
        imm      : out STD_LOGIC_VECTOR (31 downto 0)
    );
    end COMPONENT;

end package;