library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.riscv_config.all;

use work.mem_ram_pkg.all; -- RAM
use work.mem_rom_pkg.all; -- ROM

entity riscv_soc_20k is
Port ( 
   CLOCK     : in  STD_LOGIC;
   RESET_i   : in  STD_LOGIC; -- INVERTED RESET
   user      : in  STD_LOGIC; -- INVERTED BUTTON
   LED       : out STD_LOGIC_VECTOR ( 5 downto 0);
   uart_rx   : in  STD_LOGIC;
   uart_tx   : out STD_LOGIC
);
end riscv_soc_20k;

architecture arch of riscv_soc_20k is

    COMPONENT riscv_no_mem IS
    PORT ( 
       CLK           : in  STD_LOGIC;
       resetn        : in  STD_LOGIC;

       im_addr       : out STD_LOGIC_VECTOR (31 downto 0);
       im_rdata      : in  STD_LOGIC_VECTOR (31 downto 0);
    
       dm_addr       : out STD_LOGIC_VECTOR (31 downto 0);
       dm_rdata      : in  STD_LOGIC_VECTOR (31 downto 0);
       dm_wdata      : out STD_LOGIC_VECTOR (31 downto 0);
       dm_wmask      : out STD_LOGIC_VECTOR ( 3 downto 0);
       dm_rd         : out STD_LOGIC;
       dm_wr         : out STD_LOGIC
    );
    END COMPONENT;


   ---------------------------------------------------------------------------------------------------
    
    COMPONENT uart_send is
      Generic (CLK_FREQU : integer := 27000000;
               BAUDRATE  : integer := 115200;
               DATA_SIZE : integer := 8);
      Port (
         clk   : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         TX    : out STD_LOGIC;
         din   : in  STD_LOGIC_VECTOR (DATA_SIZE - 1 downto 0);
         den   : in  STD_LOGIC;
         bsy   : out STD_LOGIC);
      end COMPONENT;
  
      COMPONENT uart_recv is
         Generic (CLK_FREQU : integer := 27000000;
                  BAUDRATE  : integer := 115200;
                  DATA_SIZE : integer := 8);
         Port ( clk   : in STD_LOGIC;
                reset : in STD_LOGIC;
                RX    : in STD_LOGIC;
                dout  : out STD_LOGIC_VECTOR (DATA_SIZE - 1 downto 0);
                den   : out STD_LOGIC);
      end COMPONENT;
                 
   SIGNAL im_addr     : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL im_rdata    : STD_LOGIC_VECTOR (31 downto 0);

   SIGNAL dm_addr     : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL dm_rdata    : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL dm_wdata    : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL dm_wmask    : STD_LOGIC_VECTOR ( 3 downto 0);
   SIGNAL dm_wmask_v  : STD_LOGIC_VECTOR ( 3 downto 0);
   SIGNAL dm_rd       : STD_LOGIC;
   SIGNAL dm_wr       : STD_LOGIC;

   SIGNAL RESET      : STD_LOGIC;
   SIGNAL RESETN     : STD_LOGIC;
   SIGNAL BUTTON     : STD_LOGIC;
   
    SIGNAL IO_wordaddr  : STD_LOGIC_VECTOR (13 downto 0);

    SIGNAL uart_ready : STD_LOGIC;
    SIGNAL uart_busy  : STD_LOGIC;

--    SIGNAL data_to_spi         : STD_LOGIC_VECTOR (7 downto 0);
--    SIGNAL data_from_spi_en    : STD_LOGIC;
--    SIGNAL data_from_spi       : STD_LOGIC_VECTOR (7 downto 0);
--    SIGNAL data_from_spi_busy  : STD_LOGIC;

    SIGNAL data_to_uart         : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL uart_for_debug       : STD_LOGIC_VECTOR (7 downto 0);

    SIGNAL data_from_uart_en    : STD_LOGIC;
    SIGNAL data_from_uart       : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL data_from_uart_s     : STD_LOGIC;
    SIGNAL data_from_uart_b     : STD_LOGIC_VECTOR (7 downto 0);

	SIGNAL   leds_buffer        : STD_LOGIC_VECTOR ( 5 downto 0);

	SIGNAL data_to_ram_en       : STD_LOGIC;
	SIGNAL data_to_leds_en      : STD_LOGIC;
