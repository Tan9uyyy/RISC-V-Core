/**
 * 
 * Bertrand LE GAL (bertrand.le-gal@irisa.fr)
 * 
*/
#include <libuc.h>
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
#define LENGTH  (64+2) // simulation
//#define LENGTH  (1024+2) // FPGA
#define  int32_t          int
#define uint32_t unsigned int
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//



uint32_t* multiply_array(uint32_t array [], uint32_t array_size, uint32_t coeff)
{
    for(int i = 0; i < array_size; i++)
    {
        array[i] = array[i] * coeff;
    }
    return array;
}

void propagate(int32_t pidecimals[], const int32_t number_of_digits)
{
    for(uint32_t j = 0; j < number_of_digits; j += 1)
    {
        if( pidecimals[j] == 10 )
        {
            pidecimals[j] = 0;
            for(uint32_t k = j - 1; k >= 0; k -= 1)
            {
                if( pidecimals[k] != 9 )
                {
                    pidecimals[k] += 1;
                    break;
                }
                else
                {
                    pidecimals[k] = 0;
                }
            }
        }
    }
}

inline uint32_t maxfx(const uint32_t a, const uint32_t b)
{
    return (a >= b) ? a : b;
}

uint32_t kernel_interne(uint32_t* ptr, const int32_t carry_in, const int32_t array_size)
{
        uint32_t carry      =     carry_in;
        uint32_t coeff_up   =     array_size - 1;
        uint32_t coeff_down = 2 * array_size - 1;

        for(int i = 0; i < (array_size - 1); i += 1)
        {
            const uint32_t data     = 10 * ptr[i];
            const uint32_t value    = data + carry;
            const uint32_t quotient = value / coeff_down;
            ptr[i]                  = value % coeff_down;
            carry                   = quotient * coeff_up;
            coeff_up               -= 1;
            coeff_down             -= 2;
        }
        
        uint32_t quotient  = ((10 * ptr[array_size-1]) + carry) / 10;
        uint32_t remainder = ((10 * ptr[array_size-1]) + carry) % 10;
        ptr[array_size-1]  = remainder;
        return quotient;
}
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
void kernel(int32_t pidecimals[])
{
    const int32_t number_of_digits = LENGTH;
    const uint32_t array_size      = (10 * number_of_digits) /  3;

    uint32_t A[array_size];

    for (uint32_t i = 0; i < array_size; i += 1)
    {
        A[i] = 2;
    }
    
    for(uint32_t j = 0; j < number_of_digits; j += 1)
    {
        pidecimals[j] = kernel_interne(A, 0, array_size);
    }

    propagate(pidecimals, number_of_digits);
}


void to_ascii(int calculated_pi[])
{
    int32_t temp_values[LENGTH];
    
    for(int32_t i = 0; i < LENGTH - 1; i += 1 )
    {
        temp_values[i] = calculated_pi[i];
    }
    
    for(int32_t i = 0; i < LENGTH; i += 1)
    {
        if(i == 0)
        {
            calculated_pi[0] = calculated_pi[0] + '0';
        }
        else if(i == 1)
        {
            calculated_pi[1] = '.';
        }
        else if( i>= 2)
        {
            calculated_pi[i] = temp_values[i-1] + '0';
        }
    }
}
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
void green()
{
    printf("\033[0;32m");
}

void red()
{
    printf("\033[0;31m");
}

void white()
{
    printf("\033[0;37m");
}

int main()
{
    int32_t verbose = 0;
    int32_t method  = 1;
    int32_t threads = 1;

    printf("(II) Computation of PI apprixation\n");
    printf("(II) Compilation date : %s\n", __DATE__);
    printf("(II) Compilation time : %s\n", __TIME__);
    printf("(II)\n");
    printf("(II) Number of digits : %d\n",   LENGTH-2); // -2 à cause du "3."
    printf("(II)\n");
    printf("(II) Memory footprint\n");
    printf("(II) - PI digits       : %d kB\n",   (     LENGTH * sizeof(int) / 1024    ) );
    printf("(II) - Internal values : %d kB\n",   (10 * LENGTH * sizeof(int) / 1024 / 3) );
    printf("(II)\n");

    int32_t calculated_pi[LENGTH];

    for (int32_t i = 0; i < LENGTH; i++)
    {
        calculated_pi[i] = 0;
    }
    
    kernel(calculated_pi);

    to_ascii(calculated_pi);

    green();
    printf("      3.");
    for(int i = 0; i < LENGTH-2; i+=1)
    {
        if( (i%64 == 0) && (i != 0) ){
            white();
            printf("\n%5d | ", i);
            green();
        }
        printf("%c", calculated_pi[i+2]);
    }
    white();
    printf("\n  ");

    return 0;
}
