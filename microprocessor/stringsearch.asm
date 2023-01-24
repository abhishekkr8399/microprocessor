data segment
T db "NMAMIT"
n db $-T
P db "MIT"
m db $-P
len db ?
msg1 db "Sub String Found$"
msg2 db "Sub String Not Found$"
temp db ?
data ends
code segment
assume cs:code, ds:data
start:
 MOV AX, data
 MOV ds, AX
 LEA SI, T
 LEA DI, P
 MOV AL, n ;len=n-m
 SUB AL, m
 MOV len, AL
 MOV CX, 0000H ; i->CX
UP1: CMP CL, len
 JA NOMATCH ;check if i<=n-m
 MOV DX, 0000H ; j->DX
UP2: CMP DL, m
 JAE L1 ;check if j<m
 MOV BX, DX
 MOV AL, [DI][BX]
 MOV temp,AL
 ADD BX, CX
 MOV AL, [SI][BX]
 CMP AL, temp
 JNZ L1
 INC DX
 JMP UP2
L1: CMP DL, m
 JZ MATCH
 INC CX
 JMP UP1
MATCH: LEA DX, msg1
 MOV AH, 09H
 INT 21H
 JMP EXIT
NOMATCH: LEA DX, msg2
 mov ah, 09h
 int 21h
EXIT: MOV AH, 4CH
 INT 21H
CODE ENDS
END start