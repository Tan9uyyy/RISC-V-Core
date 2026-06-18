library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use work.riscv_config.all;

entity riscv_5stg_soc is
GENERIC(
    uart_tx_en : INTEGER := 1;
    uart_rx_en : INTEGER := 0;
    termial_en : INTEGER := 1
); 
Port ( 
   CLK_12MHz     : in  STD_LOGIC;
   RESET_i       : in  STD_LOGIC;
   
   LED 		     : out STD_LOGIC_VECTOR ( 1 downto 0);

   JA_PMOD_CS    : out STD_LOGIC;
   JA_PMOD_MOSI  : out STD_LOGIC;
   JA_PMOD_SCK   : out STD_LOGIC;
   JA_PMOD_DC    : out STD_LOGIC;
   JA_PMOD_RES   : out STD_LOGIC;
   JA_PMOD_VCCEN : out STD_LOGIC;
   JA_PMOD_EN    : out STD_LOGIC;

   led0_b        : out STD_LOGIC;
   led0_g        : out STD_LOGIC;
   led0_r        : out STD_LOGIC;

   UART_RXD_OUT  : out STD_LOGIC;
   UART_TXD_IN   : in  STD_LOGIC
);
end riscv_5stg_soc;

architecture arch of riscv_5stg_soc is

   CONSTANT OLED_BPP : INTEGER := 16;

    COMPONENT riscv_5stg IS
    PORT ( 
       CLK           : in  STD_LOGIC;
       resetn        : in  STD_LOGIC;
       IO_mem_addr   : out STD_LOGIC_VECTOR (31 downto 0);
       IO_mem_rdata  : in  STD_LOGIC_VECTOR (31 downto 0);
       IO_mem_wdata  : out STD_LOGIC_VECTOR (31 downto 0);
       IO_mem_rd     : out STD_LOGIC;
       IO_mem_wr     : out STD_LOGIC
    );
    END COMPONENT;

    
    COMPONENT uart_send is
        Generic ( fifo_size             : integer := 64;
                  fifo_almost           : integer := 60;
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
    end COMPONENT;

    COMPONENT UART_recv is
       Port ( clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              rx     : in  STD_LOGIC;
              dat    : out STD_LOGIC_VECTOR (7 downto 0);
              dat_en : out STD_LOGIC);
    end COMPONENT;

    COMPONENT clk_wiz_0 is
       Port (
        clk_in1  : in  STD_LOGIC;
        clk_out1 : out STD_LOGIC);
    end COMPONENT;
            
-- synthesis translate_off
    COMPONENT observer is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        dat_en : in  STD_LOGIC;
        dat    : in  STD_LOGIC_VECTOR (7 downto 0)
    );
    end COMPONENT;
