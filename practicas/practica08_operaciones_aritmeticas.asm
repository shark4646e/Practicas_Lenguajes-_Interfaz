; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 8. Operaciones aritméticas
; Descripción: Prueba ADD, SUB, INC, DEC, la bandera de acarreo CF, la bandera de desbordamiento OF, MUL, IMUL y DIV.

INCLUDE Irvine32.inc

.data
    msgAdd BYTE "ADD EAX, 20 (EAX = 50): ",0
    msgSub BYTE "SUB EAX, 15: ",0
    msgInc BYTE "INC EAX: ",0
    msgDec BYTE "DEC EAX: ",0
    msgSinSigno BYTE "255 + 1 sin signo en AL: ",0
    msgAcarreo BYTE "AL = 0, CF = 1 (hay acarreo)",0
    msgNoAcarreo BYTE "sin acarreo",0
    msgConSigno BYTE "127 + 1 con signo en AL: ",0
    msgOverflow BYTE "AL = -128, OF = 1 (hay overflow)",0
    msgNoOverflow BYTE "sin overflow",0
    msgMul BYTE "MUL EBX (25 x 3), EAX: ",0
    msgMulEdx BYTE "MUL EBX, EDX: ",0
    msgImul BYTE "IMUL EAX, EAX, 3 (-5 x 3): ",0
    msgCociente BYTE "DIV EBX (125 / 12), cociente en EAX: ",0
    msgResiduo BYTE "DIV EBX, residuo en EDX: ",0

.code
main PROC
    ; Suma, resta, incremento y decremento
    mov eax, 50
    add eax, 20
    mov edx, OFFSET msgAdd
    call MostrarResultado

    sub eax, 15
    mov edx, OFFSET msgSub
    call MostrarResultado

    inc eax
    mov edx, OFFSET msgInc
    call MostrarResultado

    dec eax
    mov edx, OFFSET msgDec
    call MostrarResultado

    call Crlf

    ; Acarreo CF. Sumar 255 más 1 en 8 bits sin signo da 0 y enciende CF
    mov edx, OFFSET msgSinSigno
    call WriteString
    mov al, 255
    add al, 1
    jc hayAcarreo               ; salta si CF vale 1
    mov edx, OFFSET msgNoAcarreo
    jmp mostrarAcarreo
hayAcarreo:
    mov edx, OFFSET msgAcarreo
mostrarAcarreo:
    call WriteString
    call Crlf

    ; Desbordamiento OF. Sumar 127 más 1 en 8 bits con signo da menos 128 y enciende OF
    mov edx, OFFSET msgConSigno
    call WriteString
    mov al, 127
    add al, 1
    jo hayOverflow              ; salta si OF vale 1
    mov edx, OFFSET msgNoOverflow
    jmp mostrarOverflow
hayOverflow:
    mov edx, OFFSET msgOverflow
mostrarOverflow:
    call WriteString
    call Crlf

    call Crlf

    ; MUL. EDX y EAX reciben el producto de EAX por EBX sin signo
    mov eax, 25
    mov ebx, 3
    mul ebx
    mov ecx, edx                ; guarda la parte alta del producto
    mov edx, OFFSET msgMul
    call MostrarResultado       ; muestra EAX, parte baja
    mov eax, ecx
    mov edx, OFFSET msgMulEdx
    call MostrarResultado       ; muestra EDX, parte alta

    ; IMUL, multiplicación con signo, forma de tres operandos
    mov eax, -5
    imul eax, eax, 3
    mov edx, OFFSET msgImul
    call MostrarResultado

    call Crlf

    ; DIV. Divide EDX y EAX entre EBX, el cociente queda en EAX y el residuo en EDX
    mov edx, 0                  ; la parte alta del dividendo debe ser 0
    mov eax, 125
    mov ebx, 12
    div ebx
    mov ecx, edx                ; guarda el residuo
    mov edx, OFFSET msgCociente
    call MostrarResultado
    mov eax, ecx
    mov edx, OFFSET msgResiduo
    call MostrarResultado

    exit
main ENDP

; Procedimiento que imprime el mensaje apuntado por EDX seguido del número en EAX
MostrarResultado PROC
    push eax                    ; WriteString puede cambiar EAX, se respalda
    call WriteString
    pop eax
    push eax
    call WriteInt
    call Crlf
    pop eax
    ret
MostrarResultado ENDP

END main