--	SIGNAL data_to_switch_en    : STD_LOGIC;
	SIGNAL data_to_uart_en      : STD_LOGIC;
--	SIGNAL data_to_spi_en       : STD_LOGIC;
--	SIGNAL data_to_vga_en       : STD_LOGIC;
--	SIGNAL data_to_sdcart_en    : STD_LOGIC;
--	SIGNAL data_to_ethernet_en  : STD_LOGIC;
--	SIGNAL data_to_oled_scr_en  : STD_LOGIC;
	SIGNAL data_to_timer_en     : STD_LOGIC;
--	SIGNAL data_to_ledrgb_en    : STD_LOGIC;
	SIGNAL data_to_soc_id_en    : STD_LOGIC;

	SIGNAL data_to_ram_wen       : STD_LOGIC;
	SIGNAL data_to_leds_wen      : STD_LOGIC;
--	SIGNAL data_to_switch_wen    : STD_LOGIC;
	SIGNAL data_to_uart_wen      : STD_LOGIC;
--	SIGNAL data_to_spi_wen       : STD_LOGIC;
--	SIGNAL data_to_vga_wen       : STD_LOGIC;
--	SIGNAL data_to_sdcart_wen    : STD_LOGIC;
--	SIGNAL data_to_ethernet_wen  : STD_LOGIC;
--	SIGNAL data_to_oled_scr_wen  : STD_LOGIC;
	SIGNAL data_to_timer_wen     : STD_LOGIC;
--	SIGNAL data_to_ledrgb_wen    : STD_LOGIC;

    SIGNAL d32b_from_leds       : STD_LOGIC_VECTOR (31 downto 0);
--    SIGNAL d32b_from_swit       : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_uart       : STD_LOGIC_VECTOR (31 downto 0);
--    SIGNAL d32b_from_spi        : STD_LOGIC_VECTOR (31 downto 0);
--    SIGNAL d32b_from_vga_buff   : STD_LOGIC_VECTOR (31 downto 0);
--    SIGNAL d32b_from_sd_card    : STD_LOGIC_VECTOR (31 downto 0);
--    SIGNAL d32b_from_ethernet   : STD_LOGIC_VECTOR (31 downto 0);
--    SIGNAL d32b_from_oled_rgb   : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_timer      : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL d32b_from_ram        : STD_LOGIC_VECTOR (31 downto 0); 
	SIGNAL d32b_from_soc_id     : STD_LOGIC_VECTOR (31 downto 0);

begin

   -- 31   27   23   19    15   11    7    3  0
   -- 0000 0000 0000 0000  0000 0000  0000 0000 ROM      (0x00010000) -- 64 bytes max.
   -- 0000 0000 0000 0001  0000 0000  0000 0000 RAM      (0x00010000) -- 64 bytes max.
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

   data_to_ram_en       <= '1' WHEN dm_addr(27 downto 24) = "0000" else '0';

   data_to_leds_en      <= '1' WHEN dm_addr(27 downto 24) = "0100" else '0'; -- 0x04
--   data_to_switch_en    <= '1' WHEN dm_addr(27 downto 24) = "0101" else '0'; -- 0x05
   data_to_uart_en      <= '1' WHEN dm_addr(27 downto 24) = "0110" else '0'; -- 0x06
