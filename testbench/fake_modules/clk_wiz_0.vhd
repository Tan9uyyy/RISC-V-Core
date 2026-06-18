-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clk_wiz_0 is
  Port (
    clk_in1  : in  STD_LOGIC;
    clk_out1 : out STD_LOGIC
  );
end;

architecture arch of clk_wiz_0 is
begin

  clk_out1 <= clk_in1;

end;

