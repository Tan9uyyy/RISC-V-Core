#ifndef H__FEMTOSTDLIB__H
#define H__FEMTOSTDLIB__H

//#include <femtorv32.h>
//#include <stdint.h>
#include <stddef.h>

/* My light weight replacement function for printf() */
extern int printf(const char *fmt,...); /* supports %s, %d, %x */

extern void*      memset (void *s, int c, size_t n);
extern void*      memcpy (void *dest, const void *src, size_t n);
extern char*      strcpy (char *dest, const char *src);
extern char*      strncpy(char *dest, const char *src, size_t n);
extern int        strcmp (const char *p1, const char *p2);
extern size_t     strlen (const char* p);
extern long       random();


/* Specialized print functions (but one can use printf() instead) */
extern int  putchar(const int c);
extern void print_string(const char* s);
extern void print_dec(int val);
extern void print_hex_digits(unsigned int val, int digits);
extern void print_hex(unsigned int val);


/*                       */
/*                       */
/* OLED screen control   */
/*                       */
/*                       */

int  pixel           (const int r, const int g, const int b);
int  set_12b_from_16b(const int color);
void set_pixel       (const int offset, const int color);
void clear_screen    ();


/*                       */
/*                       */
/* RGB led color control */
/*                       */
/*                       */

extern void led_rgb_set_red  ();
extern void led_rgb_set_green();
extern void led_rgb_set_blue ();
extern void led_rgb_set_color(const int color);
extern int  led_rgb_get_color();


/*                        */
/*                        */
/* External timer control */
/*                        */
/*                        */

extern int  get_cycles       ();
extern int  time             ();
extern void sleep_cycles     (const int cycles);
extern void sleep_us         (const int cycles);
extern void sleep_ms         (const int cycles);
extern void sleep            (const int cycles);
extern void start_timer      (const int cycles);
extern void is_timer_finished();

/*                           */
/*                           */
/* External UART read access */
/*                           */
/*                           */




#endif
