/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <libuc.h>

#define VECTOR_SIZE   1000
#define RESULT      489500

const int SCALAR = 10;

int vect[VECTOR_SIZE];

int main(void)
{
    
   // Initialize the vector
   init: for (int i = 0; i < VECTOR_SIZE; i++) {
      vect[i] = i;
   }
    
   // Perform the vector addition (vect[i] = vect[i] + SCALAR)
   int sum =0;
   compute: for (int i = 0; i < VECTOR_SIZE; i++)
   {
      sum += (vect[i] - SCALAR);
   }
   
   if( sum == RESULT )
    printf("(II) Result is OK\n");
   else
    printf("(II) Result is NOK\n");

   return sum;
}
