library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package reg_forward_pkg is

   COMPONENT reg_forward is
   Port ( 
      EM_wbEnable         : in  STD_LOGIC;
      MW_wbEnable         : in  STD_LOGIC;
      DE_rs1Id_eq_EM_rdId : in  STD_LOGIC;
      DE_rs1Id_eq_MW_rdId : in  STD_LOGIC;
      DE_rs2Id_eq_EM_rdId : in  STD_LOGIC;
      DE_rs2Id_eq_MW_rdId : in  STD_LOGIC;
      EM_result           : in  STD_LOGIC_VECTOR (31 downto 0);
      WB_data             : in  STD_LOGIC_VECTOR (31 downto 0);
      DE_rs1              : in  STD_LOGIC_VECTOR (31 downto 0);
      DE_rs2              : in  STD_LOGIC_VECTOR (31 downto 0);
      E_rs1               : out STD_LOGIC_VECTOR (31 downto 0);
      E_rs2               : out STD_LOGIC_VECTOR (31 downto 0)
   );
   end COMPONENT;

end package;
