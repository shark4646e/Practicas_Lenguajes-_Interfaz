; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 2. Captura y desplegado de mensajes
; Descripción: Pide el nombre al usuario con ReadString y lo despliega dentro de un mensaje de saludo.

INCLUDE Irvine32.inc

.data
    msgNombre BYTE "Escribe tu nombre: ",0   ; mensaje para solicitar el dato
    msgSaludo BYTE "Tu nombre es: ",0        ; mensaje para mostrar el resultado
    nombre BYTE 30 DUP(0)                    ; buffer de 30 bytes para el texto capturado

.code
main PROC
    mov edx, OFFSET msgNombre   ; despliega la solicitud
    call WriteString

    mov edx, OFFSET nombre      ; EDX = dirección donde se guarda lo escrito
    mov ecx, SIZEOF nombre - 1  ; ECX = máximo de caracteres (deja espacio al 0 final)
    call ReadString             ; captura la cadena; EAX = caracteres leídos

    mov edx, OFFSET msgSaludo   ; despliega el saludo
    call WriteString
    mov edx, OFFSET nombre      ; y a continuación el nombre capturado
    call WriteString
    call Crlf

    exit
main ENDP
END main
