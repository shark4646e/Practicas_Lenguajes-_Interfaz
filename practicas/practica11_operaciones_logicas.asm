; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 11. Operaciones lógicas
; Descripción: Usa AND, OR, XOR y TEST sobre un byte de estado de una computadora (bit 0 encendida, bit 1 alarma, bit 2 conectada).

INCLUDE Irvine32.inc

; ESTADOS DE COMPUTADORA
; 0 - Computadora Encendida   0: No 1: Si
; 1 - Alarma                  0: No 1: Si
; 2 - Computadora esta conectada
; Estado inicial: 0000 0101

.data
tInicial BYTE "Estado inicial: 00000101 (encendida, sin alarma, conectada)", 0
tAnd     BYTE "1 - AND con 00000010b (aisla el bit de alarma): ", 0
tOr      BYTE "2 - OR con 00000010b (enciende la alarma): ", 0
tXor1    BYTE "3 - XOR con 00000001b (apaga la computadora): ", 0
tXor2    BYTE "3 - XOR con 00000001b (la vuelve a encender): ", 0
tTest1   BYTE "4 - TEST con estado 00000111b: ", 0
tTest2   BYTE "4 - TEST con estado 00000101b: ", 0
msgOn    BYTE "alarma encendida", 0
msgOff   BYTE "alarma apagada", 0

.code
main PROC
    mov edx, OFFSET tInicial
    call WriteString
    call Crlf
    call Crlf

    ; 1 - Operación AND: Evaluación de estado de alarma (deja solo el bit 1)
    mov edx, OFFSET tAnd
    call WriteString
    mov al, 00000101b
    and al, 00000010b
    call MostrarBits

    ; 2 - Operación OR: Encender alarma (pone en 1 el bit 1)
    mov edx, OFFSET tOr
    call WriteString
    mov al, 00000101b
    or al, 00000010b
    call MostrarBits

    ; 3 - Operación XOR: Apagar y encender la computadora (invierte el bit 0)
    mov edx, OFFSET tXor1
    call WriteString
    mov al, 00000101b
    xor al, 00000001b
    call MostrarBits

    mov edx, OFFSET tXor2
    call WriteString
    xor al, 00000001b           ; segundo XOR: vuelve al valor anterior
    call MostrarBits

    call Crlf

    ; 4 - Operación TEST: Evaluar la alarma encendida y apagada
    ; Mandar mensaje de "alarma encendida" o "alarma apagada"
    mov edx, OFFSET tTest1
    call WriteString
    mov al, 00000111b
    test al, 00000010b          ; AND sin guardar resultado: ZF = 1 si el bit 1 está apagado
    jz alarmaApagadaA
    mov edx, OFFSET msgOn
    jmp imprimirA
alarmaApagadaA:
    mov edx, OFFSET msgOff
imprimirA:
    call WriteString
    call Crlf

    mov edx, OFFSET tTest2
    call WriteString
    mov al, 00000101b
    test al, 00000010b
    jz alarmaApagadaB
    mov edx, OFFSET msgOn
    jmp imprimirB
alarmaApagadaB:
    mov edx, OFFSET msgOff
imprimirB:
    call WriteString
    call Crlf

    exit
main ENDP

; Muestra AL en binario (8 bits) con WriteBinB y salta de línea
MostrarBits PROC
    push eax
    push ebx
    movzx eax, al               ; extiende AL a EAX con ceros
    mov ebx, TYPE BYTE          ; EBX = tamaño en bytes (1) para WriteBinB
    call WriteBinB
    call Crlf
    pop ebx
    pop eax
    ret
MostrarBits ENDP

END main
