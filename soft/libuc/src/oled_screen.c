#include "../libuc.h"


int pixel(const int r, const int g, const int b)
{
   const int rr = r & 0xF8;
   const int gg = g & 0xF8;
   const int bb = b & 0xF8;
   return ( (rr >> 3) | (gg << 2) | (bb << 7) );
}

int set_12b_from_16b(const int color)
{
   const int blue  = (color >>  1) & 0x0F;
   const int green = (color >>  7) & 0x0F;
   const int red   = (color >> 12) & 0x0F;
   return ( (blue) | (green << 4) | (red << 8) );
}


void set_pixel(const int offset, const int color)
{
   volatile unsigned int* screen = 0x0B000000;
   volatile unsigned int* pixel  = screen + offset;
   ( *pixel ) = color;
}

void clear_screen()
{
   volatile unsigned int* screen = 0x0B000000;
   for(int i = 0; i < 64 * 96; i += 1)
   {
      screen[i] = 0x000;
   }
}
