ASM=nasm

SRC_DIR=src
BUILD_DIR=build
LD = i386-elf-ld

all:$(BUILD_DIR)/OS.bin


$(BUILD_DIR)/boot.bin: $(SRC_DIR)/bootloader/boot.asm
	mkdir -p $(BUILD_DIR)
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/boot.bin

$(BUILD_DIR)/kernal_entry.o: $(SRC_DIR)/kernal/kernal_entry.asm
	nasm $(SRC_DIR)/kernal/kernal_entry.asm -f elf -o $(BUILD_DIR)/kernel_entry.o

$(BUILD_DIR)/kernal.o: $(SRC_DIR)/kernal/kernal.c $(SRC_DIR)/drivers/
	i386-elf-gcc -ffreestanding -m32 -g -c  -o "$(BUILD_DIR)/kernel.o" -I $(SRC_DIR) $(SRC_DIR)/kernal/kernal.c -v



$(BUILD_DIR)/OS.bin $(BUILD_DIR)/main.bin : $(BUILD_DIR)/kernal.o $(BUILD_DIR)/kernal_entry.o $(BUILD_DIR)/boot.bin
# i386-elf-ld -o "$(BUILD_DIR)/main.bin" -Ttext 0x1000 "$(BUILD_DIR)/kernel_entry.o" "$(BUILD_DIR)/kernel.o" --oformat binary
	i386-elf-ld  -T linker.ld -o  $(BUILD_DIR)/main.bin build/kernel_entry.o build/kernel.o --oformat binary

	cat $(BUILD_DIR)/boot.bin $(BUILD_DIR)/main.bin > $(BUILD_DIR)/OS.bin
	
# cp $(BUILD_DIR)/OS.bin $(BUILD_DIR)/main_floppy.img
# truncate -s -1440k $(BUILD_DIR)/OS.bin

# $(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
# 	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
# 	truncate -s -1440k $(BUILD_DIR)/main_floppy.img