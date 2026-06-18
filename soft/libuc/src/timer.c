#include "../libuc.h"

/*                        */
/*                        */
/* External timer control */
/*                        */
/*                        */

extern int get_cycles()
{
   volatile unsigned int* ptr_timer = 0x0C000000;
   return (*ptr_timer);
}

int time()
{
   return get_cycles();
}

void sleep_cycles(const int cycles)
{
   volatile unsigned int* ptr_timer = 0x0C000000;
   ptr_timer[1] = cycles;
   while( ptr_timer[1] != 0 );
}

void sleep_us(const int cycles)
{
    sleep_cycles( 100 *  cycles);
}

void sleep_ms(const int cycles)
{
    sleep_cycles( 100000 *  cycles);
}

void sleep(const int cycles)
{
    sleep_cycles( 100000000 *  cycles);
}

void start_timer(const int cycles)
{
   volatile unsigned int* ptr_timer = 0x0C000000;
   ptr_timer[1] = cycles;
}

void is_timer_finished()
{
   volatile unsigned int* ptr_timer = 0x0C000000;
   return (ptr_timer[1] == 0);
}