--   data_to_spi_en       <= '1' WHEN dm_addr(27 downto 24) = "0111" else '0'; -- 0x07
--   data_to_vga_en       <= '1' WHEN dm_addr(27 downto 24) = "1000" else '0'; -- 0x08
--   data_to_sdcart_en    <= '1' WHEN dm_addr(27 downto 24) = "1001" else '0'; -- 0x09
--   data_to_ethernet_en  <= '1' WHEN dm_addr(27 downto 24) = "1010" else '0'; -- 0x0A
--   data_to_oled_scr_en  <= '1' WHEN dm_addr(27 downto 24) = "1011" else '0'; -- 0x0B
   data_to_timer_en     <= '1' WHEN dm_addr(27 downto 24) = "1100" else '0'; -- 0x0C
--   data_to_ledrgb_en    <= '1' WHEN dm_addr(27 downto 24) = "1101" else '0'; -- 0x0D
   data_to_soc_id_en    <= '1' WHEN dm_addr(27 downto 24) = "1110" else '0'; -- 0x0E

   data_to_ram_wen      <= data_to_ram_en      and dm_wr;
   data_to_leds_wen     <= data_to_leds_en     and dm_wr;
--   data_to_switch_wen   <= data_to_switch_en   and dm_wr;
   data_to_uart_wen     <= data_to_uart_en     and dm_wr;
--   data_to_spi_wen      <= data_to_spi_en      and dm_wr;
--   data_to_vga_wen      <= data_to_vga_en      and dm_wr;
--   data_to_sdcart_wen   <= data_to_sdcart_en   and dm_wr;
--   data_to_ethernet_wen <= data_to_ethernet_en and dm_wr;
--   data_to_oled_scr_wen <= data_to_oled_scr_en and dm_wr;
   data_to_timer_wen    <= data_to_timer_en    and dm_wr;
