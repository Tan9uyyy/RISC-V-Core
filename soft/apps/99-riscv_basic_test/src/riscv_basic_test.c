/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <femtostdlib.h>

long time( void )
{
   int cycles;
   asm volatile ("rdcycle %0" : "=r"(cycles));
   return cycles;
}

long insn( void )
{
   int insns;
   asm volatile ("rdinstret %0" : "=r"(insns));
   return insns;
}

#define STR_IMPL_(x) #x      //stringify argument
#define STR(x) STR_IMPL_(x)  //indirection to expand argument macros

#define TEST_RR_OP( testnum, inst, result, val1, val2 ) \
      a = val1;    \
      b = val2;    \
      asm(STR(inst)" %[val_r], %[val_a], %[val_b]" \
        :[val_r] "=r" (r) \
        :[val_a] "r" (a), [val_b] "r" (b)); \
      if( r != result ) { asm volatile ("ebreak"); printf(" Error R2R in test "); print_dec( testnum );  printf(" : "); print_hex(r); printf("\n"); asm volatile ("ebreak");}

#define TEST_IMM_OP( testnum, inst, result, val1, val2 ) \
      a = val1;     \
      asm(STR(inst)" %[val_r], %[val_a], %[val_b]" \
        :[val_r] "=r" (r) \
        :[val_a] "r" (a), [val_b] "i" ((int)val2)); \
      if( r != result ) { asm volatile ("ebreak"); printf(" Error R2I in test "); print_dec( testnum ); printf(" : "); print_hex(r); printf("\n"); asm volatile ("ebreak"); }

#define TEST_SRLI(n, v, a) \
  TEST_IMM_OP(n, srli, ((v) & ((1 << (32-1) << 1) - 1)) >> (a), v, a)

