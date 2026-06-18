-------------------------------------------------------------------------------
-- Bitmap VGA display with 640x480 pixel resolution
--
-- Provides a bitmap interface for VGA display
-- input clock must be a multiple of 25MHz
-- Frequency must be indicated using the CLK_FREQ generic
--
-- RAM_BPP is the number of bits per pixel in memory
-- HARD_BPP is the actual number of bits for the VGA interface.
--   RAM_BPP <= HARD_BPP
-- if INDEXED = 0, output colors are decoded from the binary value in RAM,
-- if INDEXED = 1, output colors are defined according to a lookup table (palette)
-- if READBACK = 0, the graphic RAM read operation is disabled. This makes it
-- possible so save some resources if the feature is note used.
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity VGA_bitmap_320x240 is
    generic(CLK_FREQ : integer := 100000000;         -- clk frequency, must be multiple of 25M
            RAM_BPP  : integer range 1 to 12:= 1;    -- number of bits per pixel for display
            HARD_BPP : integer range 1 to 16:=12;    -- number of bits per pixel actually available in hardware
            INDEXED  : integer range 0 to  1:= 0;    -- colors are indexed (1) or directly coded from RAM value (0)
            READBACK : integer range 0 to  1:= 1);   -- readback enabled ? might save some resources
    port(clk          : in  std_logic;
         reset        : in  std_logic;
         VGA_hs       : out std_logic;   -- horisontal vga syncr.
         VGA_vs       : out std_logic;   -- vertical vga syncr.
         VGA_color    : out std_logic_vector(HARD_BPP - 1 downto 0);

         pixel_x      : in  std_logic_vector(8 downto 0);
         pixel_y      : in  std_logic_vector(7 downto 0);
         data_in      : in  std_logic_vector( RAM_BPP - 1 downto 0);
         data_write   : in  std_logic;
         data_read    : in  std_logic:='0';
         data_rout    : out std_logic;
         data_out     : out std_logic_vector( RAM_BPP - 1 downto 0);
         
         end_of_frame : out std_logic;

         palette_w    : in  std_logic:='0';
         palette_idx  : in  std_logic_vector( RAM_BPP - 1 downto 0):=(others => '0');
         palette_val  : in  std_logic_vector(HARD_BPP - 1 downto 0):=(others => '0'));
end VGA_bitmap_320x240;

architecture Behavioral of VGA_bitmap_320x240 is

