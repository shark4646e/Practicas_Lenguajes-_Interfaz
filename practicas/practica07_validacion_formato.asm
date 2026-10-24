; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 7. Validación de formato
; Descripción: Valida que un código tenga el formato AAA-999 (3 letras mayúsculas, guion y 3 dígitos) revisando carácter por carácter.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Ingrese el codigo: ",0
    valido BYTE "Formato valido",0
    invalido BYTE "Formato invalido",0

    cadena BYTE 20 DUP(0)       ; buffer para el texto capturado

.code
main PROC

    ; Pedir el texto
    mov edx, OFFSET mensaje
    call WriteString

    ; Leer el texto
    mov edx, OFFSET cadena
    mov ecx, 19                 ; máximo de caracteres a leer
    call ReadString             ; EAX = longitud de lo capturado

    ; Comprobar longitud: el formato AAA-999 tiene 7 caracteres
    cmp eax, 7
    jne fallo

    ; Posicion 0: A-Z (rango de letras mayúsculas con JB/JA, sin signo)
    mov al, cadena[0]
    cmp al, 'A'
    jb fallo
    cmp al, 'Z'
    ja fallo

    ; Posicion 1: A-Z
    mov al, cadena[1]
    cmp al, 'A'
    jb fallo
    cmp al, 'Z'
    ja fallo

    ; Posicion 2: A-Z
    mov al, cadena[2]
    cmp al, 'A'
    jb fallo
    cmp al, 'Z'
    ja fallo

    ; Posicion 3: debe ser el guion
    mov al, cadena[3]
    cmp al, '-'
    jne fallo

    ; Posicion 4: 0-9
    mov al, cadena[4]
    cmp al, '0'
    jb fallo
    cmp al, '9'
    ja fallo

    ; Posicion 5: 0-9
    mov al, cadena[5]
    cmp al, '0'
    jb fallo
    cmp al, '9'
    ja fallo

    ; Posicion 6: 0-9
    mov al, cadena[6]
    cmp al, '0'
    jb fallo
    cmp al, '9'
    ja fallo

    ; Si todo es correcto
    mov edx, OFFSET valido
    call WriteString
    jmp salir

fallo:                          ; cualquier validación fallida llega aquí
    mov edx, OFFSET invalido
    call WriteString

salir:
    call Crlf
    exit

main ENDP
END main
