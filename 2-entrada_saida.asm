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
    msg db 'Entre com o seu nome: ', LF, NULL
    tam equ $- msg
    msgSaida db 'O nome digitado foi: ', NULL
    tamSaida equ $- msgSaida

section .bss
    nome resb 100  ; Aumenta o buffer para 100 bytes

section .text

global _start

_start:
    ; Escreve a mensagem
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, tam
    int SYS_CALL

    ; Lê o nome
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, nome
    mov edx, 100 ; lê até 100 bytes
    int SYS_CALL

    ; Escreve a mensagem de saída
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msgSaida
    mov edx, tamSaida
    int SYS_CALL

    ; Escreve o nome lido
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, nome
    mov edx, 100 ; Escreve até 100 bytes
    int SYS_CALL

    ; saída do programa
    mov eax, SYS_EXIT
    xor ebx, ebx
    int SYS_CALL
