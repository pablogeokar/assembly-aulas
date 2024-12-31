%include "bibliotecaE.lib"

section .text

global _start

_start:
    lea esi, [BUFFER] ; load effective address
    add esi, 0x9 ; add 9 to esi
    mov byte[esi], 0xA ; store 0xA in the memory address pointed by esi

    dec esi ; decrement esi
    mov dl, 0x11 ; move 0x11 to dl 0x11 representa a letra "a" na tabela ascii
    add dl, '0' ; add '0' to dl este código converte o valor 0x11 para a string "a"
    mov [esi], dl ; store dl in the memory address pointed by esi

    call saidaResultado ; call saidaResultado

    mov eax, SYS_EXIT ; move SYS_EXIT to eax
    mov ebx, RET_EXIT ; move RET_EXIT to ebx
    int SYS_CALL ; call SYS_CALL