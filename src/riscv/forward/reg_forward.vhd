library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity reg_forward is
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
end reg_forward;

architecture arch of reg_forward is
   SIGNAL E_M_fwd_rs1 : STD_LOGIC;
   SIGNAL E_W_fwd_rs1 : STD_LOGIC;
   SIGNAL E_M_fwd_rs2 : STD_LOGIC;
   SIGNAL E_W_fwd_rs2 : STD_LOGIC;
begin

   -- forwarding ?
   E_M_fwd_rs1 <= EM_wbEnable AND DE_rs1Id_eq_EM_rdId;
   E_W_fwd_rs1 <= MW_wbEnable AND DE_rs1Id_eq_MW_rdId;
   E_M_fwd_rs2 <= EM_wbEnable AND DE_rs2Id_eq_EM_rdId;
   E_W_fwd_rs2 <= MW_wbEnable AND DE_rs2Id_eq_MW_rdId;

   process(all)
   begin
      --forwarding de rs1
      if (E_M_fwd_rs1 = '1') then 
         E_rs1 <= EM_result;
      elsif (E_W_fwd_rs1 = '1') then
         E_rs1 <= WB_data;
      else
         E_rs1 <= DE_rs1;
      end if;
      --forwarding de rs2
      if (E_M_fwd_rs2 = '1') then 
         E_rs2 <= EM_result;
      elsif (E_W_fwd_rs2 = '1') then
         E_rs2 <= WB_data;
      else
         E_rs2 <= DE_rs2;
      end if;
   end process;
   
end arch;