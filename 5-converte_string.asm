%include 'bibliotecaE.lib'

section .data
    v1 dw '105', LF, NULL  ; Define a string '105' seguida por LF (Line Feed) e NULL

section .text

global _start

_start:
    call converter_valor
    call mostrar_valor

    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL

converter_valor:
    lea esi, [v1]          ; Carrega o endereço da string em ESI
    mov ecx, 0x3           ; Define o tamanho da string (3 caracteres)
    call string_to_int     ; Converte a string para inteiro
    add eax, 0x2           ; Adiciona 2 ao valor inteiro
    ret

mostrar_valor:    
    call int_to_string     ; Converte o valor inteiro para string
    call saidaResultado    ; Mostra o valor na saída padrão
    ret

;---------------------------------------------------
; String para inteiro
; Entrada: ESI (valor para converter) ECX (tamanho)
; Saída..: EAX (valor inteiro)
;---------------------------------------------------
string_to_int:
    xor ebx, ebx          ; Zera o registrador EBX (EBX = 0)
.prox_digito:
    movzx eax, byte [esi] ; Move o próximo byte da string apontada por ESI para EAX com zero-extend
    inc esi               ; Incrementa ESI para apontar para o próximo caractere
    sub al, '0'           ; Converte o caractere ASCII para seu valor numérico (ex: '5' -> 5)
    imul ebx, 0xA         ; Multiplica EBX por 10 (desloca o dígito anterior para a esquerda)
    add ebx, eax          ; Adiciona o valor do dígito atual a EBX (EBX = EBX*10 + EAX)
    loop .prox_digito     ; Decrementa ECX e repete o loop se ECX não for zero
    mov eax, ebx          ; Move o valor final de EBX para EAX
    ret                   ; Retorna do procedimento
    

;---------------------------------------------------
; Inteiro para string
; Entrada: inteiro em EAX
; Saída..: BUFFER (valor ECX) TAM_BUFFER (EDX)
;---------------------------------------------------
int_to_string:
    lea esi, [BUFFER]     ; Carrega o endereço do BUFFER em ESI
    add esi, 0x9          ; Ajusta ESI para apontar para o final do buffer (assumindo um buffer de 10 bytes)
    mov byte [esi], 0xA   ; Adiciona um caractere de nova linha (LF) no final do buffer
    mov ebx, 0xA          ; Define o divisor como 10 (para divisão decimal)
.prox_digito:
    xor edx, edx          ; Zera EDX (necessário para a divisão)
    div ebx               ; Divide EAX por 10, resultado em EAX e resto em EDX
    add dl, '0'           ; Converte o dígito numérico em caractere ASCII
    dec esi               ; Decrementa ESI para apontar para a posição anterior no buffer
    mov [esi], dl         ; Armazena o caractere ASCII no buffer
    test eax, eax         ; Testa se o valor de EAX é zero
    jnz .prox_digito      ; Se EAX não for zero, repete o loop para processar o próximo dígito
    ret                   ; Retorna do procedimento