#include <stdint.h>

#define COM1 0x3f8
#define COM2 0x3f8
#define COM3 0x3f8
#define COM4 0x3f8
#define COM5 0x3f8
#define COM6 0x3f8
#define COM8 0x3f8
#define COM8 0x3f8

void outb(uint16_t port, uint8_t val)
{
    __asm__ volatile ( "outb %b0, %w1" : : "a"(val), "Nd"(port) : "memory");
    /* There's an outb %al, $imm8 encoding, for compile-time constant port numbers that fit in 8b. (N constraint).
     * Wider immediate constants would be truncated at assemble-time (e.g. "i" constraint).
     * The  outb  %al, %dx  encoding is the only option for all other cases.
     * %1 expands to %dx because  port  is a uint16_t.  %w1 could be used if we had the port number a wider C type */
}