;nasm -f elf64 aula1.asm
;ld -s -o aula1 aula1.o
section .data
    msg db 'Hello World!', 10
    tam equ $- msg

section .text

global _start
    

_start:
    mov eax, 0x4    ; syscall write
    mov ebx, 0x1    ; stdout
    mov ecx, msg    ; ponteiro para a mensagem
    mov edx, tam    ; tamanho da mensagem
    int 0x80        ; Chamada de sistema

saida:
    mov eax, 0x1    ; só estou terminando o programa
    mov ebx, 0x0    ; Só o valor de retorno é 0
    int 0x80        ; Chamada de sistema