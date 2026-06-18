----------------------------------------------------------------------------------
--
-- UART_fifoed_send_V1
-- Version 1.1
-- 
-- V1.1 : Written by Yannick Bornat (2016/04/20)
--       - build from UART_send v1.1, named to fit the same version number
--
-- Sends chars on the UART line, has a built-in fifo to accept char inputs while
-- sending an older char
-- during character send, busy output bit is set to '1' and the module ignores inputs.
-- works at 100MHz with 115.200kbps transfer rate
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

USE work.stdio_h.all;

entity uart_send is
    Generic ( fifo_size             : integer := 1024;
              fifo_almost           : integer := 1012;
              drop_oldest_when_full : boolean := False;
              asynch_fifo_full      : boolean := True);
    Port ( clk_100MHz : in  STD_LOGIC;
           reset      : in  STD_LOGIC;
           dat_en     : in  STD_LOGIC;
           dat        : in  STD_LOGIC_VECTOR (7 downto 0);
           TX         : out STD_LOGIC;
           fifo_empty : out STD_LOGIC;
           fifo_afull : out STD_LOGIC;
           fifo_full  : out STD_LOGIC);
end uart_send;

architecture arch of uart_send is

  SIGNAL buffer_i  : CHARACTER;
  SIGNAL unique_i  : integer := 0;

begin

  PROCESS(clk_100MHz)
      variable a : CHARACTER;
  BEGIN
      IF clk_100MHz'event AND clk_100MHz = '1' THEN
          IF (RESET = '1') and (unique_i = 0) THEN
              printf("(--)\n");
              printf("(--) RISC-V design framework for teaching\n");
              printf("(--) Bertrand LE GAL 2023-2024\n");
              printf("(--)\n");
              unique_i <= 1;
          ELSIF dat_en = '1' THEN
              a := character'val( TO_INTEGER( UNSIGNED(dat) ) );
              putchar( a );
          END IF;
      END IF;
  END PROCESS;


  PROCESS(clk_100MHz)
  BEGIN
      IF clk_100MHz'event AND clk_100MHz = '1' THEN
          IF dat_en = '1' THEN
              buffer_i <= character'val( TO_INTEGER( UNSIGNED(dat) ) );
          END IF;
      END IF;
  END PROCESS;

  TX         <= '0';
  fifo_empty <= '1';
  fifo_afull <= '0';
  fifo_full  <= '0';

end arch;
