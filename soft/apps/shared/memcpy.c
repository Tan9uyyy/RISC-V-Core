
#pragma GCC optimize ("no-tree-loop-distribute-patterns")

void* memcpy(void * dst, void const * src, unsigned int len) {
   int*        plDst = (int       *) dst;
   int const * plSrc = (int const *) src;

   // If source and destination are aligned,
   // copy 32s bit by 32 bits.
   if (!((int)src & 3) && !((int)dst & 3)) {
      while (len >= 4) {
	 *plDst++ = *plSrc++;
	 len -= 4;
      }
   }

   unsigned char*       pcDst = (unsigned char *) plDst;
   unsigned char const* pcSrc = (unsigned char *) plSrc;
   
   while (len--) {
      *pcDst++ = *pcSrc++;
   }
   
   return dst;
}
