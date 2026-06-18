library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package alu_mult_pkg is 

  COMPONENT alu_mult IS
    PORT (
      clk_i      :  in STD_LOGIC;
      rstn_i     :  in STD_LOGIC;

      rs1_i      :  in STD_LOGIC_VECTOR (31 downto 0);
      rs2_i      :  in STD_LOGIC_VECTOR (31 downto 0);
      en_i       :  in STD_LOGIC;

      func3_i    :  in STD_LOGIC_VECTOR ( 2 downto 0);
      mul_o      : out STD_LOGIC_VECTOR (31 downto 0);
      finished_o : out STD_LOGIC;
      busy_o     : out STD_LOGIC
  );
  END COMPONENT;

end package;
