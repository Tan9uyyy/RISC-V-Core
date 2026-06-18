/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <libuc.h>

inline long cycles() {
   int cycles;
   asm volatile ("rdcycle %0" : "=r"(cycles));
   return cycles;
}

inline long insn() {
   int insns;
   asm volatile ("rdinstret %0" : "=r"(insns));
   return insns;
}

int main()
{
    print_string("              vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("                  vvvvvvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv\n");
    print_string("rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvv  \n");
    print_string("rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvv    \n");
    print_string("rr                vvvvvvvvvvvvvvvvvvvvvv      \n");
    print_string("rr            vvvvvvvvvvvvvvvvvvvvvvvv      rr\n");
    print_string("rrrr      vvvvvvvvvvvvvvvvvvvvvvvvvv      rrrr\n");
    print_string("rrrrrr      vvvvvvvvvvvvvvvvvvvvvv      rrrrrr\n");
    print_string("rrrrrrrr      vvvvvvvvvvvvvvvvvv      rrrrrrrr\n");
    print_string("rrrrrrrrrr      vvvvvvvvvvvvvv      rrrrrrrrrr\n");
    print_string("rrrrrrrrrrrr      vvvvvvvvvv      rrrrrrrrrrrr\n");
    print_string("rrrrrrrrrrrrrr      vvvvvv      rrrrrrrrrrrrrr\n");
    print_string("rrrrrrrrrrrrrrrr      vv      rrrrrrrrrrrrrrrr\n");
    print_string("rrrrrrrrrrrrrrrrrr          rrrrrrrrrrrrrrrrrr\n");
    print_string("rrrrrrrrrrrrrrrrrrrr      rrrrrrrrrrrrrrrrrrrr\n");
    print_string("rrrrrrrrrrrrrrrrrrrrrr  rrrrrrrrrrrrrrrrrrrrrr\n");

    int insn_v = insn  ();
    int time_v = cycles();

    print_string("> time : "); print_hex( time_v ); printf("\n");
    print_string("> insn : "); print_hex( insn_v ); printf("\n");

    print_string("> time : "); print_dec( time_v ); printf("\n");
    print_string("> insn : "); print_dec( insn_v ); printf("\n");

    return 0;
}
