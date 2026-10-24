; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5. Condicionales
; Descripción: Ciclo tipo while con CMP y JG que muestra los números del 1 al 100, uno por línea.

INCLUDE Irvine32.inc

.code
main PROC
    mov ebx, 1          ; Establece el primer numero del conteo

ciclo:
    cmp ebx, 100        ; Verifica si el contador ya paso de 100
    jg fin              ; Termina cuando supera el limite

    mov eax, ebx        ; Prepara el numero para mostrarlo
    call WriteDec       ; Escribe el numero en pantalla
    call Crlf           ; Pasa a la siguiente linea

    inc ebx             ; Avanza al siguiente numero
    jmp ciclo           ; Repite el proceso

fin:
    exit
main ENDP

END main
