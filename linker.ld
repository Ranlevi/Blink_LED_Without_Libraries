/*  Declare Reset_Handler as the starting point
    of the firmware. This declaration is not meant
    for the CPU, which alwyas starts from the vector table
    in memory anyway - it is a (madatory) toolchain 
    metadata that helps with proper linking.
    Reset_Handler itself is defined in startup.s
*/
ENTRY(Reset_Handler)

MEMORY
{
  /*rx: readable, executable, but not writeable
    This is where .text lives.
    according to docs, with Boot Mode set to 0 by boot pins
    (for the Daisy Seed board), we should be using Flash Bank 1,
    whose address range is: 0x08000000-0x0801FFFF.
    This means size is 128Kbytes = 0x20000.
  */
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 0x20000

  /*xrw: readable, executable and writeable
    This is where .data, .bss and the stack live.
    Should be placed in DTCM, which (according to docs) has
    128Kbytes. So length is 128*1024 = 131072 = 0x20000.
    Note: in our current project, execution will be only from the
    Flash.
  */
  RAM   (xrw) : ORIGIN = 0x20000000, LENGTH = 0x20000
}

/*  Stack Pointer (SP) points to the top of the RAM area (the first address
    past the RAM region). That's becuase the stack grows downwards in memory.
*/
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
  .isr_vector :
  {
    /* Tells linker to round the current location to the next multiple of 4.
       This is because STM32 is 32-bits core (4 bytes), and access is more
       natural on word baundaries.
    */
    . = ALIGN(4);

    /* KEEP tells the linker not to remove the vector table as unused.
       It seems unused because nothing in the C code calls it - but CPU
       uses it implicitly at boot.
    */    
    KEEP(*(.isr_vector))

    /* End address of this region aligned to 4-byte boundary */
    . = ALIGN(4);

    /* tells linker: place this output section in the Flash memory region */
  } > FLASH

  .text : /* defines an output section named .text and puts it in flash. */
  {
    . = ALIGN(4);
    *(.text)    /*All input sections named EXACTLY .text from all object files */
    *(.text*)   /*All input sections whose names start with .text (e.g. .text.main) */
    *(.rodata)  /* read-only constant data, like string literals or const data */
    *(.rodata*) /* Same idea, but catches variant names like .rodata.str1.4 */
    . = ALIGN(4);    
  } > FLASH

  .data :
  {
    . = ALIGN(4);
    _sdata = .; /* symbol for start of .data in RAM */
    *(.data)
    *(.data*)
    . = ALIGN(4);

    _edata = .; /* symbol for end of .data in RAM */

    /* .data section will live in RAM at runtime, but init values are stored
        in flash in the firmware image
    */
  } > RAM AT > FLASH 

  /*  symbol for the flash address where the initial .data contents are stored.
      note: .data holds the execution address in RAM. _sidata has load address in flash.
      The reset handler will use those symbols to copy the .data from Flash (starting at _sidata) 
      into RAM starting from _sdata, and keep copying until it reaches _edata.
  */
  _sidata = LOADADDR(.data);

    /*  RAM region for common symbols, zero-initialized or uninitialized globals.
        The reset handler must explicitly zero that region.
    */
  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);

    _ebss = .;
  } > RAM
}
