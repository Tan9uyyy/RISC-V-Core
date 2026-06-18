#include "../libuc.h"

/* 
 * Needed to prevent the compiler from recognizing memcpy in the
 * body of memcpy and replacing it with a call to memcpy
 * (infinite recursion) 
 */ 
#pragma GCC optimize ("no-tree-loop-distribute-patterns")

void* memcpy(void * dst, void const * src, size_t len) {
   unsigned int * plDst = (unsigned int *) dst;
   unsigned int const * plSrc = (unsigned int const *) src;

   // If source and destination are aligned,
   // copy 32s bit by 32 bits.
   if (!((unsigned int)src & 3) && !((unsigned int)dst & 3)) {
      while (len >= 4) {
	 *plDst++ = *plSrc++;
	 len -= 4;
      }
   }

   unsigned char* pcDst = (unsigned char *) plDst;
   unsigned char const* pcSrc = (unsigned char const *) plSrc;
   
   while (len--) {
      *pcDst++ = *pcSrc++;
   }
   
   return dst;
}


/*
 * Equivalent (slower) version
void* memcpy(void* dest, const void* src, size_t n) {
   char *csrc  = (char *)src; 
   char *cdest = (char *)dest; 
   for (size_t i=0; i<n; i++) {
      cdest[i] = csrc[i];
   }
}
 */

