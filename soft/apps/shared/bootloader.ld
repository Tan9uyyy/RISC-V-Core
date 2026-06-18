  MEMORY {
      ROM   (rwx) : ORIGIN = 0x00000000, LENGTH = 0x0200  
  }
  SECTIONS {
  
    .text : {
      boot.o(.text) 
      *(.text*) 
      *(.rodata*) 
      *(.srodata*)
    } > ROM

    .data : {
      *(.data*)          
      *(.sdata*)
    } > ROM

    .bss : {
      *(.bss*)
      *(.sbss*)
    } > ROM
  }
