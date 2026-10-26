# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 1 3 4
# 34 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 3 4

# 34 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 3 4
typedef signed char int8_t;


typedef short int int16_t;


typedef long int int32_t;


typedef long long int int64_t;


typedef unsigned char uint8_t;


typedef short unsigned int uint16_t;


typedef long unsigned int uint32_t;


typedef long long unsigned int uint64_t;




typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef long int int_least32_t;
typedef long long int int_least64_t;
typedef unsigned char uint_least8_t;
typedef short unsigned int uint_least16_t;
typedef long unsigned int uint_least32_t;
typedef long long unsigned int uint_least64_t;



typedef int int_fast8_t;
typedef int int_fast16_t;
typedef int int_fast32_t;
typedef long long int int_fast64_t;
typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef long long unsigned int uint_fast64_t;




typedef int intptr_t;


typedef unsigned int uintptr_t;




typedef long long int intmax_t;
typedef long long unsigned int uintmax_t;
# 2 "main.c" 2
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdbool.h" 1 3 4
# 3 "main.c" 2
# 1 "delay.h" 1




# 4 "delay.h"
void delay();
# 4 "main.c" 2







int main(void)
{
 *((volatile uint32_t*)(0x40023800 + 0x30)) |= (1U << 1);
 *((volatile uint32_t*)(0x40020400 + 0x00)) |= (1U << 7*2);

 while(1)
 {
      delay();
      *((volatile uint32_t*)(0x40020400 + 0x14)) ^= (1U << 7);
      delay();
 }

 return 0;
}
# 0 "delay.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "delay.c"
# 1 "delay.h" 1



void delay();
# 2 "delay.c" 2
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 1 3 4
# 34 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 3 4

# 34 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 3 4
typedef signed char int8_t;


typedef short int int16_t;


typedef long int int32_t;


typedef long long int int64_t;


typedef unsigned char uint8_t;


typedef short unsigned int uint16_t;


typedef long unsigned int uint32_t;


typedef long long unsigned int uint64_t;




typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef long int int_least32_t;
typedef long long int int_least64_t;
typedef unsigned char uint_least8_t;
typedef short unsigned int uint_least16_t;
typedef long unsigned int uint_least32_t;
typedef long long unsigned int uint_least64_t;



typedef int int_fast8_t;
typedef int int_fast16_t;
typedef int int_fast32_t;
typedef long long int int_fast64_t;
typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef long long unsigned int uint_fast64_t;




typedef int intptr_t;


typedef unsigned int uintptr_t;




typedef long long int intmax_t;
typedef long long unsigned int uintmax_t;
# 3 "delay.c" 2

# 3 "delay.c"
void delay()
{
  for(volatile int i = 0; i<10000; i++);
}
