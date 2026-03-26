/* Assembly mode/target */

.syntax unified /* Use the unified ARM/Thumb assembly syntax supported by GNU assembler.*/
.cpu cortex-m7
.thumb          /* Cortex-M executes Thumb instructions, not classic ARM mode. */

/*  Symbols we export and import.
    .global: This symbol is defined in this  file and should be visible to the linker.
    .extern: This symbol is defined somewhere else, but this file will use it.
*/

.global Reset_Handler
.global Default_Handler
.global g_pfnVectors
.extern main        /* defined in main.c */
.extern _estack     /* defined in linker.ld */
.extern _sidata
.extern _sdata
.extern _edata
.extern _sbss
.extern _ebss

/* Vector table */

/*  The vector table holds the initial SP value plus handler addresses the HW jumps to when it needs
    to handle exceptions. Here we specifiy the order of table entries, with each entry being a word (4 bytes.)
    So stack pointer is at 0x0000 0000, and Reset Handler at 0x0000 0004, etc.
    vector table is placed in the .isr_vector section, which the linker
    places at the begining of flash.
    "a", %progbits: this section is allocatable, meaning these are real bytes, not metadata or note.
                    It is not writeable/executable.
*/

.section .isr_vector, "a", %progbits
.type g_pfnVectors, %object       /* symbol g_pfnVectors is an object (data, not executable).*/
g_pfnVectors:
    .word _estack                 /* Initial stack pointer (SP) value */
    .word Reset_Handler           /* reset handler address */
    .word Default_Handler         /* NMI exception handled by the Default_Handler */
    .word Default_Handler         /* HardFault */
    .word Default_Handler         /* MemManage */
    .word Default_Handler         /* BusFault */
    .word Default_Handler         /* UsageFault */
    .word 0                       /* Reserved */
    .word 0                       /* Reserved */
    .word 0                       /* Reserved */
    .word 0                       /* Reserved */
    .word Default_Handler         /* SVCall */
    .word Default_Handler         /* Debug Monitor */
    .word 0                       /* Reserved */
    .word Default_Handler         /* PendSV */
    .word Default_Handler         /* SysTick */
    .word Default_Handler         /* WWDG1 */
    .word Default_Handler         /* PVD_PVM */
    .word Default_Handler         /* RTC_TAMP */
    .word Default_Handler         /* RTC_WKUP */
    .word Default_Handler         /* FLASH */
    .word Default_Handler         /* RCC */
    .word Default_Handler         /* EXTI0 */
    .word Default_Handler         /* EXTI1 */
    .word Default_Handler         /* EXTI2 */
    .word Default_Handler         /* EXTI3 */
    .word Default_Handler         /* EXTI4 */
    .word Default_Handler         /* DMA_STR0 */
    .word Default_Handler         /* DMA_STR1 */
    .word Default_Handler         /* DMA_STR2 */
    .word Default_Handler         /* DMA_STR3 */
    .word Default_Handler         /* DMA_STR4 */
    .word Default_Handler         /* DMA_STR5 */
    .word Default_Handler         /* DMA_STR6 */
    .word Default_Handler         /* ADC1_2 */
    .word Default_Handler         /* FDCAN1_IT0 */
    .word Default_Handler         /* FDCAN2_IT0 */
    .word Default_Handler         /* FDCAN1_IT1 */
    .word Default_Handler         /* FDCAN2_IT1 */
    .word Default_Handler         /* EXTI9_5 */
    .word Default_Handler         /* TIM1_BRK */
    .word Default_Handler         /* TIM1_UP */
    .word Default_Handler         /* TIM1_TRG_COM */
    .word Default_Handler         /* TIM1_CC */
    .word Default_Handler         /* TIM2 */
    .word Default_Handler         /* TIM3 */
    .word Default_Handler         /* TIM4 */
    .word Default_Handler         /* I2C1_EV */
    .word Default_Handler         /* I2C1_ER */
    .word Default_Handler         /* I2C2_EV */
    .word Default_Handler         /* I2C2_ER */
    .word Default_Handler         /* SPI1 */
    .word Default_Handler         /* SPI2 */
    .word Default_Handler         /* USART1 */
    .word Default_Handler         /* USART2 */
    .word Default_Handler         /* USART3 */
    .word Default_Handler         /* EXTI15_10 */
    .word Default_Handler         /* RTC_ALARM */
    .word 0                       /* Reserved */
    .word Default_Handler         /* TIM8_BRK_TIM12 */
    .word Default_Handler         /* TIM8_UP_TIM13 */
    .word Default_Handler         /* TIM8_TRG_COM_TIM14 */
    .word Default_Handler         /* TIM8_CC */
    .word Default_Handler         /* DMA1_STR7 */
    .word Default_Handler         /* FMC */
    .word Default_Handler         /* SDMMC1 */
    .word Default_Handler         /* TIM5 */
    .word Default_Handler         /* SPI3 */
    .word Default_Handler         /* UART4 */
    .word Default_Handler         /* UART5 */
    .word Default_Handler         /* TIM6_DAC */
    .word Default_Handler         /* TIM7 */
    .word Default_Handler         /* DMA2_STR0 */
    .word Default_Handler         /* DMA2_STR1 */
    .word Default_Handler         /* DMA2_STR2 */
    .word Default_Handler         /* DMA2_STR3 */
    .word Default_Handler         /* DMA2_STR4 */
    .word Default_Handler         /* ETH */
    .word Default_Handler         /* ETH_WKUP */
    .word Default_Handler         /* FDCAN_CAL */
    .word Default_Handler         /* - */
    .word 0                       /* Reserved */
    .word 0                       /* Reserved */
    .word 0                       /* Reserved */
    .word Default_Handler         /* DMA2_STR5 */
    .word Default_Handler         /* DMA2_STR6 */
    .word Default_Handler         /* DMA2_STR7 */
    .word Default_Handler         /* USART6 */
    .word Default_Handler         /* I2C3_EV */
    .word Default_Handler         /* I2C3_ER */
    .word Default_Handler         /* OTG_HS_EP1_OUT */
    .word Default_Handler         /* OTG_HS_EP1_IN */
    .word Default_Handler         /* OTG_HS_WKUP */
    .word Default_Handler         /* OTG_HS */
    .word Default_Handler         /* DCMI */
    .word Default_Handler         /* CRYP */
    .word Default_Handler         /* HASH_RNG */
    .word Default_Handler         /* FPU */
    .word Default_Handler         /* UART7 */
    .word Default_Handler         /* UART8 */
    .word Default_Handler         /* SPI4 */
    .word Default_Handler         /* SPI5 */
    .word Default_Handler         /* SPI6 */
    .word Default_Handler         /* SAI1 */
    .word Default_Handler         /* LDTC */
    .word Default_Handler         /* LDTC_ER */
    .word Default_Handler         /* DMA2D */
    .word Default_Handler         /* SAI2 */
    .word Default_Handler         /* QUADSPI */
    .word Default_Handler         /* LPTIM1 */
    .word Default_Handler         /* CEC */
    .word Default_Handler         /* I2C4_EV */
    .word Default_Handler         /* I2C4_ER */
    .word Default_Handler         /* SPDIF */
    .word Default_Handler         /* OTG_FS_EP1_OUT */
    .word Default_Handler         /* OTG_FS_EP1_IN */
    .word Default_Handler         /* OTG_FS_WKUP */
    .word Default_Handler         /* OTG_FS */
    .word Default_Handler         /* DMAMUX1_OV */
    .word Default_Handler         /* HRTIM1_MST */
    .word Default_Handler         /* HRTIM1_TIMA */
    .word Default_Handler         /* HRTIM1_TIMB */
    .word Default_Handler         /* HRTIM1_TIMC */
    .word Default_Handler         /* HRTIM1_TIMD */
    .word Default_Handler         /* HRTIM1_TIME */
    .word Default_Handler         /* HRTIM1_FLT */
    .word Default_Handler         /* DFSDM1_FLT0 */
    .word Default_Handler         /* DFSDM1_FLT1 */
    .word Default_Handler         /* DFSDM1_FLT2 */
    .word Default_Handler         /* DFSDM1_FLT3 */
    .word Default_Handler         /* SAI3 */
    .word Default_Handler         /* SWPMI1 */
    .word Default_Handler         /* TIM15 */
    .word Default_Handler         /* TIM16 */
    .word Default_Handler         /* TIM17 */
    .word Default_Handler         /* MDIOS_WKUP */
    .word Default_Handler         /* MDIOS */
    .word Default_Handler         /* JPEG */
    .word Default_Handler         /* MDMA */
    .word 0                       /* Reserved */
    .word Default_Handler         /* SDMMC2 */
    .word Default_Handler         /* HSEM0 */
    .word 0                       /* Reserved */
    .word Default_Handler         /* ADC3 */
    .word Default_Handler         /* DMAMUX2_OVR */
    .word Default_Handler         /* BDMA_CH0 */
    .word Default_Handler         /* BDMA_CH1 */
    .word Default_Handler         /* BDMA_CH2 */
    .word Default_Handler         /* BDMA_CH3 */
    .word Default_Handler         /* BDMA_CH4 */
    .word Default_Handler         /* BDMA_CH5 */
    .word Default_Handler         /* BDMA_CH6 */
    .word Default_Handler         /* BDMA_CH7 */
    .word Default_Handler         /* COMP */
    .word Default_Handler         /* LPTIM2 */
    .word Default_Handler         /* LPTIM3 */
    .word Default_Handler         /* LPTIM4 */
    .word Default_Handler         /* LPTIM5 */
    .word Default_Handler         /* LPUART */
    .word Default_Handler         /* WWDG1_RST */
    .word Default_Handler         /* CRS */
    .word Default_Handler         /* RAMECC */
    .word Default_Handler         /* SAI4 */
    .word 0                       /* Reserved */
    .word 0                       /* Reserved */    
    .word Default_Handler         /* WKUP */
  

