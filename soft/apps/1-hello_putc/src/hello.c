/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
inline int put_c(int c)
{
   volatile unsigned int* uart_ou = (unsigned int*)0x06000000;
   ( *uart_ou ) = c;                            // on envoie le char
}
//
//
//
//
//
void start() // no main => start is called BEFORE main. It avoid boot sequence !
{
   put_c('H');
   put_c('e');
   put_c('l');
   put_c('l');
   put_c('o');
   put_c(' ');
   put_c('!');
   put_c('\n');
   asm volatile("ebreak");
}
//
//
//
//
//
