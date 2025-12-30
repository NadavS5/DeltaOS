[bits 32]


; void __attribute__((cdcel)) i686_IDT_Load(IDTDescriptor *idt);
global i686_IDT_Load

i686_IDT_Load:
    ; make a new call frame
    push ebp
    mov ebp, esp

    ;load idt
    mov eax, [ebp + 8]
    lidt [eax]
    
    ; restore old call frame
    mov esp, ebp
    pop ebp
    ret