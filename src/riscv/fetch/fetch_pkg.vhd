library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use work.riscv_types.all;

package fetch_pkg is

  COMPONENT fetch is
  Port ( 
    CLK                 : in  STD_LOGIC;
    resetn              : in  STD_LOGIC;
    enable_f            : in  STD_LOGIC;
    enable_m            : in  STD_LOGIC;
    jumpOrBranchAddress : in  STD_LOGIC_VECTOR (31 downto 0);
    jumpOrBranch        : in  STD_LOGIC;
    pc_value            : out STD_LOGIC_VECTOR (31 downto 0)
  );
  end COMPONENT;
      
 end package;