begin


    preRAMaddr_x  <= "00000000" & pixel_x;
    preRAMaddr_y5 <= "0" & pixel_y & "00000000";
    preRAMaddr_y1 <= "000" & pixel_y & "000000";

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                RAM_addr <= (others => '1');
            elsif to_integer(unsigned(pixel_x)) > 319 then
                RAM_addr <= (others => '1');
            elsif to_integer(unsigned(pixel_y)) > 239 then
                RAM_addr <= (others => '1');
            else
                RAM_addr <= std_logic_vector(unsigned(preRAMaddr_x) + unsigned(preRAMaddr_y5) + unsigned(preRAMaddr_y1));
            end if;
            delayed_wr    <= data_write;
            if READBACK /= 0 then
                delayed_rd    <= data_read;
            else
                delayed_rd    <= '0';
            end if;
            pixel_in_dly0 <= data_in;
            
            RAM_addr0     <= RAM_addr(15 downto 0);
            delayed_wr0   <= delayed_wr and not RAM_addr(16);
            delayed_rd0   <= delayed_rd and not RAM_addr(16);
            RAM_addr1     <= RAM_addr(13 downto 0);
            delayed_wr1   <= delayed_wr and RAM_addr(16) and not RAM_addr(15) and not RAM_addr(14);
            delayed_rd1   <= delayed_rd and RAM_addr(16) and not RAM_addr(15) and not RAM_addr(14);
            pixel_in_dly1 <= pixel_in_dly0;

            delayed_rdp0  <= delayed_rd0;
            delayed_rdp1  <= delayed_rd1;

        end if;
    end process;


    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pix_read_addr <= (others => '0');
            elsif Vsync_state = state_sync then
                pix_read_addr <= (others => '0');
            elsif clk_prediv_en  = '1' and Vsync_state = state_display and Hsync_state = state_display and Hsync_cnt mod 2 = 1 then
                pix_read_addr <= std_logic_vector(unsigned(pix_read_addr)+1);
            elsif clk_prediv_en  = '1' and Vsync_state = state_display and Hsync_state = state_sync and Hsync_cnt = 0 and (Vsync_cnt mod 2 = 0) then
                pix_read_addr <= std_logic_vector(unsigned(pix_read_addr)-320);
            end if;
        end if;
    end process;


    process(clk)
    begin
        if rising_edge(clk) then
            -- if reset = '1' then
            --     pix_read_addr0 <= (others => '0');
            --     pix_read_addr1 <= (others => '0');
            -- else
                pix_read_addr0     <= pix_read_addr(15 downto 0);
                pix_read_addr1     <= pix_read_addr(13 downto 0);
                pix_read_MSBdly(0) <= pix_read_addr(16);
                pix_read_MSBdly(1) <= pix_read_MSBdly(0);
            -- end if;
        end if;
    end process;


    -- This process performs data access (read and write) to the memory
    memory_management : process(clk)
    begin
       if rising_edge(clk) then
          next_pixel0 <= screen0(to_integer(unsigned(pix_read_addr0)));
          next_pixel1 <= screen1(to_integer(unsigned(pix_read_addr1)));
          
          data_out0   <= screen0(to_integer(unsigned(RAM_addr0)));
          data_out1   <= screen1(to_integer(unsigned(RAM_addr1)));
          if delayed_wr0 = '1' then
             screen0(to_integer(unsigned(RAM_addr0))) <= pixel_in_dly1;
          end if;
          if delayed_wr1 = '1' then
             screen1(to_integer(unsigned(RAM_addr1))) <= pixel_in_dly1;
          end if;
       end if;
    end process;

    -- data output process
    dout_mgr : process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                data_out  <= (others => '0');
                data_rout <= '0';
            elsif delayed_rdp0 = '1' then
                data_out  <= data_out0;
                data_rout <= '1';
            elsif delayed_rdp1 = '1' then
                data_out  <= data_out1;
                data_rout <= '1';
            else
                data_out  <= (others => '0');
                data_rout <= '0';
            end if;
       end if;
    end process;

---------------------------------------------------------------------

process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            clk_prediv_cnt <= clk_prediv;
            clk_prediv_en  <= '0';
        elsif clk_prediv_cnt = 0 then
            clk_prediv_cnt <= clk_prediv;
            clk_prediv_en  <= '1';
        else
            clk_prediv_cnt <= clk_prediv_cnt - 1;
            clk_prediv_en  <= '0';
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            Hsync_state <= state_front_porch;
            Hsync_cnt   <= H_frontporch-1;
        elsif clk_prediv_en  = '1' then
            case Hsync_state is
                when state_back_porch  =>
                    if Hsync_cnt = H_backporch then
                        Hsync_cnt   <= 0;
                        Hsync_state <= state_display;
                    else
                        Hsync_cnt   <= Hsync_cnt + 1;
                    end if;
                when state_sync        =>
                    if Hsync_cnt = H_syncpulse then
                        Hsync_cnt   <= 0;
                        Hsync_state <= state_back_porch;
                    else
                        Hsync_cnt   <= Hsync_cnt + 1;
                    end if;
                when state_front_porch =>
                    if Hsync_cnt = H_frontporch then
                        Hsync_cnt   <= 0;
                        Hsync_state <= state_sync;
                    else
                        Hsync_cnt   <= Hsync_cnt + 1;
                    end if;
                when state_display     =>
                    if Hsync_cnt = H_pixsize then
                        Hsync_cnt   <= 0;
                        Hsync_state <= state_front_porch;
                    else
                        Hsync_cnt   <= Hsync_cnt + 1;
                    end if;
            end case;
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            new_line_en <= False;
        elsif clk_prediv = 0 and Hsync_state = state_sync and Hsync_cnt = H_syncpulse-1 then
            new_line_en <= True;
        elsif clk_prediv /= 0 and clk_prediv_cnt = 0 and Hsync_state = state_sync and Hsync_cnt = H_syncpulse then
            new_line_en <= True;
        else
            new_line_en <= False;
        end if;
    end if;
