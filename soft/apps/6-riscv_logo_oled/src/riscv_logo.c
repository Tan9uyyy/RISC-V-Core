/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <libuc.h>

#include "riscv-96x64.h"

#define time_delay (1000000/2)

void draw_hline_left(const int y, const int offset, const int color)
{
   int start = 96 * y;
   for(int x = (95-offset); x >= offset; x -= 1)
   {
      set_pixel(start + x, color);
      sleep_cycles( time_delay ); // on attends 1 ms
   }
}

void draw_hline_right(const int y, const int offset, const int color)
{
   int start = 96 * y;
   for(int x = offset; x < (96-offset); x += 1)
   {
      set_pixel(start + x, color);
      sleep_cycles( time_delay ); // on attends 1 ms
   }
}

void draw_vline_down(const int x, const int offset, const int color)
{
   int pixel = x + offset * 96;
   for(int y = offset; y < (64-offset); y += 1)
   {
      set_pixel(pixel, color);
      pixel += 96;
      sleep_cycles( time_delay ); // on attends 1 ms
   }
}

void draw_vline_up(const int x, const int offset, const int color)
{
   int pixel = x + (63 - offset) * 96;
   for(int y = (63 - offset); y >= offset; y -= 1)
   {
      set_pixel(pixel, color);
      pixel -= 96;
      sleep_cycles( time_delay ); // on attends 1 ms
   }
}

int main()
{
// led_rgb_set_blue();

   print_string("(ii)\n");
   print_string("(ii) OLED drawing program !\n");
   print_string("(ii)\n");
   print_string("(ii) release :\n");
   print_string("(ii) ");
   print_string(__DATE__);
   print_string(" ");
   print_string(__TIME__);
   print_string( "\n");
   print_string("(ii)\n");

   clear_screen();

   print_string("(ii) Screen cleared\n");

// led_rgb_set_green();

   const int length = sizeof(riscv_96x64_map) / sizeof(unsigned short);
   const unsigned short*  array = (unsigned short*)riscv_96x64_map;
   for(int cnt = 0; cnt < length; cnt += 1)
   {
      set_pixel(cnt, array[cnt] );
   }

   print_string("(ii) Picture drawing is finished\n");

   for(int p = 0; p < 64/2; p += 1)
   {
      draw_hline_right(     p, p, 0x000);
      draw_vline_down (95 - p, p, 0x000);
      draw_hline_left (63 - p, p, 0x000);
      draw_vline_up   (     p, p, 0x000);
   }

   print_string("(ii) Annimation done\n");

//   led_rgb_set_red();

   return 0;
}
