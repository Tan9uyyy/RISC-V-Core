/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <libuc.h>

#include "fx_rv32i.h"
#include "fx_zicond.h"

int main()
{
   const int array_a[]  = { 1, 13, 12, 63,  1, 221, 783462};
   const int array_b[]  = {13,  1,  9,  1, 73, 782, 984372};
   const int array_r[]  = { 1,  1,  3,  1,  1,  17,      6};

         int array_t0[] = { 0,  0,  0,  0,  0,   0,      0};
         int array_t1[] = { 0,  0,  0,  0,  0,   0,      0};

   print_string("Zicond ISA test application...\n");

   for(int xx = 0; xx < (sizeof(array_a) / sizeof(int)); xx += 1)
   {
      int insn_i   = time();
      int r_value  = fx_rv32i( array_a[xx], array_b[xx] );
      int insn_o   = time();
      array_t0[xx] = insn_o - insn_i;

      if( r_value != array_r[xx] )
      {
         print_string("> wrong result:\n");
         print_string("  iteration   : "); print_hex( xx      ); printf("\n");
         print_string("  result (1)  : "); print_hex( r_value ); printf("\n");
      }

      insn_i       = time();
      r_value      = fx_zicond( array_a[xx], array_b[xx] );
      insn_o       = time();
      array_t1[xx] = insn_o - insn_i;

      if( r_value != array_r[xx] )
      {
         print_string("> wrong result:\n");
         print_string("  iteration   : "); print_hex( xx      ); printf("\n");
         print_string("  result (2)  : "); print_hex( r_value ); printf("\n");
      }

   }

   print_string("Exec. time report:\n");
   print_string(" ref.   : ");
   for(int xx = 0; xx < (sizeof(array_a) / sizeof(int)); xx += 1)
   {
      print_dec( array_t0[xx] ); printf("  ");
   }
   printf("\n");

   print_string(" zicond : ");
   for(int xx = 0; xx < (sizeof(array_a) / sizeof(int)); xx += 1)
   {
      print_dec( array_t1[xx] ); printf("  ");
   }
   printf("\n");

   return 0;
}
