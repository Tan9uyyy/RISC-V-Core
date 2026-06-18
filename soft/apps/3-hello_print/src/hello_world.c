/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/

extern void print_string(const char* s);

int main() // A REAL test, with main function and the boot sequence execution
{
   print_string("(ii)\n");
   print_string("(ii) HELLO world !\n");
   print_string("(ii) Let me introduce myself, I am the BreiZH RISC-V.\n");
   print_string("(ii) release :\n");
   print_string("(ii) ");
   print_string(__DATE__);
   print_string(" ");
   print_string(__TIME__);
   print_string( "\n");
   print_string("(ii)\n");
   //return 0;
   asm volatile("ebreak");
   //while( 1 );
   return 0;
}

