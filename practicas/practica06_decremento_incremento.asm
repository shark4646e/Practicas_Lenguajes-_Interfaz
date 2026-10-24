; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6. Decremento e incremento
; Descripción: Validación de un PIN con tres intentos, DEC reduce los intentos restantes y JZ bloquea el sistema al llegar a cero.

INCLUDE Irvine32.inc

.data
msgPIN      BYTE "Ingrese pin de acceso: ",0
msgError    BYTE "Pin Incorrecto.",0
msjAcceso   BYTE "Acceso Permitido.",0
msgIntento  BYTE "Intentos Restantes: ",0
msjBloqueo  BYTE "SISTEMA BLOQUEADO",0

pinCorrecto = 1234              ; Define el PIN que permite entrar

.code
main PROC
    mov ebx, 3                  ; Guarda los intentos disponibles

intento:
    mov edx, OFFSET msgPIN
    call WriteString            ; Solicita el codigo de acceso
    call ReadInt                ; Lee el PIN introducido

    cmp eax, pinCorrecto        ; Comprueba si el PIN coincide
    je acceso                   ; Continua si el codigo es correcto

    mov edx, OFFSET msgError    ; Prepara el aviso de error
    call WriteString
    call Crlf

    dec ebx                     ; Resta un intento
    jz bloqueado                ; Bloquea al agotar los intentos

    mov edx, OFFSET msgIntento  ; Indica los intentos que quedan
    call WriteString
    mov eax, ebx
    call WriteDec
    call Crlf

    jmp intento                 ; Solicita el PIN nuevamente

acceso:
    mov edx, OFFSET msjAcceso   ; Prepara el mensaje de entrada autorizada
    call WriteString
    call Crlf
    jmp fin

bloqueado:
    mov edx, OFFSET msjBloqueo  ; Prepara el aviso de bloqueo
    call WriteString
    call Crlf

fin:
    exit
main ENDP

END main
