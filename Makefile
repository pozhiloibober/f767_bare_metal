# ---- Инструменты ----
CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size

# ---- Флаги ----
CFLAGS  = -mcpu=cortex-m7 -mthumb -Wall -Wextra -O0 -g
LDFLAGS = -mcpu=cortex-m7 -mthumb -nostdlib -T linker.ld -Wl,-Map=blink.map

# ---- Файлы ----
SRCS   = startup.c main.c delay.c
OBJS   = $(SRCS:.c=.o)
TARGET = blink

.PHONY: all clean flash

# Цель по умолчанию: просто `make`
all: $(TARGET).bin

# .bin получается из .elf
$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

# .elf получается из всех .o и линкер-скрипта
$(TARGET).elf: $(OBJS) linker.ld
	$(CC) $(LDFLAGS) $(OBJS) -o $@
	$(SIZE) $@

# Любой .o получается из одноимённого .c
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Если изменится delay.h — пересобрать файлы, которые его подключают
main.o delay.o: delay.h

# Собрать и прошить
flash: $(TARGET).bin
	st-flash --reset write $< 0x08000000

# Удалить всё, что получилось при сборке
clean:
	rm -f $(OBJS) $(TARGET).elf $(TARGET).bin $(TARGET).map