-- synthesis translate_on

    SIGNAL CLK_100MHz : STD_LOGIC;
    SIGNAL RESET      : STD_LOGIC;
    SIGNAL RESETN     : STD_LOGIC;
   
    SIGNAL IO_mem_addr  : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL IO_mem_rdata : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL IO_mem_wdata : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL IO_mem_wr    : STD_LOGIC;
    SIGNAL IO_mem_rd    : STD_LOGIC;

    SIGNAL IO_wordaddr  : STD_LOGIC_VECTOR (13 downto 0);

    SIGNAL uart_valid : STD_LOGIC;
    SIGNAL uart_ready : STD_LOGIC;
    SIGNAL uart_full  : STD_LOGIC;

    SIGNAL data_to_spi         : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL data_from_spi_en    : STD_LOGIC;
    SIGNAL data_from_spi       : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL data_from_spi_busy  : STD_LOGIC;

    SIGNAL data_from_oled_rgb  : STD_LOGIC_VECTOR (OLED_BPP-1 downto 0);
    SIGNAL data_to_oled_rgb    : STD_LOGIC_VECTOR (OLED_BPP-1 downto 0);
    SIGNAL data_x_to_oled_rgb  : STD_LOGIC_VECTOR ( 6 downto 0);
    SIGNAL data_y_to_oled_rgb  : STD_LOGIC_VECTOR ( 5 downto 0);


    SIGNAL data_to_uart         : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL uart_for_debug       : STD_LOGIC_VECTOR (7 downto 0);

    SIGNAL data_from_uart_en    : STD_LOGIC;
    SIGNAL data_from_uart       : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL data_from_uart_s     : STD_LOGIC;
    SIGNAL data_from_uart_b     : STD_LOGIC_VECTOR (7 downto 0);

	SIGNAL   leds_buffer        : STD_LOGIC_VECTOR (1 downto 0);

	SIGNAL data_to_leds_en      : STD_LOGIC;
	SIGNAL data_to_switch_en    : STD_LOGIC;
	SIGNAL data_to_uart_en      : STD_LOGIC;
	SIGNAL data_to_spi_en       : STD_LOGIC;
	SIGNAL data_to_vga_en       : STD_LOGIC;
	SIGNAL data_to_sdcart_en    : STD_LOGIC;
	SIGNAL data_to_ethernet_en  : STD_LOGIC;
	SIGNAL data_to_oled_scr_en  : STD_LOGIC;
	SIGNAL data_to_timer_en     : STD_LOGIC;
	SIGNAL data_to_ledrgb_en    : STD_LOGIC;

	SIGNAL data_to_leds_wen      : STD_LOGIC;
	SIGNAL data_to_switch_wen    : STD_LOGIC;
	SIGNAL data_to_uart_wen      : STD_LOGIC;
	SIGNAL data_to_spi_wen       : STD_LOGIC;
	SIGNAL data_to_vga_wen       : STD_LOGIC;
	SIGNAL data_to_sdcart_wen    : STD_LOGIC;
	SIGNAL data_to_ethernet_wen  : STD_LOGIC;
	SIGNAL data_to_oled_scr_wen  : STD_LOGIC;
	SIGNAL data_to_timer_wen     : STD_LOGIC;
	SIGNAL data_to_ledrgb_wen    : STD_LOGIC;

    SIGNAL d32b_from_leds       : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_swit       : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_uart       : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_spi        : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_vga_buff   : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_sd_card    : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_ethernet   : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_oled_rgb   : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_timer      : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_led_rgb    : STD_LOGIC_VECTOR (31 downto 0); 

    attribute syn_keep    : boolean;
    attribute mark_debug  : string;
    attribute syn_keep   of data_to_oled_scr_wen: signal is true;
    attribute mark_debug of data_to_oled_scr_wen: signal is "true";
    attribute syn_keep   of data_to_oled_scr_en : signal is true;
    attribute mark_debug of data_to_oled_scr_en : signal is "true";
    attribute syn_keep   of data_to_oled_rgb: signal is true;
    attribute mark_debug of data_to_oled_rgb: signal is "true";
    attribute syn_keep   of data_x_to_oled_rgb: signal is true;
    attribute mark_debug of data_x_to_oled_rgb: signal is "true";
    attribute syn_keep   of data_y_to_oled_rgb: signal is true;
    attribute mark_debug of data_y_to_oled_rgb: signal is "true";
    attribute syn_keep   of data_from_oled_rgb: signal is true;
    attribute mark_debug of data_from_oled_rgb: signal is "true";

