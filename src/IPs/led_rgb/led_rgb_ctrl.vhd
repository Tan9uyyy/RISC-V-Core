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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity led_rgb_ctrl is
  Port ( 
    clock     : in   STD_LOGIC;
    reset     : in   STD_LOGIC;
    data_i    : IN   STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données à écrire
    data_o    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données lues à l'adresse
    write_en  : IN   STD_LOGIC;                     -- validation d'écriture
    led_r_o   : OUT  STD_LOGIC;
    led_g_o   : OUT  STD_LOGIC;
    led_b_o   : OUT  STD_LOGIC
  );
end led_rgb_ctrl;


architecture arch of led_rgb_ctrl is

    COMPONENT pwm_module is
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
    end COMPONENT;
    
    SIGNAL buff_data_i   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL buff_write_en : STD_LOGIC;

begin

    --
    --
    --

    process(clock)
    begin
      if rising_edge(clock) then
        if reset = '1' then -- reset
          buff_data_i   <= x"00000000";
          buff_write_en <= '0';
        elsif write_en = '1' then
          buff_data_i   <= data_i;
          buff_write_en <= write_en;
        else
          buff_data_i   <= buff_data_i;
          buff_write_en <= '0';
        end if;
      end if;
    end process;

    
    red_ctrl : pwm_module
        GENERIC MAP( reset_v => 0) 
        PORT MAP(
          clk_i   => clock,
          rst_i   => reset,
          data_i  => buff_data_i(7 downto 0),
          data_en => buff_write_en,
          pwm_o   => led_r_o
        );
    
    green_ctrl : pwm_module
        GENERIC MAP( reset_v => 0) 
        PORT MAP(
          clk_i   => clock,
          rst_i   => reset,
          data_i  => buff_data_i(15 downto 8),
          data_en => buff_write_en,
          pwm_o   => led_g_o
        );
    
    blue_ctrl : pwm_module
        GENERIC MAP( reset_v => 64) -- 255 ça crame les yeux ! 
        PORT MAP(
          clk_i   => clock,
          rst_i   => reset,
          data_i  => buff_data_i(23 downto 16),
          data_en => buff_write_en,
          pwm_o   => led_b_o
        );
    
    --
    --
    --

    data_o <= buff_data_i;

end arch;
 