int main()
{   
   int a;
   int b;
   int r;

   print_string("(ii) Starting RISC-V test...\n");
   TEST_RR_OP (  0, add,   0x00000000, 0x00000000, 0x00000000 );
   TEST_RR_OP (  1, add,   0x00000002, 0x00000001, 0x00000001 );
   TEST_RR_OP (  2, add,   0x0000000a, 0x00000003, 0x00000007 );

   TEST_IMM_OP(  3, addi,  0x00000000, 0x00000000, 0x000 );
   TEST_IMM_OP(  4, addi,  0x00000002, 0x00000001, 0x001 );
   TEST_IMM_OP(  5, addi,  0x0000000a, 0x00000003, 0x007 );

   TEST_RR_OP (  6, and,   0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
   TEST_RR_OP (  7, and,   0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
   TEST_RR_OP (  8, and,   0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
   TEST_RR_OP (  9, and,   0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );

   TEST_IMM_OP( 10, andi,  0xff00ff00, 0xff00ff00, 0xffffff0f );
   TEST_IMM_OP( 11, andi,  0x000000f0, 0x0ff00ff0, 0x000000f0 );
   TEST_IMM_OP( 12, andi,  0x0000000f, 0x00ff00ff, 0x0000070f );
   TEST_IMM_OP( 13, andi,  0x00000000, 0xf00ff00f, 0x000000f0 );

   TEST_RR_OP ( 14, or,    0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
   TEST_RR_OP ( 15, or,    0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
   TEST_RR_OP ( 16, or,    0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
   TEST_RR_OP ( 17, or,    0xf0fff0ff, 0xf00ff00f, 0xf0f0f0f0 );
   
   TEST_IMM_OP( 18, ori,   0xffffff0f, 0xff00ff00, 0xffffff0f );
   TEST_IMM_OP( 19, ori,   0x0ff00ff0, 0x0ff00ff0, 0x000000f0 );
   TEST_IMM_OP( 20, ori,   0x00ff07ff, 0x00ff00ff, 0x0000070f );
   TEST_IMM_OP( 21, ori,   0xf00ff0ff, 0xf00ff00f, 0x000000f0 );




   TEST_RR_OP ( 23, sll,   0x00000001, 0x00000001, 0  );
   TEST_RR_OP ( 24, sll,   0x00000002, 0x00000001, 1  );
   TEST_RR_OP ( 25, sll,   0x00000080, 0x00000001, 7  );
   TEST_RR_OP ( 26, sll,   0x00004000, 0x00000001, 14 );

   TEST_RR_OP ( 27, sll,   0x80000000, 0x00000001, 31 );
   TEST_RR_OP ( 28, sll,   0xffffffff, 0xffffffff, 0  );
   TEST_RR_OP ( 29, sll,   0xfffffffe, 0xffffffff, 1  );
   TEST_RR_OP ( 30, sll,   0xffffff80, 0xffffffff, 7  );
   TEST_RR_OP ( 31, sll,   0xffffc000, 0xffffffff, 14 );
   TEST_RR_OP ( 32, sll,   0x80000000, 0xffffffff, 31 );
   TEST_RR_OP ( 33, sll,   0x21212121, 0x21212121, 0  );
   TEST_RR_OP ( 34, sll,   0x42424242, 0x21212121, 1  );
   TEST_RR_OP ( 35, sll,   0x90909080, 0x21212121, 7  );
   TEST_RR_OP ( 36, sll,   0x48484000, 0x21212121, 14 );
   TEST_RR_OP ( 37, sll,   0x80000000, 0x21212121, 31 );
   TEST_RR_OP ( 38, sll,   0x21212121, 0x21212121, 0xffffffc0 );
   TEST_RR_OP ( 39, sll,   0x42424242, 0x21212121, 0xffffffc1 );
   TEST_RR_OP ( 40, sll,   0x90909080, 0x21212121, 0xffffffc7 );
   TEST_RR_OP ( 41, sll,   0x48484000, 0x21212121, 0xffffffce );

   TEST_IMM_OP( 42, slli,  0x00000001, 0x00000001, 0  );
   TEST_IMM_OP( 43, slli,  0x00000002, 0x00000001, 1  );
   TEST_IMM_OP( 44, slli,  0x00000080, 0x00000001, 7  );
   TEST_IMM_OP( 45, slli,  0x00004000, 0x00000001, 14 );
   TEST_IMM_OP( 46, slli,  0x80000000, 0x00000001, 31 );
   TEST_IMM_OP( 47, slli,  0xffffffff, 0xffffffff, 0  );
   TEST_IMM_OP( 48, slli,  0xfffffffe, 0xffffffff, 1  );
   TEST_IMM_OP( 49, slli,  0xffffff80, 0xffffffff, 7  );
   TEST_IMM_OP( 50, slli,  0xffffc000, 0xffffffff, 14 );
   TEST_IMM_OP( 51, slli,  0x80000000, 0xffffffff, 31 );
   TEST_IMM_OP( 52, slli,  0x21212121, 0x21212121, 0  );
   TEST_IMM_OP( 53, slli,  0x42424242, 0x21212121, 1  );
   TEST_IMM_OP( 54, slli,  0x90909080, 0x21212121, 7  );
   TEST_IMM_OP( 55, slli,  0x48484000, 0x21212121, 14 );
   TEST_IMM_OP( 56, slli,  0x80000000, 0x21212121, 31 );
  
   TEST_RR_OP ( 57,  sra,  0x80000000, 0x80000000, 0  );
   TEST_RR_OP ( 58,  sra,  0xc0000000, 0x80000000, 1  );
   TEST_RR_OP ( 59,  sra,  0xff000000, 0x80000000, 7  );
   TEST_RR_OP ( 60,  sra,  0xfffe0000, 0x80000000, 14 );
   TEST_RR_OP ( 61,  sra,  0xffffffff, 0x80000001, 31 );
   TEST_RR_OP ( 62,  sra,  0x7fffffff, 0x7fffffff, 0  );
   TEST_RR_OP ( 63,  sra,  0x3fffffff, 0x7fffffff, 1  );
   TEST_RR_OP ( 64,  sra,  0x00ffffff, 0x7fffffff, 7  );
   TEST_RR_OP ( 65,  sra,  0x0001ffff, 0x7fffffff, 14 );
   TEST_RR_OP ( 66,  sra,  0x00000000, 0x7fffffff, 31 );
   TEST_RR_OP ( 67,  sra,  0x81818181, 0x81818181, 0  );
   TEST_RR_OP ( 68,  sra,  0xc0c0c0c0, 0x81818181, 1  );
   TEST_RR_OP ( 69,  sra,  0xff030303, 0x81818181, 7  );

   TEST_RR_OP ( 70,  sra,  0xfffe0606, 0x81818181, 14 );
   TEST_RR_OP ( 71,  sra,  0xffffffff, 0x81818181, 31 );
   TEST_RR_OP ( 72,  sra,  0x81818181, 0x81818181, 0xffffffc0 );
   TEST_RR_OP ( 73,  sra,  0xc0c0c0c0, 0x81818181, 0xffffffc1 );
   TEST_RR_OP ( 74,  sra,  0xff030303, 0x81818181, 0xffffffc7 );
   TEST_RR_OP ( 75,  sra,  0xfffe0606, 0x81818181, 0xffffffce );
   TEST_RR_OP ( 76,  sra,  0xffffffff, 0x81818181, 0xffffffff );

   TEST_IMM_OP( 77,  srai, 0x00000000, 0x00000000, 0  );
   TEST_IMM_OP( 78,  srai, 0xc0000000, 0x80000000, 1  );
   TEST_IMM_OP( 79,  srai, 0xff000000, 0x80000000, 7  );
   TEST_IMM_OP( 80,  srai, 0xfffe0000, 0x80000000, 14 );
   TEST_IMM_OP( 81,  srai, 0xffffffff, 0x80000001, 31 );
   TEST_IMM_OP( 82,  srai, 0x7fffffff, 0x7fffffff, 0  );
   TEST_IMM_OP( 83,  srai, 0x3fffffff, 0x7fffffff, 1  );
   TEST_IMM_OP( 84,  srai, 0x00ffffff, 0x7fffffff, 7  );
   TEST_IMM_OP( 85,  srai, 0x0001ffff, 0x7fffffff, 14 );
   TEST_IMM_OP( 86,  srai, 0x00000000, 0x7fffffff, 31 );
   TEST_IMM_OP( 87,  srai, 0x81818181, 0x81818181, 0  );
   TEST_IMM_OP( 88,  srai, 0xc0c0c0c0, 0x81818181, 1  );
   TEST_IMM_OP( 89,  srai, 0xff030303, 0x81818181, 7  );
   TEST_IMM_OP( 90,  srai, 0xfffe0606, 0x81818181, 14 );
   TEST_IMM_OP( 91,  srai, 0xffffffff, 0x81818181, 31 );

   TEST_RR_OP ( 92,  srl,  0x21212121, 0x21212121, 0xffffffc0 );
   TEST_RR_OP ( 93,  srl,  0x10909090, 0x21212121, 0xffffffc1 );
   TEST_RR_OP ( 94,  srl,  0x00424242, 0x21212121, 0xffffffc7 );
   TEST_RR_OP ( 95,  srl,  0x00008484, 0x21212121, 0xffffffce );
   TEST_RR_OP ( 96,  srl,  0x00000000, 0x21212121, 0xffffffff );

   TEST_SRLI  ( 97,        0x80000000, 0  );
   TEST_SRLI  ( 98,        0x80000000, 1  );
   TEST_SRLI  ( 99,        0x80000000, 7  );
   TEST_SRLI  (100,        0x80000000, 14 );
   TEST_SRLI  (101,        0x80000001, 31 );
   TEST_SRLI  (102,        0xffffffff, 0  );
   TEST_SRLI  (103,        0xffffffff, 1  );
   TEST_SRLI  (104,        0xffffffff, 7  );
   TEST_SRLI  (105,        0xffffffff, 14 );
   TEST_SRLI  (106,        0xffffffff, 31 );
   TEST_SRLI  (107,        0x21212121, 0  );
   TEST_SRLI  (108,        0x21212121, 1  );
   TEST_SRLI  (109,        0x21212121, 7  );
   TEST_SRLI  (110,        0x21212121, 14 );
   TEST_SRLI  (111,        0x21212121, 31 );

   TEST_RR_OP (112,  sub,  0x00000000, 0x00000000, 0x00000000 );
   TEST_RR_OP (113,  sub,  0x00000000, 0x00000001, 0x00000001 );
   TEST_RR_OP (114,  sub,  0xfffffffc, 0x00000003, 0x00000007 );
   TEST_RR_OP (115,  sub,  0x00008000, 0x00000000, 0xffff8000 );
   TEST_RR_OP (116,  sub,  0x80000000, 0x80000000, 0x00000000 );
   TEST_RR_OP (117,  sub,  0x80008000, 0x80000000, 0xffff8000 );
   TEST_RR_OP (118,  sub,  0xffff8001, 0x00000000, 0x00007fff );
   TEST_RR_OP (119,  sub,  0x7fffffff, 0x7fffffff, 0x00000000 );
   TEST_RR_OP (120,  sub,  0x7fff8000, 0x7fffffff, 0x00007fff );
   TEST_RR_OP (121,  sub,  0x7fff8001, 0x80000000, 0x00007fff );
   TEST_RR_OP (122,  sub,  0x80007fff, 0x7fffffff, 0xffff8000 );
   TEST_RR_OP (123,  sub,  0x00000001, 0x00000000, 0xffffffff );
   TEST_RR_OP (124,  sub,  0xfffffffe, 0xffffffff, 0x00000001 );
   TEST_RR_OP (125,  sub,  0x00000000, 0xffffffff, 0xffffffff );

   TEST_RR_OP (126,  xor,  0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
   TEST_RR_OP (127,  xor,  0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
   TEST_RR_OP (128,  xor,  0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
   TEST_RR_OP (129,  xor,  0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );

   TEST_IMM_OP(130,  xori, 0xff00f00f, 0x00ff0f00, 0xffffff0f );
   TEST_IMM_OP(131,  xori, 0x0ff00f00, 0x0ff00ff0, 0x000000f0 );
   TEST_IMM_OP(132,  xori, 0x00ff0ff0, 0x00ff08ff, 0x0000070f );
   TEST_IMM_OP(133,  xori, 0xf00ff0ff, 0xf00ff00f, 0x000000f0 );

   TEST_RR_OP (134,  slt,   0, 0x00000000, 0x00000000 );
   TEST_RR_OP (135,  slt,   0, 0x00000001, 0x00000001 );
   TEST_RR_OP (136,  slt,   1, 0x00000003, 0x00000007 );
   TEST_RR_OP (137,  slt,   0, 0x00000007, 0x00000003 );
   TEST_RR_OP (138,  slt,   0, 0x00000000, 0xffff8000 );
   TEST_RR_OP (139,  slt,   1, 0x80000000, 0x00000000 );
   TEST_RR_OP (140,  slt,   1, 0x80000000, 0xffff8000 );
   TEST_RR_OP (141,  slt,   1, 0x00000000, 0x00007fff );
   TEST_RR_OP (142,  slt,   0, 0x7fffffff, 0x00000000 );
   TEST_RR_OP (143,  slt,   0, 0x7fffffff, 0x00007fff );
   TEST_RR_OP (144,  slt,   1, 0x80000000, 0x00007fff );
   TEST_RR_OP (145,  slt,   0, 0x7fffffff, 0xffff8000 );
   TEST_RR_OP (146,  slt,   0, 0x00000000, 0xffffffff );
   TEST_RR_OP (147,  slt,   1, 0xffffffff, 0x00000001 );
   TEST_RR_OP (148,  slt,   0, 0xffffffff, 0xffffffff );

   TEST_IMM_OP(149,  slti,  0, 0x00000000, 0x00000000 );
   TEST_IMM_OP(150,  slti,  0, 0x00000001, 0x00000001 );
   TEST_IMM_OP(151,  slti,  1, 0x00000003, 0x00000007 );
   TEST_IMM_OP(152,  slti,  0, 0x00000007, 0x00000003 );
   TEST_IMM_OP(153,  slti,  0, 0x00000000, 0xfffff800 );
   TEST_IMM_OP(154,  slti,  1, 0x80000000, 0x00000000 );
   TEST_IMM_OP(155,  slti,  1, 0x80000000, 0xfffff800 );
   TEST_IMM_OP(156,  slti,  1, 0x00000000, 0x000007ff );
   TEST_IMM_OP(157,  slti,  0, 0x7fffffff, 0x00000000 );
   TEST_IMM_OP(158,  slti,  0, 0x7fffffff, 0x000007ff );
   TEST_IMM_OP(159,  slti,  1, 0x80000000, 0x000007ff );
   TEST_IMM_OP(160,  slti,  0, 0x7fffffff, 0xfffff800 );
   TEST_IMM_OP(161,  slti,  0, 0x00000000, 0xffffffff );
   TEST_IMM_OP(162,  slti,  1, 0xffffffff, 0x00000001 );
   TEST_IMM_OP(163,  slti,  0, 0xffffffff, 0xffffffff );

   TEST_RR_OP (164,  sltu,  0, 0x00000000, 0x00000000 );
   TEST_RR_OP (165,  sltu,  0, 0x00000001, 0x00000001 );
   TEST_RR_OP (166,  sltu,  1, 0x00000003, 0x00000007 );
   TEST_RR_OP (167,  sltu,  0, 0x00000007, 0x00000003 );
   TEST_RR_OP (168,  sltu,  1, 0x00000000, 0xffff8000 );
   TEST_RR_OP (169,  sltu,  0, 0x80000000, 0x00000000 );
   TEST_RR_OP (170,  sltu,  1, 0x80000000, 0xffff8000 );
   TEST_RR_OP (171,  sltu,  1, 0x00000000, 0x00007fff );
   TEST_RR_OP (172,  sltu,  0, 0x7fffffff, 0x00000000 );
   TEST_RR_OP (173,  sltu,  0, 0x7fffffff, 0x00007fff );
   TEST_RR_OP (174,  sltu,  0, 0x80000000, 0x00007fff );
   TEST_RR_OP (175,  sltu,  1, 0x7fffffff, 0xffff8000 );
   TEST_RR_OP (176,  sltu,  1, 0x00000000, 0xffffffff );
   TEST_RR_OP (177,  sltu,  0, 0xffffffff, 0x00000001 );
   TEST_RR_OP (178,  sltu,  0, 0xffffffff, 0xffffffff );

   TEST_IMM_OP(179,  sltiu, 0, 0x00000000, 0x00000000 );
   TEST_IMM_OP(180,  sltiu, 0, 0x00000001, 0x00000001 );
   TEST_IMM_OP(181,  sltiu, 1, 0x00000003, 0x00000007 );
   TEST_IMM_OP(182,  sltiu, 0, 0x00000007, 0x00000003 );
   TEST_IMM_OP(183,  sltiu, 1, 0x00000000, 0xfffff800 );
   TEST_IMM_OP(184,  sltiu, 0, 0x80000000, 0x00000000 );
   TEST_IMM_OP(185,  sltiu, 1, 0x80000000, 0xfffff800 );
   TEST_IMM_OP(186,  sltiu, 1, 0x00000000, 0x000007ff );
   TEST_IMM_OP(187,  sltiu, 0, 0x7fffffff, 0x00000000 );
   TEST_IMM_OP(188,  sltiu, 0, 0x7fffffff, 0x000007ff );
   TEST_IMM_OP(189,  sltiu, 0, 0x80000000, 0x000007ff );
   TEST_IMM_OP(190,  sltiu, 1, 0x7fffffff, 0xfffff800 );
   TEST_IMM_OP(191,  sltiu, 1, 0x00000000, 0xffffffff );
   TEST_IMM_OP(192,  sltiu, 0, 0xffffffff, 0x00000001 );
   TEST_IMM_OP(193,  sltiu, 0, 0xffffffff, 0xffffffff );

   print_string("(ii) End of RISC-V test...\n");

   const int insn_v = insn();
   const int time_v = time();

   print_string("> time : "); print_dec( time_v ); print_string(" ("); print_hex( time_v ); print_string(")\n");
   print_string("> insn : "); print_dec( insn_v ); print_string(" ("); print_hex( insn_v ); print_string(")\n");

   return 0;
}