/*  Reset handler
    This section lives in the code memory.
    "ax",  %progbits: actual bytes, executable.
*/
  
.section .text.Reset_Handler, "ax", %progbits   /* place the reset handler in an executable code section */
.type Reset_Handler, %function                  /* Mark it as a function symbol: executable code. */

  /* What is does:
        1. Copy .data from flash to RAM.
        2. Zero .bss
        3. Call main
        4. If main returns, trap forever.
    
        Use the following general purpose registers:
        - r0: source pointer
        - r1: destination pointer
        - r2: end pointer
        - r3: temp loaded word

        General pattern: instruction destination, source
  
    1. copy .data from flash to RAM.
       _sidata is in flash
       _sdata ... _edata is the RAM destination range 
        Pseudocode:
            src = &_sidata        (load address into register)
            dst = &_sdata
            while (dst < &_edata)
                *dst++ = *src++
  */

    Reset_Handler:
        ldr r0, =_sidata
        ldr r1, =_sdata
        ldr r2, =_edata

    CopyData:
        cmp r1, r2          /* Compare destination pointer with end pointer */
        bcs ZeroBss         /* if r1 >= r2, copying is done, go to .bss init */
        ldr r3, [r0], #4    /* load word from address in r0, then increment r0 by 4 */
        str r3, [r1], #4    /* store that word in address in r1, then increment by 4 */
        b CopyData          /* repeat. */

  /* 
    2.  Zero .bss:
            dst = &_sbss
            while (dst < &_ebss)
                *dst++ = 0
  */
    ZeroBss:
        ldr r1, =_sbss
        ldr r2, =_ebss
        movs r0, #0         /* r0 holds zero to store repeatedly */

    ZeroBssLoop:
        cmp r1, r2
        bcs CallMain
        str r0, [r1], #4
        b ZeroBssLoop

  /* Call main: */
    CallMain:
        bl main  /*bl = branch with link, used for calling a function */
    
  /* LoopForever:
        what happens if main returns (never happens in embedded systems, but we must handle it).
  */
  
    LoopForever:
        b LoopForever
   
/*  Default Handler
    The fallback for any unexpected exception/interrupt
*/
.section .text.Default_Handler, "ax", %progbits
.type Default_Handler, %function

    Default_Handler:
    Infinite_Loop:
        b Infinite_Loop
