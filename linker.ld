/* Точка входа: с какой функции начинается программа. */
ENTRY(Reset_Handler)

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 2048K
  RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 512K
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
  /* Таблица векторов — первой, в самое начало флеша */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))      /* KEEP: не выкидывать, хоть на неё никто и не ссылается */
    . = ALIGN(4);
  } > FLASH

  .text :
  {
    . = ALIGN(4);
    *(.text*)                
    . = ALIGN(4);
  } > FLASH


  .rodata :
  {
    . = ALIGN(4);
    *(.rodata*)
    . = ALIGN(4);
  } > FLASH

  /* Адрес, по которому во флеше лежит копия начальных значений .data.
     Отсюда startup будет копировать. */
  _sidata = LOADADDR(.data);

  .data :
  {
    . = ALIGN(4);
    _sdata = .;              
    *(.data*)
    . = ALIGN(4);
    _edata = .;               
  } > RAM AT > FLASH


  .bss :
  {
    . = ALIGN(4);
    _sbss = .;                
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;                
  } > RAM
}
