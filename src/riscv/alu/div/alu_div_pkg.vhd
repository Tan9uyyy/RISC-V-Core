library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package alu_div_pkg is

  COMPONENT alu_div is
    PORT (
      clk_i      :  in STD_LOGIC;                       -- the working clock
      rstn_i     :  in STD_LOGIC;                       -- the reset signal
      rs1_i      :  in STD_LOGIC_VECTOR (31 downto 0);  -- first operand
      rs2_i      :  in STD_LOGIC_VECTOR (31 downto 0);  -- second operand
      en_i       :  in STD_LOGIC;                       -- launch computation

      func3_i    :  in STD_LOGIC_VECTOR ( 2 downto 0);  -- the computation to perform
      div_o      : out STD_LOGIC_VECTOR (31 downto 0);  -- the compuation result
      finished_o : out STD_LOGIC;                       -- computation is finished
      busy_o     : out STD_LOGIC                        -- the operator is busy
  );
  end COMPONENT;

end package;