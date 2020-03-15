TARGET=breathalyzer

CC=avr-gcc
OBJCOPY=avr-objcopy
UPLOADER=avrdude
PROGRAMMER=usbasp

SRC=main.c output.c
OBJS=$(SRC:.c=.o)

MCU=attiny2313
CFLAGS=-mmcu=$(MCU) -Wall -g -Os -Werror
OPERATION=flash:w:$(TARGET).hex:i
PORT=usb

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)
	$(OBJCOPY) -j .text -j .data -O ihex $(TARGET) $(TARGET).hex

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

upload:
	$(UPLOADER) -p $(MCU) -c $(PROGRAMMER) -U $(OPERATION) -P $(PORT)

clean:
	rm -f *.o $(TARGET)*