begin

   -- 31   27   23   19    15   11    7    3  0
   -- 0000 0100 0000 0000  0000 0000  0000 0000 LEDS     (0x04000000)
   -- 0000 0101 0000 0000  0000 0000  0000 0000 SWITCH   (0x05000000)
   -- 0000 1010 0000 0000  0000 0000  0000 0000 UART     (0x06000000)
   -- 0000 0011 0000 0000  0000 0000  0000 0000 OLED SPI (0x07000000)
   -- 0000 0100 0000 0000  0000 0000  0000 0000 VGA      (0x08000000)
   -- 0000 0101 0000 0000  0000 0000  0000 0000 SD card  (0x09000000)
   -- 0000 0110 0000 0000  0000 0000  0000 0000 Ethernet (0x0A000000)
   -- 0000 0111 0000 0000  0000 0000  0000 0000 oled-scr (0x0B000000)
   -- 0000 1000 0000 0000  0000 0000  0000 0000 timer    (0x0C000000)
   -- 0000 1001 0000 0000  0000 0000  0000 0000 RGB-LED  (0x0D000000)

   data_to_leds_en      <= '1' WHEN IO_mem_addr(27 downto 24) = "0100" else '0'; -- 0x04
   data_to_switch_en    <= '1' WHEN IO_mem_addr(27 downto 24) = "0101" else '0'; -- 0x05
   data_to_uart_en      <= '1' WHEN IO_mem_addr(27 downto 24) = "0110" else '0'; -- 0x06
   data_to_spi_en       <= '1' WHEN IO_mem_addr(27 downto 24) = "0111" else '0'; -- 0x07
   data_to_vga_en       <= '1' WHEN IO_mem_addr(27 downto 24) = "1000" else '0'; -- 0x08
   data_to_sdcart_en    <= '1' WHEN IO_mem_addr(27 downto 24) = "1001" else '0'; -- 0x09
   data_to_ethernet_en  <= '1' WHEN IO_mem_addr(27 downto 24) = "1010" else '0'; -- 0x0A
   data_to_oled_scr_en  <= '1' WHEN IO_mem_addr(27 downto 24) = "1011" else '0'; -- 0x0B
   data_to_timer_en     <= '1' WHEN IO_mem_addr(27 downto 24) = "1100" else '0'; -- 0x0C
   data_to_ledrgb_en    <= '1' WHEN IO_mem_addr(27 downto 24) = "1101" else '0'; -- 0x0D

   data_to_leds_wen     <= data_to_leds_en     and IO_mem_wr;
   data_to_switch_wen   <= data_to_switch_en   and IO_mem_wr;
   data_to_uart_wen     <= data_to_uart_en     and IO_mem_wr;
   data_to_spi_wen      <= data_to_spi_en      and IO_mem_wr;
   data_to_vga_wen      <= data_to_vga_en      and IO_mem_wr;
   data_to_sdcart_wen   <= data_to_sdcart_en   and IO_mem_wr;
   data_to_ethernet_wen <= data_to_ethernet_en and IO_mem_wr;
   data_to_oled_scr_wen <= data_to_oled_scr_en and IO_mem_wr;
   data_to_timer_wen    <= data_to_timer_en    and IO_mem_wr;
   data_to_ledrgb_wen   <= data_to_ledrgb_en   and IO_mem_wr;
   
   ---------------------------------------------------------------------------------------------------

   time_ctrl : ENTITY work.timer_ctrl
   PORT MAP(
       clock     => CLK_100MHz,
       reset     => RESET,
       addr_lsb  => IO_mem_addr(3 downto 0),
       data_i    => IO_mem_wdata,
       data_o    => d32b_from_timer,
       write_en  => data_to_timer_wen
   );

   ---------------------------------------------------------------------------------------------------

   led_rgb_1 : ENTITY work.led_rgb_ctrl
   PORT MAP(
       clock     => CLK_100MHz,
       reset     => RESET,
       data_i    => IO_mem_wdata,
       data_o    => d32b_from_led_rgb,
       write_en  => data_to_ledrgb_wen,
       led_r_o   => led0_r,
       led_g_o   => led0_g,
       led_b_o   => led0_b
   );

