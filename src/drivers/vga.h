#include <stdint.h>
// #include <kernal/memory/mem.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_BUFFER 0xb8000
#define VGA_DEFAULT_COLOR = 0x07

extern uint32_t cursor = VGA_BUFFER;  



void putchr(char c) {
    *(char*)cursor = c;
    *(char*)(cursor + 1) = 0x07;
    cursor += 2;
}
void puts(char* str) {

    while(*str) {
        if(*str == 10) { // compiler uses LF as newline
            cursor = cursor - ((cursor - VGA_BUFFER) % (VGA_WIDTH * 2));
            cursor = cursor + VGA_WIDTH * 2;
            
        }
        // if(*str == 13) { //carriage return
        //     cursor = cursor - (cursor % (VGA_WIDTH * 2));
        //     // cursor = VGA_BUFFER +  50;
        // }
        else {
            putchr(*str);
        }
        
        str++;
    }
}
void putint(uint32_t num) {

    int counter = 0;
    int arr[20];

    while (num > 0) {
        arr[counter++] = num % 10  + '0';
        num /= 10;
    } 
    counter--;
    while (counter >=0)
    {
        putchr(arr[counter]);
        counter--;
    }
    

}
void put_hex(uint32_t num) {

}
void put_hexdump(char *str) {

}
void clear_screen() {
    // physical_memory_set((void*)VGA_BUFFER, 0, VGA_WIDTH * VGA_HEIGHT * 2);
}