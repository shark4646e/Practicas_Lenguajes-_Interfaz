; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 9. PUSH y POP
; Descripción: Muestra con DumpRegs el uso de la pila, PUSH y POP, orden LIFO, conservar registros, CALL y RET.

INCLUDE Irvine32.inc

.data
tBloque1 BYTE "BLOQUE 1: PUSH Y POP (EBX debe quedar en 40)", 0
tBloque2 BYTE "BLOQUE 2: ORDEN LIFO (EAX=30, EBX=20, ECX=10)", 0
tBloque3 BYTE "BLOQUE 3: CONSERVAR REGISTROS (EAX=100, EBX=200)", 0
tBloque4 BYTE "BLOQUE 4: CALL Y RET (EAX=60, EBX=100)", 0

.code
main PROC
    ; BLOQUE 1, PUSH Y POP. Se guarda EAX en la pila y se recupera en EBX
    mov edx, OFFSET tBloque1
    call MostrarTitulo

    mov eax, 40
    push eax                    ; coloca 40 en la pila
    nop

    mov eax, 0                  ; EAX cambia, la pila conserva el 40
    pop ebx                     ; EBX vale 40
    nop
    call DumpRegs               ; muestra los registros

    ; BLOQUE 2, ORDEN LIFO. El último en entrar es el primero en salir
    mov edx, OFFSET tBloque2
    call MostrarTitulo

    mov eax, 10
    push eax
    mov eax, 20
    push eax
    mov eax, 30
    push eax
    nop

    pop eax                     ; sale 30
    pop ebx                     ; sale 20
    pop ecx                     ; sale 10
    nop
    call DumpRegs

    ; BLOQUE 3, CONSERVAR REGISTROS. Se respaldan antes de modificarlos
    mov edx, OFFSET tBloque3
    call MostrarTitulo

    mov eax, 100
    mov ebx, 200

    push eax
    push ebx

    mov eax, 999                ; se alteran los registros
    mov ebx, 666
    call DumpRegs

    pop ebx                     ; se restauran en orden inverso
    pop eax
    nop
    call DumpRegs

    ; BLOQUE 4, CALL Y RET. CALL guarda la dirección de retorno en la pila
    mov edx, OFFSET tBloque4
    call MostrarTitulo

    mov eax, 50
    mov ebx, 100

    call aumentarDiez
    nop
    call DumpRegs

    exit
main ENDP

; Imprime una línea en blanco, el título apuntado por EDX y otra línea
MostrarTitulo PROC
    call Crlf
    call WriteString
    call Crlf
    ret
MostrarTitulo ENDP

; Suma 10 a EAX conservando el valor original de EBX
aumentarDiez PROC
    push ebx                    ; respalda EBX

    mov ebx, 10
    add eax, ebx

    pop ebx                     ; restaura EBX

    ret
aumentarDiez ENDP

END main
