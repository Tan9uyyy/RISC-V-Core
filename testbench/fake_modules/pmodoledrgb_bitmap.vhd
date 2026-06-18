----------------------------------------------------------------------------------------------------
-- PmodOLEDrgb_bitmap
--    Version V1.0.1 (2017/12/20)
--    (c)2017 Y. BORNAT - Bordeaux INP / ENSEIRB-MATMECA
--    This module controls the OLEDrgb Pmod to display an image stored in a RAM on the FPGA.
----------------------------------------------------------------------------------------------------
-- For the last version and a more complete documentation, please visit
-- http://bornat.vvv.enseirb.fr/wiki/doku.php?id=en202:pmodoledrgb
--
-- How to use This module :
---------------------------
--   - The pix_row and pix_col are used to address any pixel of the 96x64 array. As a 7 bit std_logic_vector,
--     pix_col may address columns up to 127. To avoid any problem, columns 96 to 127 are actually equivalent
--     to columns 32 to 63. pixel 0,0 is the upper left pixel. If the screen is connected on a PMod on the
--     left of the board, it is rotated by 180°, it is possible to compensate this rotation by affecting True to
--     the LEFT_SIDE generic.
--   - To affect a new color to a pixel, user should assert pix_write, address the concerned pixel and provide
--     the new color on pix_data_in on the same rising_edge of clk
--   - To read a pixel value, user should address the pixel and wait for the third clock cycle to read the pixel
--      value on pix_data_out as shown on the diagram below. Read operations can be pipelined.
--                       ____      ____      ____      ____      ____      ____
--       clk        ____/    \____/    \____/    \____/    \____/    \____/    \
--
--      pix_col     -----<  col 1  X  col 2  X  col 3  >-------------------------
--      pox_row     -----<  row 1  X  row 2  X  row 3  >-------------------------
--      pix_data_out ------------------------< pixval1 X pixval2 X pixval3 >-----
--
--   - Memory is read-before-write, so it is possible to read an write at the same time. the value output
--     on pix_data_out will be the previous value of the pixel.
--
----------------------------------------------------------------------------------
-- known bugs :
--    - None so far
--
-------------------------------------------------------------------------------------------------------
-- History
----------------------------------------------------------------------------------
-- V1.0.1 (2017/12/20) by YB
--    - fixed : data was actually read one clock cycle too late...
--    - removed useless commented lines
--    - added colored scheme for 2bpp (black, red, green, blue)
-- V1.0 (2017/08/04) by YB
--    - initial release
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE work.stdio_h.all;

entity PmodOLEDrgb_bitmap is
    Generic (CLK_FREQ_HZ : integer := 100000000;        -- by default, we run at 100MHz
             BPP         : integer range 1 to 16 := 16; -- bits per pixel
             GREYSCALE   : boolean := False;            -- color or greyscale ? (only for BPP>6)
             LEFT_SIDE   : boolean := False);           -- True if the Pmod is on the left side of the board
    Port (clk          : in  STD_LOGIC;
          reset        : in  STD_LOGIC;
          
          pix_write    : in  STD_LOGIC;
          pix_col      : in  STD_LOGIC_VECTOR(    6 downto 0);
          pix_row      : in  STD_LOGIC_VECTOR(    5 downto 0);
          pix_data_in  : in  STD_LOGIC_VECTOR(BPP-1 downto 0);
          pix_data_out : out STD_LOGIC_VECTOR(BPP-1 downto 0);
          
          PMOD_CS      : out STD_LOGIC;
          PMOD_MOSI    : out STD_LOGIC;
          PMOD_SCK     : out STD_LOGIC;
          PMOD_DC      : out STD_LOGIC;
          PMOD_RES     : out STD_LOGIC;
          PMOD_VCCEN   : out STD_LOGIC;
          PMOD_EN      : out STD_LOGIC);
end PmodOLEDrgb_bitmap;

architecture Behavioral of PmodOLEDrgb_bitmap is

    SIGNAL unique_i  : integer := 0;

begin

    PROCESS(clk)
        variable x : integer;
        variable y : integer;
        variable c : integer;
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF (RESET = '1') and (unique_i = 0) THEN
                printf("(--)\n");
                printf("(--) OLED framebuffer\n");
                printf("(--)\n");
                unique_i <= 1;
            ELSIF pix_write = '1' THEN
                x := to_integer( unsigned(pix_col    ) );
                y := to_integer( unsigned(pix_row    ) );
                c := to_integer( unsigned(pix_data_in) );
                printf("(--) OLED SCREEN write");
                printf("(x = %2.2d : ", x);
                printf(" y = %2.2d : ", y);
                printf(" color = %8.8X)\n", c);
            END IF;
        END IF;
    END PROCESS;

end Behavioral;

