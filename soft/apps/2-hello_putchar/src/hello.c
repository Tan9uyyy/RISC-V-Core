/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
//#include <stdio.h> //désactiver car sinon cela ne compile pas (cette bibliothèque n'existe pas dans le processeur))

 static inline int putchar(const int c)
{
   volatile unsigned int* uart_ou = (unsigned int*)0x06000000;
   ( *uart_ou ) = c;                            // on envoie le char
   return c;
}

static inline void led_rgb_set_red()
{
   volatile unsigned int* ptr_rgb = (unsigned int*)0x0D000000;
   ( *ptr_rgb ) = 0x00000044;
}

static inline void led_rgb_set_green()
{
   volatile unsigned int* ptr_rgb = (unsigned int*)0x0D000000;
   ( *ptr_rgb  ) = 0x00004400;
}

void /*__attribute__((section(".text.init")))*/ start() // no main => start is called BEFORE main. It avoid boot sequence !
{
   led_rgb_set_green();
   putchar('H');
   putchar('e');
   putchar('l');
   putchar('l');
   putchar('o');
   putchar('\n');
   led_rgb_set_red();
   asm volatile("ebreak");
   while( 1 );
}

