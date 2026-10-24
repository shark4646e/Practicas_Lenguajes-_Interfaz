; Materia: Lenguajes de Interfaz
; Alumno: Gastelum Verduzco Fernando
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 10. Obtención de una cadena decimal
; Descripción: Calcula el avance de una descarga con MUL y DIV y convierte cada resultado a texto decimal dividiendo entre 10, con algoritmo propio sin WriteDec.

INCLUDE Irvine32.inc

.data
    tamanoArchivo DWORD 100000
    bloquesRecibidos DWORD 125
    tamanoBloque DWORD 512

    bytesDescargados DWORD 0
    bytesPendientes DWORD 0
    porcentajeAvance DWORD 0
    gruposCompletos DWORD 0
    residuoGrupos DWORD 0

    buffer BYTE 11 DUP(0)       ; cadena donde se arma el número, hasta 10 dígitos más el 0 final

    msgDescargados BYTE "Bytes descargados: ",0
    msgPendientes BYTE "Bytes pendientes: ",0
    msgPorcentaje BYTE "Porcentaje de avance: ",0
    msgGrupos BYTE "Grupos completos de 1024 bytes: ",0
    msgResiduo BYTE "Residuo del agrupamiento: ",0

.code
main PROC
    ; bytes descargados es igual a bloques recibidos por tamaño del bloque
    mov eax, bloquesRecibidos
    mul tamanoBloque
    mov bytesDescargados, eax

    ; bytes pendientes es igual al tamaño del archivo menos los descargados
    mov ebx, tamanoArchivo
    sub ebx, eax
    mov bytesPendientes, ebx

    ; porcentaje es igual a descargados por 100 entre el tamaño del archivo
    mov eax, bytesDescargados
    mov ebx, 100
    mul ebx
    div tamanoArchivo
    mov porcentajeAvance, eax

    ; grupos de 1024 bytes, cociente en EAX y residuo en EDX
    mov eax, bytesDescargados
    mov edx, 0
    mov ebx, 1024
    div ebx
    mov gruposCompletos, eax
    mov residuoGrupos, edx

    ; Mostrar los resultados. EAX tiene el número y EDX el mensaje
    mov eax, bytesDescargados
    mov edx, OFFSET msgDescargados
    call mostrarNumero

    mov eax, bytesPendientes
    mov edx, OFFSET msgPendientes
    call mostrarNumero

    mov eax, porcentajeAvance
    mov edx, OFFSET msgPorcentaje
    call mostrarNumero

    mov eax, gruposCompletos
    mov edx, OFFSET msgGrupos
    call mostrarNumero

    mov eax, residuoGrupos
    mov edx, OFFSET msgResiduo
    call mostrarNumero

    exit
main ENDP

; Muestra el mensaje de EDX y después el número de EAX convertido a cadena
mostrarNumero PROC
    push eax
    call WriteString
    pop eax

    mov esi, OFFSET buffer      ; ESI indica dónde se escribe la cadena
    call convertirDecimal

    mov edx, OFFSET buffer
    call WriteString
    call Crlf
    ret
mostrarNumero ENDP

; Convierte el número de EAX a texto decimal en la dirección ESI
convertirDecimal PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi

    mov ebx, 10                 ; divisor, base decimal
    mov ecx, 0                  ; ECX cuenta los dígitos obtenidos

extraerDigitos:                 ; divide entre 10, el residuo es el siguiente dígito
    mov edx, 0
    div ebx
    push edx                    ; los dígitos salen al revés, se guardan en la pila
    inc ecx
    cmp eax, 0
    jne extraerDigitos

construirCadena:                ; al sacar de la pila los dígitos quedan en orden
    pop edx
    add dl, '0'                 ; convierte el dígito a su carácter ASCII
    mov [esi], dl
    inc esi
    loop construirCadena

    mov BYTE PTR [esi], 0       ; terminador de cadena

    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
convertirDecimal ENDP

END main
