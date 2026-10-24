; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 1. Ciclos numéricos
; Descripción: Usa la instrucción LOOP con ECX como contador y muestra su valor en cada vuelta, antes y después del ciclo.

INCLUDE Irvine32.inc

.data
    msgEcx BYTE "ECX antes de LOOP: ",0      ; texto que se muestra en cada vuelta
    msgFin BYTE "Fin del ciclo, ECX = ",0    ; texto final al terminar el ciclo

.code
main PROC
    mov ecx, 5                  ; ECX = número de repeticiones del ciclo

ciclo:
    mov edx, OFFSET msgEcx      ; EDX apunta al mensaje para WriteString
    call WriteString
    mov eax, ecx                ; WriteInt imprime el valor de EAX
    call WriteInt
    call Crlf                   ; salto de línea

    loop ciclo                  ; ECX = ECX - 1; si ECX != 0 regresa a "ciclo"

    mov edx, OFFSET msgFin      ; al salir del ciclo ECX vale 0
    call WriteString
    mov eax, ecx
    call WriteInt
    call Crlf

    exit
main ENDP
END main
