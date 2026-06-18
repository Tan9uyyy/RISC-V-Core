//#include <femtostdlib.h>
#include "../libuc.h"

int putchar(const int c)
{
   volatile unsigned int* uart_ou = 0x06000000;
   while( (*uart_ou) == 0 );                    // on attend que l'uart soit ready
   ( *uart_ou ) = c;                            // on envoie le char
}
/*
void putchar(const char c)
{
   volatile unsigned int* uart_ou = 0x400008;
   ( *uart_ou ) = c;
}
*/
/* print_dec, print_hex taken from picorv32 */

void print_string(const char* s)
{
   for(const char* p = s; *p; ++p)
   {
      putchar(*p);
   }
}

int puts(const char* s)
{
   print_string(s);
   putchar('\n');
   return 1;
}

void print_dec(int val)
{
   char buffer[255];
   char *p = buffer;
   if(val < 0) {
      putchar('-');
      print_dec(-val);
      return;
   }
   while (val || p == buffer) {
      *(p++) = val % 10;
      val = val / 10;
   }
   while (p != buffer) {
      putchar('0' + *(--p));
   }
}

void print_hex_digits(unsigned int val, int nbdigits)
{
   const char arr[] = "0123456789ABCDEF";
   for (int i = (4 * nbdigits)-4; i >= 0; i -= 4)
   {
      const int idx = (val >> i) & 0x0F; // 16
      putchar( arr[idx] );
   }
}

void print_hex(unsigned int val)
{
   print_hex_digits(val, 8);
}
