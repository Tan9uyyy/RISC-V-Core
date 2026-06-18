library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity switch_ctrl is
  Port ( 
    clock     : in   STD_LOGIC;
    reset     : in   STD_LOGIC;
    data_addr : IN   STD_LOGIC_VECTOR(15 DOWNTO 0); -- les 15 bits de poids faible
    data_i    : IN   STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données à écrire
    read_en   : IN   STD_LOGIC;                     -- validation d'écriture
    data_o    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0); -- les données lues à l'adresse
    write_en  : IN   STD_LOGIC;                     -- validation d'écriture
    we_mask   : IN   STD_LOGIC_VECTOR( 3 DOWNTO 0); -- masque d'écriture
    switch_i  : IN   STD_LOGIC_VECTOR(15 DOWNTO 0)  -- la sortie de controle des leds
  );
end switch_ctrl;


architecture arch of switch_ctrl is

  SIGNAL i_buffer  : STD_LOGIC_VECTOR(15 downto 0);

  CONSTANT zero_local_addr : STD_LOGIC_VECTOR(13 downto 0) = "00000000000000";

begin

    --
    -- We never store information
    --

    process(clock)
    begin
      if rising_edge(clock) then
        if reset = '1' then -- reset
          i_buffer <= x"0000";
        else
            i_buffer <= switch_i
        end if;
      end if;
    end process;

    
    --
    --
    --

    data_o <= x"0000" & i_buffer when data_addr(15 downto 2) = zero_local_addr and read_en = '1' else x"00000000";

end arch;
 

