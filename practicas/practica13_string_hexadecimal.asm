; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 13. Obtención de una cadena hexadecimal
; Descripción: Convierte un valor de 32 bits a texto hexadecimal tomando 4 bits a la vez (AND 0Fh y SHR 4).

INCLUDE Irvine32.inc

.data
    valor DWORD 12AB34CDh       ; número a convertir
    bufferHex BYTE 9 DUP(0)     ; 8 dígitos hexadecimales + terminador
    msgHex BYTE "Valor en hexadecimal: ",0

.code
main PROC
    mov eax, valor
    mov esi, 7                  ; se llena la cadena de derecha a izquierda
    mov ecx, 8                  ; 8 dígitos hexadecimales en 32 bits

ciclo:
    mov ebx, eax
    and ebx, 0Fh                ; aísla los 4 bits menos significativos

    cmp ebx, 10
    jb esDigito                 ; 0-9: se convierte a '0'-'9'
    sub ebx, 10                 ; 10-15: se convierte a 'A'-'F'
    add ebx, 'A'
    jmp guardar
esDigito:
    add ebx, '0'

guardar:
    mov bufferHex[esi], bl      ; guarda el carácter en su posición
    shr eax, 4                  ; descarta los 4 bits ya procesados
    dec esi
    loop ciclo

    mov bufferHex[8], 0         ; terminador de cadena

    mov edx, OFFSET msgHex
    call WriteString
    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    exit
main ENDP
END main
