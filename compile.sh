export PATH=$PATH:/usr/local/i386elfgcc/bin

nasm src/bootloader/boot.asm -f bin -o build/boot.bin

i386-elf-gcc -ffreestanding -m32 -g -c "src/kernal/kernal.c" -o "build/kernal.o"
nasm "src/kernal/kernal_entry.asm" -f elf -o "build/kernal_entry.o"
i386-elf-ld  -o "build/full_kernal.bin" -Ttext 0x1000  "build/kernal_entry.o" "build/kernal.o" --oformat binary --entry "main"
cat "build/boot.bin" "build/full_kernal.bin" >"build/OS.bin"
#objdump -b binary --adjust-vma=0xabcd1000 -D -m i386 full_kernal.bin for bin dump