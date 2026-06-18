/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <libuc.h>

inline long insn() {
   int insns;
   asm volatile ("rdinstret %0" : "=r"(insns));
   return insns;
}

int main()
{

   int a = 1;
   int b = 3;
   for(int i = 5; i < 16; i += 1)
   {
      const int y = a * (i % (23));
      print_string("> result : "); print_dec( y ); printf("\n");
      a = y;
   }

   int insn_v = insn();
   int time_v = time();

   print_string("> time : "); print_dec( time_v ); printf("\n");
   print_string("> insn : "); print_dec( insn_v ); printf("\n");

   return 0;
}