---------------------------------------------------------------------------------------------------

   PROCESS(CLK_100MHz)
   BEGIN
      if rising_edge(CLK_100MHZ) then
         RESET  <=     RESET_i;
         RESETN <= NOT RESET_i;
      END IF;
    END PROCESS;

   ---------------------------------------------------------------------------------------------------

    clk_gen : clk_wiz_0
    PORT MAP(
        clk_in1  => CLK_12MHz,
        clk_out1 => CLK_100MHz
    );

   ---------------------------------------------------------------------------------------------------

   CPU : riscv_5stg
   PORT MAP(
      clk          => CLK_100MHZ,
      resetn       => RESETN,

      IO_mem_addr  => IO_mem_addr,
      IO_mem_rdata => IO_mem_rdata,
      IO_mem_wdata => IO_mem_wdata,
      IO_mem_rd    => IO_mem_rd,
      IO_mem_wr    => IO_mem_wr
   );

   ---------------------------------------------------------------------------------------------------

   IO_wordaddr <= IO_mem_addr(15 downto 2);

   ---------------------------------------------------------------------------------------------------

   --
   -- Memory-mapped IO in IO page, 1-hot addressing in word address.   
   --

   process(CLK_100MHZ)
   begin   
      if rising_edge(CLK_100MHZ) then
         IF RESET = '1' THEN
            leds_buffer <= "00";
         ELSIF data_to_leds_en = '1' and IO_mem_wr = '1' then
            leds_buffer <= IO_mem_wdata(1 downto 0);
         end if;
      end if;
   end process;

   LED <= leds_buffer when RESET = '0' else "11";

   ---------------------------------------------------------------------------------------------------

   uart_ready     <= NOT uart_full;
   data_to_uart   <= IO_mem_wdata(7 downto 0);
   data_to_spi    <= IO_mem_wdata(7 downto 0);

   ---------------------------------------------------------------------------------------------------

   UART_s_custom : uart_send
      Generic MAP(
         fifo_size        => 2048,
         fifo_almost      => 2000,
         asynch_fifo_full => True
      )
      PORT MAP(
         clk_100MHz => CLK_100MHZ,
         reset      => reset,
         dat_en     => data_to_uart_wen,
         dat        => data_to_uart,
         TX         => UART_RXD_OUT,
         fifo_empty => open,
         fifo_afull => uart_full,
         fifo_full  => open);
   
   ---------------------------------------------------------
   
   UART_r_custom : UART_recv
      PORT MAP(
         clk        => CLK_100MHZ,
         reset      => reset,
         rx         => UART_TXD_IN,
         dat        => data_from_uart,
         dat_en     => data_from_uart_en
      );
      
   ---------------------------------------------------------

   process(CLK_100MHZ)
   begin   
      if rising_edge(CLK_100MHZ) then
        IF RESET = '1' THEN
           data_from_uart_b <= x"00";
           data_from_uart_s <= '0'; 

        ELSIF data_from_uart_en = '1' THEN 
           data_from_uart_b <= data_from_uart;
           data_from_uart_s <= data_from_uart_en; 

        ELSIF (data_from_uart_en = '1') and (IO_mem_rd = '1') THEN 
           data_from_uart_b <= x"00";
           data_from_uart_s <= '0'; 
        END IF;
      end if;
    end process;


	----------------------------------------------------------
	------                                             -------
	----------------------------------------------------------

   oled_rgb_96x64 : ENTITY work.PmodOLEDrgb_bitmap
        GENERIC MAP(CLK_FREQ_HZ => 100000000, -- by default, we run at 100MHz
                BPP         => OLED_BPP,      -- bits per pixel
                GREYSCALE   => False,         -- color or greyscale ? (only for BPP>6)
                LEFT_SIDE   => False)         -- True if the Pmod is on the left side of the board
        PORT MAP(
            clk          => CLK_100MHZ,
            reset        => RESET,
          
            pix_write    => data_to_oled_scr_wen,
            pix_col      => data_x_to_oled_rgb,
            pix_row      => data_y_to_oled_rgb,
            pix_data_in  => data_to_oled_rgb,
            pix_data_out => data_from_oled_rgb,
          
            PMOD_CS      => JA_PMOD_CS,
            PMOD_MOSI    => JA_PMOD_MOSI,
            PMOD_SCK     => JA_PMOD_SCK,
            PMOD_DC      => JA_PMOD_DC,
            PMOD_RES     => JA_PMOD_RES,
            PMOD_VCCEN   => JA_PMOD_VCCEN,
            PMOD_EN      => JA_PMOD_EN
        );

    data_to_oled_rgb   <= IO_mem_wdata(OLED_BPP-1 downto 0);

    data_x_to_oled_rgb <= std_logic_vector( to_unsigned(to_integer(UNSIGNED(IO_wordaddr)) mod 96, 7) );
    data_y_to_oled_rgb <= std_logic_vector( to_unsigned(to_integer(UNSIGNED(IO_wordaddr))   / 96, 6) );

	----------------------------------------------------------
	------                LED Control                  -------
	----------------------------------------------------------

    d32b_from_leds         <= x"0000000" & "00" & leds_buffer;
    d32b_from_swit         <= (others => '0');
    
    -- adresse de base        = uart_send
    -- adresse de base + 0x04 = uart_rcv
    d32b_from_uart         <= x"0000000" & "000" & (uart_ready) when IO_mem_addr(2) = '0' else
                              x"00000"   & "000" & data_from_uart_s  & data_from_uart_b;
                              
    d32b_from_spi          <= (others => '0');
    d32b_from_vga_buff     <= (others => '0');
    d32b_from_sd_card      <= (others => '0');
    d32b_from_ethernet     <= (others => '0');
    d32b_from_oled_rgb     <= x"0000" & data_from_oled_rgb; -- OLED_BPP
    --x"00" & (data_from_oled_rgb(14 downto 10) & "000") & (data_from_oled_rgb(9 downto 5) & "000") & (data_from_oled_rgb(4 downto 0) & "000");
--    d32b_from_timer        <= (others => '0');
--    d32b_from_led_rgb      <= (others => '0');
    
   IO_mem_rdata <= d32b_from_leds      when data_to_leds_en     = '1'
              else d32b_from_swit      when data_to_switch_en   = '1'
              else d32b_from_uart      when data_to_uart_en     = '1'
              else d32b_from_spi       when data_to_spi_en      = '1'
              else d32b_from_vga_buff  when data_to_vga_en      = '1'
              else d32b_from_sd_card   when data_to_sdcart_en   = '1'
              else d32b_from_ethernet  when data_to_ethernet_en = '1'
              else d32b_from_oled_rgb  when data_to_oled_scr_en = '1'
              else d32b_from_timer     when data_to_timer_en    = '1'
              else d32b_from_led_rgb   when data_to_ledrgb_en   = '1'
              else x"00000000";
   
   ---------------------------------------------------------------------------------------------------

end arch;

