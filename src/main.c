#include "mcu.h"

//Delay loop
static void delay (volatile unsigned int count){
    while (count--){
        __asm__("nop");
    }
}

int main(void)
{
    //Enable the clock to the GPIOC port.
    RCC_AHB4ENR |= (1U << GPIOCEN_BIT);

    //Reset the GPIOC_MODER bits to 00, then set to 01.
    GPIOC_MODER &= ~(3U << MODER7_START_BIT);
    GPIOC_MODER |= (1U << MODER7_START_BIT);    

    while (1)
    {
        GPIOC_BSRR = (1U << BS7_BIT);
        delay(6400000); //roughly 1 sec at 64MHz CPU.

        GPIOC_BSRR = (1U << BR7_BIT);
        delay(6400000);
    }
}
