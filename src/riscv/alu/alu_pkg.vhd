library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package alu_pkg is

    COMPONENT alu is
    Port ( 
        rs1_v             : in  STD_LOGIC_VECTOR (31 downto 0);
        rs2_v             : in  STD_LOGIC_VECTOR (31 downto 0);
        isALUreg          : in  STD_LOGIC;
        isBranch          : in  STD_LOGIC;
        isAluSubstraction : in  STD_LOGIC;
        isCustom          : in  STD_LOGIC; -- custom instruction
        func3             : in  STD_LOGIC_VECTOR ( 2 downto 0);
        func7             : in  STD_LOGIC_VECTOR ( 6 downto 0);
        imm_v             : in  STD_LOGIC_VECTOR (31 downto 0);

        aluOut_v          : out STD_LOGIC_VECTOR (31 downto 0);
        aluPlus_v         : out STD_LOGIC_VECTOR (31 downto 0);
        takeBranch        : out STD_LOGIC
    );
    end COMPONENT;

end package;
