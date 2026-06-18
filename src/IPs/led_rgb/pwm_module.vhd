----------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Author:  Bertrand LE GAL
--          Copyright 2023 ENSSAT / University of Rennes / IRISA lab.
----------------------------------------------------------------------------
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:
--
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_module is
    generic(
        reset_v : integer range 0 to 255 := 127
    );  
    port(
        clk_i   : in std_logic;                    -- system clock = 100MHz
        rst_i   : in std_logic;                    -- system clock = 100MHz
        data_i  : in std_logic_vector(7 downto 0); -- the number to be modulated
        data_en : in std_logic;                    -- the number to be modulated
        pwm_o   : out std_logic
    );
end pwm_module;

architecture Behavioral of pwm_module is

    SIGNAL cnt : UNSIGNED(7 downto 0) := TO_UNSIGNED(0,       8);
    SIGNAL mem : UNSIGNED(7 downto 0) := TO_UNSIGNED(reset_v, 8);

begin

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                mem <= x"80";
            elsif data_en = '1' then
                mem <= UNSIGNED(data_i);
            end if;
        end if;
    end process;

   process(clk_i)
   begin
      if rising_edge(clk_i) then
         cnt <= cnt + TO_UNSIGNED(1, 8);
      end if;
   end process;

   
   process(mem, cnt)
   begin
      if unsigned(cnt) < unsigned(mem) then
         pwm_o <= '0'; -- rgb led control is inverted
      else
         pwm_o <= '1'; -- rgb led control is inverted
      end if;
   end process;

end Behavioral;