--   data_to_ledrgb_wen   <= data_to_ledrgb_en   and dm_wr;

   ---------------------------------------------------------------------------------------------------

    time_ctrl : ENTITY work.timer_ctrl
        PORT MAP(
            clock     => CLOCK,
            reset     => RESET,
            addr_lsb  => dm_addr(3 downto 0),
            data_i    => dm_wdata,
            data_o    => d32b_from_timer,
            write_en  => data_to_timer_wen
        );

   ---------------------------------------------------------------------------------------------------

   ---------------------------------------------------------------------------------------------------

   PROCESS(CLOCK)
   BEGIN
      if rising_edge(CLOCK) then
         RESET  <=  NOT RESET_i; -- on tang nano board the button are inverted
         RESETN <=      RESET_i; -- meaning, equals '1' when unpressed
         BUTTON <= NOT     user;
      END IF;
   END PROCESS;

   ---------------------------------------------------------------------------------------------------

   CPU : riscv_no_mem
   PORT MAP(
      clk          => CLOCK,
      resetn       => RESETN,

      im_addr      => im_addr,
      im_rdata     => im_rdata,
   
      dm_addr      => dm_addr,
      dm_rdata     => dm_rdata,
      dm_wdata     => dm_wdata,
      dm_wmask     => dm_wmask,
      dm_rd        => dm_rd,
      dm_wr        => dm_wr   
   );

   ---------------------------------------------------------------------------------------------------

   IO_wordaddr <= dm_addr(15 downto 2);

   ---------------------------------------------------------------------------------------------------

   prog_rom : mem_rom
   PORT MAP ( 
       CLOCK  => CLOCK,
       ENABLE => '1',
       ADDR_R => im_addr(ROM_ADDR-1 downto 0),
       DATA_O => im_rdata
   );

   ---------------------------------------------------------------------------------------------------

   data_ram : mem_ram
   PORT MAP( 
      CLOCK   => CLOCK,
      ADDR_RW => dm_addr(RAM_ADDR-1 downto 0), -- E_word_addr,     -- adresse en lecture / ecriture
      ENABLE  => data_to_ram_en, -- state(E_bit),
      WRITE_M => dm_wmask_v,     -- E_storeMask, 
      DATA_W  => dm_wdata,       -- E_STORE_data,
      DATA_R  => d32b_from_ram   -- EM_Mdata
   );

   ---------------------------------------------------------------------------------------------------

   dm_wmask_v <= dm_wmask when data_to_ram_wen = '1' else "0000";

   ---------------------------------------------------------------------------------------------------

   process(CLOCK)
   begin   
      if rising_edge(CLOCK) then
         IF RESET = '1' THEN
            leds_buffer <= "000000";
         ELSIF data_to_leds_wen = '1' then
            leds_buffer <= dm_wdata(5 downto 0);
         end if;
      end if;
   end process;

   LED <= leds_buffer when RESET = '0' else "11111" & BUTTON;

   ---------------------------------------------------------
   
   UART_r_custom : UART_recv
   GENERIC MAP (
      CLK_FREQU => 27000000,
      BAUDRATE  => 115200,
      DATA_SIZE => 8)
   PORT MAP(
      clk     => CLOCK,
      reset   => reset,
      rx      => uart_rx,
      dout    => data_from_uart,
      den     => data_from_uart_en
   );
   
   ---------------------------------------------------------------------------------------------------

   UART_s_custom : uart_send
   GENERIC MAP (
      CLK_FREQU => 27000000,
      BAUDRATE  => 115200,
      DATA_SIZE => 8)
   PORT MAP(
      clk   => CLOCK,
      reset => reset,
      den   => data_to_uart_wen,
      din   => data_to_uart,
      TX    => uart_tx,
      bsy   => uart_busy);
   
   uart_ready   <= NOT uart_busy;
   data_to_uart <= dm_wdata(7 downto 0);
            
   ---------------------------------------------------------

   process(CLOCK)
   begin   
      if rising_edge(CLOCK) then
        IF RESET = '1' THEN
           data_from_uart_b <= x"00";
           data_from_uart_s <= '0'; 

        ELSIF data_from_uart_en = '1' THEN 
           data_from_uart_b <= data_from_uart;
           data_from_uart_s <= data_from_uart_en; 

        ELSIF (data_from_uart_en = '1') and (dm_rd = '1') THEN 
           data_from_uart_b <= x"00";
           data_from_uart_s <= '0'; 
        END IF;
      end if;
    end process;
 
	----------------------------------------------------------
	------                LED Control                  -------
	----------------------------------------------------------

    d32b_from_leds         <= x"000000" & "00" & leds_buffer;
--    d32b_from_swit         <= (others => '0');
     
    d32b_from_uart         <= x"0000000" & "000" & (uart_ready)  when dm_addr(2) = '0' else
                              x"00000"   & "000" & data_from_uart_s  & data_from_uart_b;
                              
--    d32b_from_spi          <= (others => '0');
--    d32b_from_vga_buff     <= (others => '0');
--    d32b_from_sd_card      <= (others => '0');
--    d32b_from_ethernet     <= (others => '0');
--    d32b_from_oled_rgb     <= (others => '0'); --x"0000" & data_from_oled_rgb; -- OLED_BPP
    
    dm_rdata <= d32b_from_leds         when data_to_leds_en     = '1'
--              else d32b_from_swit      when data_to_switch_en   = '1'
              else d32b_from_uart      when data_to_uart_en     = '1'
--              else d32b_from_spi       when data_to_spi_en      = '1'
--              else d32b_from_vga_buff  when data_to_vga_en      = '1'
--              else d32b_from_sd_card   when data_to_sdcart_en   = '1'
--              else d32b_from_ethernet  when data_to_ethernet_en = '1'
--              else d32b_from_oled_rgb  when data_to_oled_scr_en = '1'
              else d32b_from_timer     when data_to_timer_en    = '1'
--              else d32b_from_led_rgb   when data_to_ledrgb_en   = '1'
              else d32b_from_ram;

	d32b_from_soc_id <= x"0B5E1240";
   
   ---------------------------------------------------------------------------------------------------

end arch;