end process;


process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            VGA_hs_dly <= (others => '1');
            VGA_hs     <= '1';
        elsif Hsync_state = state_sync then
            VGA_hs_dly(0)          <= H_sync_pos;
            VGA_hs_dly(2 downto 1) <= VGA_hs_dly(1 downto 0);
            VGA_hs                 <= VGA_hs_dly(2);
        else
            VGA_hs_dly(0)          <= not H_sync_pos;
            VGA_hs_dly(2 downto 1) <= VGA_hs_dly(1 downto 0);
            VGA_hs                 <= VGA_hs_dly(2);
        end if;
    end if;
end process;


end_of_frame <= local_frame_end;


process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            local_frame_end <= '1';
        elsif Vsync_state = state_display and Vsync_cnt = V_pixsize and Hsync_state = state_front_porch then
            local_frame_end <= '1';
        else
            local_frame_end <= '0';
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            Vsync_state     <= state_front_porch;
            Vsync_cnt       <= V_frontporch-1;
        elsif new_line_en then
            case Vsync_state is
                when state_back_porch  =>
                    if Vsync_cnt = V_backporch then
                        Vsync_cnt   <= 0;
                        Vsync_state <= state_display;
                    else
                        Vsync_cnt   <= Vsync_cnt + 1;
                    end if;
                when state_sync        =>
                    if Vsync_cnt = V_syncpulse then
                        Vsync_cnt   <= 0;
                        Vsync_state <= state_back_porch;
                    else
                        Vsync_cnt   <= Vsync_cnt + 1;
                    end if;
                when state_front_porch =>
                    if Vsync_cnt = V_frontporch then
                        Vsync_cnt   <= 0;
                        Vsync_state <= state_sync;
                    else
                        Vsync_cnt   <= Vsync_cnt + 1;
                    end if;
                when state_display     =>
                    if Vsync_cnt = V_pixsize then
                        Vsync_cnt       <= 0;
                        Vsync_state     <= state_front_porch;
                    else
                        Vsync_cnt   <= Vsync_cnt + 1;
                    end if;
            end case;
        end if;
    end if;
end process;


process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            VGA_vs_dly <= (others => '1');
            VGA_vs     <= '1';
        elsif Vsync_state = state_sync then
            VGA_vs_dly(0)          <= V_sync_pos;
            VGA_vs_dly(2 downto 1) <= VGA_vs_dly(1 downto 0);
            VGA_vs                 <= VGA_vs_dly(2);
        else
            VGA_vs_dly(0)          <= not V_sync_pos;
            VGA_vs_dly(2 downto 1) <= VGA_vs_dly(1 downto 0);
            VGA_vs                 <= VGA_vs_dly(2);
        end if;
    end if;
end process;



process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            next_pixel <= (others => '0');
        elsif pix_read_MSBdly(1) = '0' then
            next_pixel <= next_pixel0;
        else
            next_pixel <= next_pixel1;
        end if;
        if Vsync_state = state_display and Hsync_state = state_display then
            pixout(0) <= '1';
        else
            pixout(0) <= '0';
        end if;
        pixout(2 downto 1) <= pixout(1 downto 0);

    end if;
end process;


