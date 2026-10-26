#include "delay.h"
#include <stdint.h>
uint32_t delay_counter;
const uint32_t DELAY_MAX =0x7A120;
void delay()
{
  for(delay_counter = 0; delay_counter<DELAY_MAX; delay_counter++);
}
