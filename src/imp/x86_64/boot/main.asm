global start

section .text
bits 32

start:

    mov esp, stack_top ;set up the stack pointer to top of 16KB stack

    ; print 'ok'
    mov dword [0xb8000], 0x2f4b2f4f
    hlt


 ;define a stack by reserving 16KB of uninitialized space
 
section .bss ;includes statically allocated variables
stack_bottom:
    resb 4096 * 4 
stack_top: 
