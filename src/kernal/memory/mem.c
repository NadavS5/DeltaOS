#include "mem.h"


MemoryRegionType buffer;

__attribute__((naked)) get_mem_map() {
    __asm__ (
        ".intel_syntax noprefix\n"
        "mov eax, 0xE820"
        "int 0x15"
        "mov ebx, 0"
        "mov ecx ,sizeof(buffer)"
        "mov edx, 0x534D4150"
        ""
    );
}


MemmoryEntry* get_memmory_maps() {
    //extern MemmoryEntry memmory_map;    

    //return &memmory_map;
}
void physical_memory_set(void* buffer,int c, int size) {
    for(int i = 0; i < size; i++) {
        ((char*)buffer)[i] = c;
    }

}