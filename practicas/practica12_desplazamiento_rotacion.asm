; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 12. Desplazamiento y rotación
; Descripción: Demuestra SHL, SHR, SAR, desplazamientos con constante y con CL, y las rotaciones ROL, ROR, RCL y RCR mostrando AL en binario y la bandera CF.

INCLUDE Irvine32.inc

.data
t1     BYTE "1 - SHL 1 (izquierda, multiplica por 2):", 0
t2     BYTE "2 - SHR 1 (derecha, divide entre 2):", 0
t3     BYTE "3 - SAR 1 (derecha con signo, AL = -9):", 0
t4     BYTE "4 - SHL con constante 2 (multiplica por 4):", 0
t5     BYTE "5 - SHR con CL = 2 (divide entre 4):", 0
t6     BYTE "6 - ROL 1 (rota a la izquierda):", 0
t7     BYTE "7 - ROR 1 (rota a la derecha):", 0
t8     BYTE "8 - RCL 1 dos veces (rota con acarreo, CF inicia en 0):", 0
t9     BYTE "9 - RCR 1 dos veces (rota con acarreo, CF inicia en 0):", 0
sAntes BYTE "   antes : ", 0
sDesp  BYTE "   despues: ", 0
sCF    BYTE "  CF = ", 0
sDec   BYTE "  decimal = ", 0

.code
main PROC
    ; 1, SHL. Desplazamiento de un bit hacia la izquierda, el bit alto sale a CF
    mov edx, OFFSET t1
    call Titulo
    mov al, 10000010b
    call Antes
    shl al, 1
    call Despues

    ; 2, SHR. Desplazamiento de un bit hacia la derecha, entra 0 por la izquierda
    mov edx, OFFSET t2
    call Titulo
    mov al, 00001100b
    call Antes
    shr al, 1
    call Despues

    ; 3, SAR. Desplazamiento con signo, conserva el bit de signo
    mov edx, OFFSET t3
    call Titulo
    mov al, -9
    call Antes
    sar al, 1
    call Despues
    mov edx, OFFSET sDec
    call WriteString
    movsx eax, al               ; extiende AL con signo para mostrarlo en decimal
    call WriteInt
    call Crlf

    ; 4, Desplazamiento con constante
    mov edx, OFFSET t4
    call Titulo
    mov al, 00001100b
    call Antes
    shl al, 2
    call Despues

    ; 5, Desplazamiento con CL, el número de posiciones va en CL
    mov edx, OFFSET t5
    call Titulo
    mov al, 00010100b
    mov cl, 2
    call Antes
    shr al, cl
    call Despues

    ; ROL, ROR, RCL, RCR
    mov edx, OFFSET t6
    call Titulo
    mov al, 10010001b
    call Antes
    rol al, 1                   ; el bit alto sale y entra por la derecha
    call Despues

    mov edx, OFFSET t7
    call Titulo
    mov al, 00010011b
    call Antes
    ror al, 1                   ; el bit bajo sale y entra por la izquierda
    call Despues

    mov edx, OFFSET t8
    call Titulo
    clc                         ; CF vale 0
    mov al, 10000001b
    call Antes
    rcl al, 1                   ; rota incluyendo la bandera CF
    call Despues
    rcl al, 1
    call Despues

    mov edx, OFFSET t9
    call Titulo
    clc
    mov al, 00000011b
    call Antes
    rcr al, 1
    call Despues
    rcr al, 1
    call Despues

    exit
main ENDP

; Imprime una línea en blanco y el título de EDX
Titulo PROC
    call Crlf
    call WriteString
    call Crlf
    ret
Titulo ENDP

; Imprime antes y el valor de AL
Antes PROC
    push edx
    mov edx, OFFSET sAntes
    call WriteString
    pop edx
    call MostrarAL
    ret
Antes ENDP

; Imprime despues y el valor de AL
Despues PROC
    push edx
    mov edx, OFFSET sDesp
    call WriteString
    pop edx
    call MostrarAL
    ret
Despues ENDP

; Muestra AL en binario y el valor de CF sin alterar los registros ni las banderas
MostrarAL PROC
    pushfd                      ; respalda las banderas
    push eax
    push ebx
    push edx
    push esi

    setc bl                     ; BL recibe el valor de CF
    movzx esi, bl               ; ESI guarda el valor de CF

    movzx eax, al
    mov ebx, TYPE BYTE
    call WriteBinB

    mov edx, OFFSET sCF
    call WriteString
    mov eax, esi
    call WriteDec
    call Crlf

    pop esi
    pop edx
    pop ebx
    pop eax
    popfd                       ; restaura las banderas
    ret
MostrarAL ENDP

END main
