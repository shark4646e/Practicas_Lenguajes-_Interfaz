; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4.1. Mayor, menor o igual con entrada del usuario
; Descripción: Lee dos números con ReadInt, los compara con CMP e indica si el primero es mayor, menor o igual al segundo.

INCLUDE Irvine32.inc

.data
    num1 BYTE "Ingresa el primer numero: ",0
    num2 BYTE "Ingresa el segundo numero: ",0
    igualMsg BYTE "Los numeros son iguales",0
    mayorMsg BYTE "El primer numero es mayor",0
    menorMsg BYTE "El primer numero es menor",0

.code
main PROC

    mov edx, OFFSET num1
    call WriteString
    call ReadInt                ; lee un entero con signo; queda en EAX
    mov ebx, eax                ; guarda el primer número en EBX

    mov edx, OFFSET num2
    call WriteString
    call ReadInt                ; segundo número en EAX

    cmp ebx, eax                ; compara primero contra segundo
    je iguales                  ; ZF = 1: iguales
    jg mayor                    ; primero > segundo (con signo)
    jl menor                    ; primero < segundo (con signo)

iguales:
    mov edx, OFFSET igualMsg
    call WriteString
    jmp salir

mayor:
    mov edx, OFFSET mayorMsg
    call WriteString
    jmp salir

menor:
    mov edx, OFFSET menorMsg
    call WriteString

salir:
    call Crlf
    exit

main ENDP
END main
