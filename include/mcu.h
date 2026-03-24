
//General pattern for accessing the content of register in address addr.
#define REG32(addr) (*(volatile unsigned int *)(addr))

//RCC is the Reset & Clock Control block.
#define RCC_BASE    0x58024400U
//RCC_AHB4ENR is the AHB4 (Advanced high-performance bus) clock register,
//where the clocks to the GPIO ports are enabled/disabled.
#define RCC_AHB4ENR REG32(RCC_BASE + 0x0E0U)

//GPIOCEN is the GPIO Port C clock enable/disable bit.
#define GPIOCEN_BIT 2U

//Base address for the GPIO C port register block.
#define GPIOC_BASE 0x58020800U

//MODER: port mode register
#define GPIOC_MODER REG32(GPIOC_BASE)
//MODER7 is bits 14-15
#define MODER7_START_BIT 14U 

//BSRR is the port bit set/reset register for atomic operations.
#define GPIOC_BSRR  REG32(GPIOC_BASE + 0x18U)
//BS7: set IO pin
#define BS7_BIT 7U
//BR7: reset IO pin
#define BR7_BIT 23U