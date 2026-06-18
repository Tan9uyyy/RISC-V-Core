/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include "fx_zicond.h"

int fx_zicond(const int _a, const int _b)
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