#define F_CPU   (1000000UL)

#include <avr/io.h>
#include <util/delay.h>

#include "const.h"


int get_integer(double number)
{
    return number;
}

int get_fraction(double number)
{
    return (int)(number * 10) % 10;
}

void init()
{
    // Set pins to output mode
    DDRD = 0x7f;
    DDRB = 0x07;
}

void clear_PORTD()
{
    PORTD = 0x00;
}

void print(double number)
{
    init();
    int integer = get_integer(number),
        fraction = get_fraction(number);

    while (1)
    {
        // Set low level on second indicator and dot
        PORTB = 0x06;
        PORTD = NUM_REP[integer];
        _delay_ms(DELAY);
        clear_PORTD();

        // Set low level on first indicator
        PORTB = 0x01;
        PORTD = NUM_REP[fraction];
        _delay_ms(DELAY);
        clear_PORTD();
    }
}
