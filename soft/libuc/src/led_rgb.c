#include "../libuc.h"


void led_rgb_set_red()
{
   volatile unsigned int* ptr_rgb = 0x0D000000;
   ( *ptr_rgb ) = 0x00000044;
}

void led_rgb_set_green()
{
   volatile unsigned int* ptr_rgb = 0x0D000000;
   ( *ptr_rgb ) = 0x00004400;
}

void led_rgb_set_blue()
{
   volatile unsigned int* ptr_rgb = 0x0D000000;
   ( *ptr_rgb ) = 0x00440000;
}

void led_rgb_set_color(const int color)
{
   volatile unsigned int* ptr_rgb = 0x0D000000;
   ( *ptr_rgb ) = color;
}

int led_rgb_get_color()
{
   volatile unsigned int* ptr_rgb = 0x0D000000;
   return ( *ptr_rgb );
}
