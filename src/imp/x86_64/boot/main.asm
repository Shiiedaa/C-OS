global start

section .text
bits 32

start:

    mov esp, stack_top ;set up the stack pointer to top of 16KB stack

    call check_multiboot
    call check_cpuid
    call check_long_mode

    ; print 'ok'
    mov dword [0xb8000], 0x2f4b2f4f
    hlt

check_multiboot:
    cmp eax, 0x36d76289
    jne .no_multiboot
    ret
.no_multiboot:
    mov al, "M"
    jmp error

; if we can flip the id byte in the flag register then cpu id is available
check_cpuid:
    pushfd
    pop eax
    mov ecx, eax
    xor eax, 1 << 21 ; flip id bit
    push eax
    popfd
    pushfd
    pop eax
    push ecx
    popfd
    cmp eax, ecx ; if matched, the cpu did not allow us to flip the bit
    je .no_cpuid
    ret

no_cpuid:
    mov al, "C"
    jmp error

check_long_mode:
    mov eax, 0x80000000
    cpu

; writes "ERROR: " plus the specific code 
error:
    mov dword [0xb8000], 0x4f524f45
    mov dword [0xb8004], 0x4f3a4f52
    mov dword [0xb8008], 0x4f204f20
    mov dword [0xb800a], al
    hlt



 ;define a stack by reserving 16KB of uninitialized space
 
section .bss ;includes statically allocated variables
stack_bottom:
    resb 4096 * 4 
stack_top: 
