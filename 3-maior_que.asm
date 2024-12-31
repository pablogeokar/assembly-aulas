segment .data
    LF          equ 0xA     ; Line Feed
    NULL        equ 0x0     ; Null
    SYS_CALL    equ 0x80    ; Envia informação ao S.O.
    ; EAX
    RET_EXIT    equ 0x0     ; operacao realizada com sucesso
    SYS_READ    equ 0x3     ; syscall read
    SYS_WRITE   equ 0x4     ; Operação de escrita
    ; EBX
    SYS_EXIT    equ 0x1     ; syscall exit
    STD_IN      equ 0x0     ; saída padrão
    STD_OUT     equ 0x1     ; stdout

section .data
    x dd 50 ; db define byte (1 byte), dw define word (2 bytes), dd define double word (4 bytes), dq define quad word (8 bytes), dt define ten word (10 bytes) 
    y dd 10
    msg1 db 'O valor de x é maior que y', LF, NULL
    tam1 equ $- msg1
    msg2 db 'O valor de y é maior que x', LF, NULL
    tam2 equ $- msg2

section .text

global _start

_start:
    mov eax, dword [x] ; tudo que está na sessão .data usa o dword
    mov ebx, dword [y]
    ; compare eax, ebx
    cmp eax, ebx
    ; je = jump if equal 
    ; jg = jump if greater 
    ; jl = jump if less 
    ; jge = jump if greater or equal 
    ; jle = jump if less or equal
    jge maior
    mov ecx, msg2
    mov edx, tam2

    jmp final

maior:
    mov ecx, msg1
    mov edx, tam1
    

final:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL

    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL
    

    