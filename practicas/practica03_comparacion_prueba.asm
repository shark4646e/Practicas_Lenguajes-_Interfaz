; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Comparación de datos con las banderas EFLAGS
; Descripción: Compara valores con CMP y TEST y muestra con DumpRegs las banderas ZF, SF, CF y OF.

INCLUDE Irvine32.inc

.data

main PROC

    ; Caso 1, bandera ZF, se enciende cuando los dos valores son iguales

    mov eax, 10h            ; carga en EAX el valor que se va a comparar

    cmp eax, 10h            ; compara EAX con 10h, resta sin guardar el resultado
    call DumpRegs           ; muestra las banderas, ZF debe valer 1 porque son iguales

    ; Caso 2, bandera SF, se enciende cuando el resultado es negativo

    mov eax, 0              ; pone en cero el registro EAX
    mov ebx, 0              ; pone en cero el registro EBX

    mov al, -5              ; carga menos 5 en AL
    mov bl, 1               ; carga 1 en BL
    cmp al, bl              ; compara AL con BL, menos 5 menos 1 da menos 6
    call DumpRegs           ; muestra las banderas, SF debe valer 1 porque el resultado es negativo

    ; Caso 3, bandera CF, se enciende cuando hay un préstamo en la resta sin signo

    mov aex, 0              ; pone en cero el registro EAX
    mov ebx, 0              ; pone en cero el registro EBX

    mov al, 5               ; carga 5 en AL
    mov bl, 10              ; carga 10 en BL

    cmp al, bl              ; compara AL con BL, 5 es menor que 10
    call DumpRegs           ; muestra las banderas, CF debe valer 1

    ; Caso 4, bandera OF, se enciende cuando el resultado con signo no cabe en 8 bits

    mov aex, 0              ; pone en cero el registro EAX
    mov ebx, 0              ; pone en cero el registro EBX

    mov al, -128            ; carga menos 128 en AL, el menor valor de 8 bits con signo
    mov bl, 1               ; carga 1 en BL

    cmp al, bl              ; compara AL con BL, menos 128 menos 1 se sale del rango
    call DumpRegs           ; muestra las banderas, OF debe valer 1

    ; Caso 5, instrucción TEST, hace un AND sin guardar el resultado

    mov eax, 0              ; pone en cero el registro EAX
    mov eax, 5              ; carga 5 en EAX, en binario 0101
    test eax, 1             ; prueba el bit 0 de EAX con un AND con 1
    call DumpRegs           ; muestra las banderas, ZF debe valer 0 porque el bit 0 está encendido

exit

main END
END main