process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            VGA_color <= (others => '0');
        elsif pixout(2) = '0' then
            VGA_color <= (others => '0');
        elsif INDEXED /= 0 then
            VGA_color <= palette(to_integer(unsigned(next_pixel)));
        else
        
            case RAM_BPP is
                when 1 =>
                    VGA_color <= (others => next_pixel(0));
                when 2 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= (others => (next_pixel(0) and next_pixel(1)));
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= (others => (next_pixel(1) and not next_pixel(0)));
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= (others => (next_pixel(0) and not next_pixel(1)));
                when 3 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= (others =>  next_pixel(2));
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= (others =>  next_pixel(1));
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= (others =>  next_pixel(0));
                when 4 =>
                    if next_pixel="1000" then
                        VGA_color(HARD_BPP-1)            <= '0';
                        VGA_color(HARD_BPP-HARD_BPP/3-1) <= '0';
                        VGA_color(         HARD_BPP/3-1) <= '0';
                        VGA_color(HARD_BPP-2)            <= '1';
                        VGA_color(HARD_BPP-HARD_BPP/3-2) <= '1';
                        VGA_color(         HARD_BPP/3-2) <= '1';
                        VGA_color(HARD_BPP-3            downto HARD_BPP-HARD_BPP/3) <= (others =>  '0');
                        VGA_color(HARD_BPP-HARD_BPP/3-3 downto HARD_BPP/3)          <= (others =>  '0');
                        VGA_color(         HARD_BPP/3-3 downto 0)                   <= (others =>  '0');
                    else
                        VGA_color(HARD_BPP-1)            <= next_pixel(2);
                        VGA_color(HARD_BPP-HARD_BPP/3-1) <= next_pixel(1);
                        VGA_color(         HARD_BPP/3-1) <= next_pixel(0);
                        VGA_color(HARD_BPP-2            downto HARD_BPP-HARD_BPP/3) <= (others =>  (next_pixel(2) and next_pixel(3)));
                        VGA_color(HARD_BPP-HARD_BPP/3-2 downto HARD_BPP/3)          <= (others =>  (next_pixel(1) and next_pixel(3)));
                        VGA_color(         HARD_BPP/3-2 downto 0)                   <= (others =>  (next_pixel(0) and next_pixel(3)));
                    end if;
                when 6 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= fill(next_pixel(5 downto 4),  HARD_BPP   /3);
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= fill(next_pixel(3 downto 2), (HARD_BPP+2)/3);
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= fill(next_pixel(1 downto 0),  HARD_BPP   /3);
                when 7 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= fill(next_pixel(7 downto 5),  HARD_BPP   /3);
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= fill(next_pixel(4 downto 2), (HARD_BPP+2)/3);
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= fill(next_pixel(1 downto 0),  HARD_BPP   /3);
                when 9 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= fill(next_pixel(8 downto 6),  HARD_BPP   /3);
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= fill(next_pixel(5 downto 3), (HARD_BPP+2)/3);
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= fill(next_pixel(2 downto 0),  HARD_BPP   /3);
                when 10 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= fill(next_pixel(9 downto 7),  HARD_BPP   /3);
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= fill(next_pixel(6 downto 3), (HARD_BPP+2)/3);
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= fill(next_pixel(2 downto 0),  HARD_BPP   /3);
                when 12 =>
                    VGA_color(HARD_BPP-1            downto HARD_BPP-HARD_BPP/3) <= fill(next_pixel(11 downto 8),  HARD_BPP   /3);
                    VGA_color(HARD_BPP-HARD_BPP/3-1 downto HARD_BPP/3)          <= fill(next_pixel( 7 downto 4), (HARD_BPP+2)/3);
                    VGA_color(         HARD_BPP/3-1 downto 0)                   <= fill(next_pixel( 3 downto 0),  HARD_BPP   /3);
                when others =>
                    VGA_color <= (others => '0');
            end case;
      end if;
   end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if INDEXED /= 0 then
            i_palette_w   <= palette_w;
            i_palette_idx <= palette_idx;
            i_palette_val <= palette_val;
            if i_palette_w = '1' then
                palette(to_integer(unsigned(i_palette_idx))) <= i_palette_val;
            end if;
        end if;
    end if;
end process;


----------------------

end Behavioral;
