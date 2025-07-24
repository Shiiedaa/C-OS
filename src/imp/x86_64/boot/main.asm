global start

section .text
bits 32

start:

    mov esp, stack_top ;set up the stack pointer to top of 16KB stack

    call check_multiboot
    call check_cpuid
    call check_long_mode


    call setup_page_tables
    call enable_paging

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
    cpuid 
    cmp eax, 0x80000001
    jb .no_long_mode

    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29 ;lm bit
    jz .no_long_mode

    ret 

.no_long_mode:
    mov al, "L"
    jmp error

setup_page_tables:
    mov eax, page_table_l3
    or eax, 0b11 ;present, writable
    mov [page_table_l4], eax

    mov eax, page_table_l2
    or eax, 0b11 
    mov [page_table_l3], eax

    mov ecx, 0 ;counter

.loop:

    mov eax, 0x200000 ; 2Mib
    mul ecx 
    or eax, 0b10000011 
    mov [page_table_l2 + ecq * 8], eax

    inc ecx ;increment counter
    cmp ecx, 512 ;check if table is mapped
    jne .loop ; if not, continue
    
    ret

; writes "ERROR: " plus the specific code 
error:
    mov dword [0xb8000], 0x4f524f45
    mov dword [0xb8004], 0x4f3a4f52
    mov dword [0xb8008], 0x4f204f20
    mov dword [0xb800a], al
    hlt



 ;define a stack by reserving 16KB of uninitialized space
 
section .bss ;includes statically allocated variables
align 4096
page_table_l4:
    resb 4096
page_table_l3:
    resb 4096
page_table_l2:
    resb 4096
stack_bottom:
    resb 4096 * 4 
stack_top: 
