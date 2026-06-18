/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include "fx_rv32i.h"

int fx_rv32i(const int _a, const int _b)
{
   int a = _a;
   int b = _b;

   while( a != b )
   {
      if( a > b )
         a -= b;
      else
         b -= a;
   }

   return a;
}