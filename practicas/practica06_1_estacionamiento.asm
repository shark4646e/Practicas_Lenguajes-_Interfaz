; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6.1. Control de ocupación de un estacionamiento
; Descripción: Menú que usa INC y DEC para llevar la cuenta de carros dentro de un estacionamiento de 20 lugares, avisando cuando está lleno o vacío.

INCLUDE Irvine32.inc

.data
capacidad = 20                  ; Fija el maximo de espacios disponibles

msgOp1      BYTE "1. Entra un carro",0
msgOp2      BYTE "2. Sale un carro",0
msgOp3      BYTE "3. Salir",0
msgOpcion   BYTE "Opcion: ",0
msgLleno    BYTE "ESTACIONAMIENTO LLENO: no se permite entrar mas carros.",0
msgVacio    BYTE "ESTACIONAMIENTO VACIO.",0
msgCarros   BYTE "Carros dentro: ",0

.code
main PROC
    mov ebx, 0                  ; Comienza sin vehiculos registrados

menu:
    call Crlf
    mov edx, OFFSET msgOp1
    call WriteString
    call Crlf
    mov edx, OFFSET msgOp2
    call WriteString
    call Crlf
    mov edx, OFFSET msgOp3
    call WriteString
    call Crlf
    mov edx, OFFSET msgOpcion
    call WriteString
    call ReadInt                ; Captura la opcion seleccionada

    cmp eax, 1                  ; Revisa si se eligio la entrada
    je entrada
    cmp eax, 2                  ; Revisa si se eligio la salida
    je salida
    cmp eax, 3                  ; Revisa si se eligio terminar
    je fin
    jmp menu                    ; Vuelve al menu si la opcion no existe

entrada:
    cmp ebx, capacidad          ; Comprueba si quedan lugares
    jae lleno                   ; No permite superar la capacidad
    inc ebx                     ; Registra un vehiculo adicional
    cmp ebx, capacidad          ; Comprueba si se ocupo el ultimo lugar
    jne mostrar                 ; Muestra el total si aun no esta lleno
lleno:
    mov edx, OFFSET msgLleno    ; Informa que se alcanzo el limite
    call WriteString
    call Crlf
    jmp mostrar

salida:
    cmp ebx, 0                  ; Comprueba si hay vehiculos
    je vacio                    ; Evita restar cuando no hay carros
    dec ebx                     ; Registra la salida de un vehiculo
    jnz mostrar                 ; Muestra el total si quedan vehiculos
vacio:
    mov edx, OFFSET msgVacio    ; Informa que no hay carros dentro
    call WriteString
    call Crlf

mostrar:
    mov edx, OFFSET msgCarros   ; Prepara el texto del total actual
    call WriteString
    mov eax, ebx
    call WriteDec
    call Crlf
    jmp menu                    ; Regresa al menu principal

fin:
    exit
main ENDP
END main
