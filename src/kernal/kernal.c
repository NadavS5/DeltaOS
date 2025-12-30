#include <stdint.h>
#include <drivers/vga.h>
#include <drivers/uart.h>


extern void main () {
    puts("Hello, World from Kernal!\n");
    
    outb(COM1, 0x41);
    outb(COM1, 0x42);
    outb(COM1, 0x43);


    return;
}

