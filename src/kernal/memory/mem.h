#include <stdint.h>

typedef struct {
    uint64_t base_address;
    uint64_t length;
    uint32_t type;
    uint32_t ascpi_3_0_extended;

} MemmoryEntry __attribute__((packed));
typedef enum {
    usable = 1,
    reserved = 2,
    ACPI_reclaimable_memory = 3,
    ACPI_NVS_memory = 4,
    bad_memory = 5,

} MemoryRegionType;

MemmoryEntry* get_memmory_maps();


void physical_memory_set(void* buffer,int c, int size);