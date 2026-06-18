----------------------------------------------------------------------------------------------------
-- PmodOLEDrgb_terminal
--    Version V1.0.1 (2017/10/31)
--    (c)2017 Y. BORNAT - Bordeaux INP / ENSEIRB-MATMECA
--    This module displays a stream of text as a terminal would do
----------------------------------------------------------------------------------------------------
-- For the last version and a more complete documentation, please visit
-- http://bornat.vvv.enseirb.fr/wiki/doku.php?id=en202:pmodoledrgb
--
-- How to use This module :
---------------------------
--   - To display a new char, user should assert char_write and provide the char on 'char' on the same rising edge of clk.
--     The module manages the update of cursor position and writes the char at the next place. After reading char_write at '1',
--     the module will reset the 'ready' output until the operation is performed. Once 'ready' is set again, the module can accept
--     a new char.
--   - when an operation is performed, the command bit should be reset by user as soon as possible, but the parameters
--     should keep their value unchanged until the ready bit is set again. It is possible to change this behavior setting
--     the PARAM_BUFF generic to True. The module will then require more hardware resources to perform its own copy of the
--     inputs when reading any command bit at '1'.
--   - User can optionnaly provide a foreground and/or a background color for each char. default is white on black.
--     color format is rrrgggbb so 0xE0 mean red, 0x1C means green and 0x03 means blue.
--
--   - optionnal command 'screen_clear' fill the whole screen with the background color. This command require the module to be
--      ready. During the processing time, the 'ready' output will be reset too. This command has priority on char_write
--
-- Dependencies
----------------
--     This module requires the PmodOLEDrgb_charmap module to work properly and was succesfully working with version 1.0
----------------------------------------------------------------------------------
-- known bugs :
--    - None so far
--
-------------------------------------------------------------------------------------------------------
-- History
----------------------------------------------------------------------------------
-- V1.0.1 (2017/10/31) by YB
--    - fixes on typos and mistakes while copy/pasting from other comments
-- V1.0 (2017/08/06) by YB
--    - initial release
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PmodOLEDrgb_terminal is 
    Generic (CLK_FREQ_HZ   : integer := 100000000;        -- by default, we run at 100MHz
             PARAM_BUFF    : boolean := False;            -- if True, no need to hold inputs while module busy
             LEFT_SIDE     : boolean := False);           -- True if the Pmod is on the left side of the board
    Port (clk          : in  STD_LOGIC;
          reset        : in  STD_LOGIC;
          
          char_write   : in  STD_LOGIC;
          char         : in  STD_LOGIC_VECTOR(7 downto 0);
          ready        : out STD_LOGIC;
          foregnd      : in  STD_LOGIC_VECTOR(7 downto 0):=x"FF";
          backgnd      : in  STD_LOGIC_VECTOR(7 downto 0):=x"00";
          screen_clear : in  STD_LOGIC := '0';
          
          PMOD_CS      : out STD_LOGIC;
          PMOD_MOSI    : out STD_LOGIC;
          PMOD_SCK     : out STD_LOGIC;
          PMOD_DC      : out STD_LOGIC;
          PMOD_RES     : out STD_LOGIC;
          PMOD_VCCEN   : out STD_LOGIC;
          PMOD_EN      : out STD_LOGIC);
end PmodOLEDrgb_terminal;

architecture Behavioral of PmodOLEDrgb_terminal is
begin

end Behavioral;

