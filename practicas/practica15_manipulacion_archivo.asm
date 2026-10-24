; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 15. Manipulación de archivos
; Descripción: Crea el archivo practica15.txt, escribe una línea de texto y lo cierra usando CreateOutputFile, WriteToFile y CloseFile.

INCLUDE Irvine32.inc

.data
    nombreArchivo BYTE "practica15.txt",0
    texto BYTE "Practica 15: crear y guardar un archivo de texto.",0Dh,0Ah,0   ; 0Dh,0Ah = salto de línea
    archivoHandle DWORD ?       ; identificador (handle) del archivo abierto
    mensajeExito BYTE "Archivo guardado correctamente.",0
    mensajeError BYTE "No se pudo guardar el archivo",0

.code
main PROC
    ; 1. Crear archivo txt.
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile       ; devuelve el handle en EAX

    cmp eax, INVALID_HANDLE_VALUE   ; si falló, EAX = INVALID_HANDLE_VALUE
    je error

    mov archivoHandle, eax

    ; 2. Escribir caracteres en archivo txt.
    mov eax, archivoHandle      ; EAX = handle
    mov edx, OFFSET texto       ; EDX = texto a escribir
    mov ecx, SIZEOF texto - 1   ; ECX = bytes a escribir (sin el 0 final)
    call WriteToFile            ; devuelve en EAX los bytes escritos

    cmp eax, SIZEOF texto - 1   ; ¿se escribieron todos?
    jne errorEscritura

    ; 3. Cerrar archivo txt
    mov eax, archivoHandle
    call CloseFile

    test eax, eax               ; EAX = 0 indica que no se pudo cerrar
    jz error

    mov edx, OFFSET mensajeExito
    call WriteString
    call Crlf
    jmp fin

errorEscritura:                 ; si falló la escritura, se cierra el archivo igual
    mov eax, archivoHandle
    call CloseFile
error:
    mov edx, OFFSET mensajeError
    call WriteString
    call Crlf
fin:
    exit

main ENDP

END main
