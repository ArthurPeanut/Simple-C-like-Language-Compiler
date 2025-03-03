%MACRO add 0
    POP EAX
    ADD DWORD [ESP], EAX
%ENDMACRO

%MACRO sub 0
    POP EAX
    SUB DWORD [ESP], EAX
%ENDMACRO

%MACRO mul 0
    POP EAX
    MUL DWORD [ESP]
    MOV [ESP], EAX
%ENDMACRO

%MACRO div 0
    XOR EDX, EDX
    POP EBX
    POP EAX
    DIV EBX
    PUSH EAX
%ENDMACRO

%MACRO print 1
    [SECTION .DATA]
        %%STRING:   DB %1, 10, 0
    [SECTION .TEXT]
        PUSH DWORD %%STRING
        CALL PRINT
        SHL EAX, 2
        ADD ESP, EAX
%ENDMACRO

%MACRO exit 1
    MOV EAX, 1
    MOV EBX, %1
    INT 0x80
%ENDMACRO


%MACRO neg 0
    NEG DWORD [ESP]
%ENDMACRO

%MACRO cmpeq 0
    MOV EAX, [ESP+4]
    CMP EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 6
    AND EAX, 0X1
    ADD ESP, 4
    MOV [ESP], EAX
%ENDMACRO

%MACRO cmpne 0
    MOV EAX, [ESP+4]
    CMP EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 6
    AND EAX, 0X1
    XOR EAX, 0X1
    ADD ESP, 4
    MOV [ESP], EAX
%ENDMACRO

%MACRO cmpge 0
    MOV EAX, [ESP+4]
    CMP EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 7
    AND EAX, 0X1
    XOR EAX, 0X1
    ADD ESP, 4
    MOV [ESP], EAX
%ENDMACRO

%MACRO cmplt 0
    MOV EAX, [ESP+4]
    CMP EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 7
    AND EAX, 0X1
    ADD ESP, 4
    MOV [ESP], EAX
%ENDMACRO

%MACRO cmpgt 0
    POP EAX
    CMP EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 7
    AND EAX, 0X1
    MOV [ESP], EAX
%ENDMACRO

%MACRO cmple 0
    POP EAX
    CMP EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 7
    AND EAX, 0X1
    XOR EAX, 0X1
    MOV [ESP], EAX
%ENDMACRO

%MACRO and 0
    POP EAX
    AND EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 6
    AND EAX, 0X1
    XOR EAX, 0X1
    MOV [ESP], EAX
%ENDMACRO

%MACRO or 0
    POP EAX
    OR EAX, [ESP]
    PUSHF
    POP EAX
    SHR EAX, 6
    AND EAX, 0X1
    XOR EAX, 0X1
    MOV [ESP], EAX
%ENDMACRO

%MACRO not 0
    MOV EAX, [ESP]
    OR EAX, EAX
    PUSHF
    POP EAX
    SHR EAX, 6
    AND EAX, 0X1
    MOV [ESP], EAX
%ENDMACRO

%MACRO jz 1
    POP EAX
    OR EAX, EAX
    JZ %1
%ENDMACRO

%MACRO jmp 1
    JMP %1
%ENDMACRO

%MACRO push 1
    PUSH DWORD %1
%ENDMACRO

%MACRO pop 0-1
    %IFIDN %0, 0
        ADD ESP, 4
    %ELSE
        POP DWORD %1
    %ENDIF
%ENDMACRO

%MACRO FUNC 1
    %1
    PUSH EBP
    MOV EBP, ESP
%ENDMACRO

%MACRO ret 0-1
    %IFIDN %0, 1
        %IFIDN %1, ~
            MOV EAX, [ESP]
        %ELSE
            MOV EAX, %1
        %ENDIF
    %ENDIF
    LEAVE
    RET
%ENDMACRO

EXTERN PRINT
GLOBAL _start

[SECTION .TEXT]
_start:
	CALL @main
    PUSH EAX
	exit [ESP]
