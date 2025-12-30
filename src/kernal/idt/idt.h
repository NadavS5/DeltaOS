#include <stdint.h>

typedef struct {
    uint16_t BaseLow;
    uint16_t SegmentSelector;
    uint8_t Reserved;
    uint8_t Flags;
    uint16_t BaseHigh;
} __attribute__((packed)) IDTEntry;

typedef struct {
    uint16_t Limit;
    IDTEntry *Ptr;

} __attribute__((packed))IDTDescriptor;

typedef enum {
    IDT_FLAG_GATE_TASK = 0x05,
    IDT_FLAG_16BIT_INT = 0x06,
    IDT_FLAG_16BIT_TRAP = 0x0E,
    IDT_FLAG_32BIT_INT = 0x0F,
    IDT_FLAG_32BIT_TRAP = 0x09,


    IDT_FLAG_RING0 = (0 <<5),
    IDT_FLAG_RING1 = (1 <<5),
    IDT_FLAG_RING2 = (2 <<5),
    IDT_FLAG_RING3 = (3 <<5),

    IDT_FLAG_PRESENT = 0x80,

} IDTFlags;

void __attribute__((cdcel)) i686_IDT_Load(IDTDescriptor *idt);

IDTEntry g_IDT[256];
