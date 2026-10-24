; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4. Saltos
; Descripción: Demuestra el salto incondicional JMP y los saltos condicionales JE, JNE, JG con signo y JB sin signo.

INCLUDE Irvine32.inc

.data
    msgJmp BYTE "JMP: salto incondicional realizado",0
    msgIgual BYTE "JE: EAX y EBX son iguales",0
    msgDistinto BYTE "JNE: EAX y EBX son distintos",0
    msgMayor BYTE "JG (signed): EAX es mayor que EBX",0
    msgMenor BYTE "JG (signed): EAX no es mayor que EBX",0
    msgBajo BYTE "JB (unsigned): EAX es menor que EBX",0
    msgNoBajo BYTE "JB (unsigned): EAX no es menor que EBX",0

.code
main PROC
    ; JMP, salto incondicional, va directo a la etiqueta indicada
    jmp saltoIncondicional

saltoIncondicional:
    mov edx, OFFSET msgJmp
    call WriteString
    call Crlf

    ; JE, salta si los valores son iguales, ZF vale 1
    mov eax, 10
    mov ebx, 10
    cmp eax, ebx
    je iguales
    mov edx, OFFSET msgDistinto
    jmp mostrarIgualdad
iguales:
    mov edx, OFFSET msgIgual
mostrarIgualdad:
    call WriteString
    call Crlf

    ; JG, salta si EAX es mayor que EBX interpretando los números con signo
    mov eax, 10
    mov ebx, 5
    cmp eax, ebx
    jg mayor
    mov edx, OFFSET msgMenor
    jmp mostrarSigned
mayor:
    mov edx, OFFSET msgMayor
mostrarSigned:
    call WriteString
    call Crlf

    ; JB, salta si EAX es menor que EBX interpretando los números sin signo
    mov eax, 5
    mov ebx, 10
    cmp eax, ebx
    jb menorSinSigno
    mov edx, OFFSET msgNoBajo
    jmp mostrarUnsigned
menorSinSigno:
    mov edx, OFFSET msgBajo
mostrarUnsigned:
    call WriteString
    call Crlf

    exit
main ENDP
END main
