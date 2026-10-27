#include <stdint.h>
#include <stdbool.h>
#include "delay.h"
#include "stm32f767xx.h"

#define RCC_AHB1ENR *((volatile uint32_t*)(0x40023800 + 0x30))
#define GPIOB_MODER *((volatile uint32_t*)(0x40020400 + 0x00))
#define GPIOB_ODR *((volatile uint32_t*)(0x40020400 + 0x14))


int main(void)
{
	//RCC_AHB1ENR |= (1U << 1);  // GPIOB
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;
	GPIOB_MODER |= (1U << 7*2); // output mode
	
	while(1)
	{
	     delay();
	     GPIOB_ODR ^= (1U << 7);
	     delay();
	}

	return 0;
}


