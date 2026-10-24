; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 14. Captura y almacenamiento de datos numéricos
; Descripción: Captura como texto la cantidad de tarjetas recibidas (1 a 99), la valida, la convierte a número y la suma a la existencia inicial.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Cantidad de tarjetas ESP32 recibidas (1-99): ",0
    errorMsg BYTE "Cantidad invalida. Intente nuevamente.",0
    resultado BYTE "Existencia actual: ",0
    unidades BYTE " unidades",0

    entrada BYTE 10 DUP(0)          ; texto capturado
    bufferNumero BYTE 11 DUP(0)     ; número convertido a cadena para mostrarlo
    temporal BYTE 10 DUP(0)         ; dígitos en orden inverso durante la conversión

    cantidadRecibida DWORD 0
    existenciaInicial DWORD 25
    existenciaActual DWORD 0
    longitud DWORD 0

.code
main PROC

leerCantidad:
    mov edx, OFFSET mensaje
    call WriteString

    mov edx, OFFSET entrada
    mov ecx, SIZEOF entrada - 1
    call ReadString

    mov longitud, eax

    ; Validar que tenga uno o dos caracteres
    cmp eax, 1
    jl cantidadInvalida
    cmp eax, 2
    jg cantidadInvalida

    ; Validar que todos sean digitos
    mov esi, OFFSET entrada
    mov ecx, longitud

validarDigitos:
    mov al, [esi]
    cmp al, '0'
    jb cantidadInvalida
    cmp al, '9'
    ja cantidadInvalida

    inc esi
    loop validarDigitos

    ; Convertir el primer digito
    mov esi, OFFSET entrada
    movzx eax, BYTE PTR [esi]
    sub eax, '0'                ; carácter ASCII -> valor numérico

    ; Si tiene un digito, ya esta convertido
    cmp longitud, 1
    je validarRango

    ; Convertir el segundo digito: número = primero * 10 + segundo
    imul eax, 10
    movzx ebx, BYTE PTR [esi+1]
    sub ebx, '0'
    add eax, ebx

validarRango:
    ; Aceptar solamente cantidades de 1 a 99
    cmp eax, 1
    jl cantidadInvalida
    cmp eax, 99
    jg cantidadInvalida

    ; Guardar la cantidad recibida
    mov cantidadRecibida, eax

    ; Sumar a la existencia inicial
    mov eax, existenciaInicial
    add eax, cantidadRecibida
    mov existenciaActual, eax

    ; Mostrar el resultado
    mov edx, OFFSET resultado
    call WriteString

    mov eax, existenciaActual
    call ConvertirDecimal       ; deja el número como texto en bufferNumero

    mov edx, OFFSET bufferNumero
    call WriteString

    mov edx, OFFSET unidades
    call WriteString
    call Crlf

    exit

cantidadInvalida:               ; entrada incorrecta: avisa y vuelve a pedir
    mov edx, OFFSET errorMsg
    call WriteString
    call Crlf
    jmp leerCantidad

main ENDP

; Convierte el numero de EAX a una cadena decimal.
; El resultado queda en bufferNumero.
ConvertirDecimal PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov ebx, 10
    mov esi, OFFSET temporal
    xor ecx, ecx

    ; Caso especial: numero cero
    cmp eax, 0
    jne dividirNumero

    mov BYTE PTR [esi], '0'
    inc esi
    inc ecx
    jmp copiarNumero

dividirNumero:                  ; cada división entre 10 da un dígito (al revés)
    xor edx, edx
    div ebx

    add dl, '0'
    mov [esi], dl
    inc esi
    inc ecx

    cmp eax, 0
    jne dividirNumero

    ; Invertir los digitos
copiarNumero:
    dec esi
    mov edi, OFFSET bufferNumero

copiarDigito:
    mov al, [esi]
    mov [edi], al
    inc edi
    dec esi
    loop copiarDigito

    mov BYTE PTR [edi], 0

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    ret
ConvertirDecimal ENDP

END main
