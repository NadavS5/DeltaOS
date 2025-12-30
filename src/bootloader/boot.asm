org 0x7c00
bits 16
KERNEL_LOCATION equ 0x1000

jmp short main

;section .data
BOOT_DISK db 0



GDT_Descriptor: 
dw GDT_END - gdt_start - 1
dd gdt_start


CODE_SEG equ code_descriptor-gdt_start
DATA_SEG equ data_descriptor-gdt_start

gdt_start:
		null_descriptor: 
			dd 0
			dd 0
		code_descriptor:
			dw 0xffff ; limit 
			
			dw 0	
			db 0 	;;;; this 24 bits are the base (locatiom)

			db 0b10011010
			; pres, priv, type flags, other flags
			; p, p, type Flags
			db 0b11001111
			; 4bit other Flags + 4bit limit
			db 0
			; last 8 bits of base
			data_descriptor:
			dw 0xffff ; limit
			dw 0
			db 0
			db 0b10010010
			db 0b11001111
			db 0
			GDT_END:

main:
	mov [BOOT_DISK] , dl
	
	

	; mov bx , 07e00h ; pointer to load the sector
	; xor ax , ax
	; mov es , ax

	; mov ah, 2
	; mov al, 1; number of sectors to read (sector = 512 bytes)
	; mov ch, 0 ; cylinder number
	; mov dh, 0 ; head number 
	; mov cl, 2 ; sector number
	; mov dl, [boostDisk]
	; int 13h
	;mov bx, hello
	;call sprint
		xor ax, ax                          
		mov es, ax
		mov ds, ax
		mov bp, 0x8000
		mov sp, bp

		mov bx, KERNEL_LOCATION
		mov dh, 2

		mov ah, 2
		mov al, dh 
		mov ch, 0x00
		mov dh, 0x00
		mov cl, 0x02
		mov dl, [BOOT_DISK]
		int 0x13   
		             ; no error management, do your homework!
					 
		mov ah, 0x0
		mov al, 0x3
		int 0x10	;text mode   
	

	
	;Loading The GDT
	cli
	lgdt [GDT_Descriptor]
	;change last bit of cr0 to 1
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEG:start_protected_mode

	[bits 32]
	start_protected_mode:
	
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov ebp, 0x90000		; 32 bit stack base pointer
	mov esp, ebp

	
	jmp KERNEL_LOCATION	
	
.halt:
	jmp .halt


times 510 -($-$$) db 0
db 0x55,0xaa

; .sector2:
;  db 'eyalhacool',0
; times 512 - ($-.sector2) db 'B'


; init_graphics_vesa:
; 	mov ax, 0x4F02  ; VESA function: set mode
; 	mov bx, 0x118   ; Mode 1024×768	 24-bit (8:8:8)
; 	int 0x10        ; Call BIOS
; 	ret