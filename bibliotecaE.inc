segment .data
    LF          equ 0xA     ; Line Feed
    NULL        equ 0x0     ; Null
    SYS_CALL    equ 0x80    ; Envia informação ao S.O.
    ; EBX
    SYS_EXIT    equ 0x1     ; syscall exit
    STD_IN      equ 0x0     ; saída padrão
    STD_OUT     equ 0x1     ; stdout
    ; EAX
    RET_EXIT    equ 0x0     ; operacao realizada com sucesso
    SYS_READ    equ 0x3     ; syscall read
    SYS_WRITE   equ 0x4     ; Operação de escrita    

    TAM_BUFFER  equ 0xA

    segment .bss
        BUFFER resb 0x1
    
    segment .text

    saidaResultado:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        mov ecx, BUFFER
        mov edx, TAM_BUFFER
        int SYS_CALL
        ret