; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5.1. Repetir hasta que el usuario ingrese cero
; Descripción: Pide números con ReadInt y los muestra con WriteInt hasta que el usuario escribe 0.

INCLUDE Irvine32.inc

.data
    msgNumero BYTE "Ingresa un numero (0 para terminar): ",0
    msgEco BYTE "Numero ingresado: ",0

.code
main PROC

ciclo:
    mov edx, OFFSET msgNumero
    call WriteString
    call ReadInt

    cmp eax, 0
    je fin

    mov ebx, eax
    mov edx, OFFSET msgEco
    call WriteString
    mov eax, ebx
    call WriteInt
    call Crlf

    jmp ciclo

fin:
    exit
main ENDP
END main