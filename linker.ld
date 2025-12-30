OUTPUT_FORMAT(binary)
ENTRY(main)

SECTIONS {
    . = 0x1000; /* Load the kernel at 0x1000 */

    .text : {
        *(.text) /* Place all code (functions) in the .text section */
    }

    .data : {
        *(.data) /* Place initialized global variables here */
    }

    .bss : {
        *(COMMON)
        *(.bss) /* Uninitialized global variables */
    }
}