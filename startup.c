#include <stdint.h>

#define SRAM_START (0x20000000U)   // Адрес начала SRAM
#define SRAM_SIZE (512U * 1024U)   // Размер SRAM
#define SRAM_END (SRAM_START + SRAM_SIZE) // Конец SRAM
#define STACK_POINTER_INIT_ADDRESS (SRAM_END) // Указатель стека

#define ISR_VECTOR_SIZE_WORDS 126   // Количество векторов прерываний

extern uint32_t _estack;
extern uint32_t _sidata;
extern uint32_t _sdata;
extern uint32_t _edata;
extern uint32_t _sbss;
extern uint32_t _ebss;


// Объявление векторов прерывания
void default_handler(void);
void Reset_Handler(void);
void nmi_handler(void) __attribute__((weak, alias("default_handler")));
void hard_fault_handler(void) __attribute__((weak, alias("default_handler")));
void memmanage_handler(void) __attribute__((weak, alias("default_handler")));
void busfault_handler(void) __attribute__((weak, alias("default_handler")));
void usagefault(void) __attribute__((weak, alias("default_handler")));
void svcall_handler(void) __attribute__((weak, alias("default_handler")));
void debug_monitor(void) __attribute__((weak, alias("default_handler")));
void pendsv_handler(void) __attribute__((weak, alias("default_handler")));
void systick_handler(void) __attribute__((weak, alias("default_handler")));

// Объявим функцию которая будет расположена в секции .isr_vector
uint32_t isr_vector[ISR_VECTOR_SIZE_WORDS] __attribute__((section(".isr_vector"))) = 
{
  (uint32_t)&_estack,
  (uint32_t)&Reset_Handler,
  (uint32_t)&nmi_handler,
  (uint32_t)&hard_fault_handler,
  (uint32_t)&memmanage_handler,
  (uint32_t)&busfault_handler,
  (uint32_t)&usagefault,
  0,
  0,
  0,
  0,
  (uint32_t)&svcall_handler,
  (uint32_t)&debug_monitor,
  0,
  (uint32_t)&pendsv_handler,
  (uint32_t)&systick_handler,
  // Можно продолжить описание остальных периферийных векторов...
};

// Объявим обработчик прерываний по умолчанию
void default_handler(void)
{
   while(1);
}




// Подключаем функцию main
extern int main(void);

// Объявим функцию которая будет выполнена после сброса и передаст управление в main
void Reset_Handler(void)
{
  // Копируем .data из FLASH в SRAM
  uint32_t data_size = (uint32_t)&_edata - (uint32_t)&_sdata;

  uint8_t* flash_data = (uint8_t*) &_sidata;
  uint8_t* sram_data = (uint8_t*) &_sdata;
  
  for (uint32_t i = 0; i < data_size; i++)
  {
     sram_data[i] = flash_data[i];
  }

  // Заполняем нулями .bss секцию в SRAM
  uint32_t bss_size = (uint32_t)&_ebss - (uint32_t)&_sbss;

  uint32_t* bss = (uint32_t*) &_sbss;

  for (uint32_t i = 0; i < bss_size/4; i++)
  {
     bss[i] = 0;
  }
  
  // Переходим в main-функцию
  main();
  while (1);
}
