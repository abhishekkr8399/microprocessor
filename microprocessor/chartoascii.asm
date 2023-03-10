CLRSCR MACRO
 MOV AH, 00H
 MOV AL, 02H
 INT 10H
ENDM
SETCURSOR MACRO X, Y
 MOV DL, Y ; Y COORDINATE or COLUMN
 MOV DH, X ; X COORDINATE or ROW
 MOV BH, 00H ; CURRENT PAGE
 MOV AH, 02H
 INT 10H
ENDM
DATA SEGMENT
msg1 db "Enter the Character", 10, 13, "$"
n db ?
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
 MOV AX, DATA
 MOV DS, AX
 LEA DX, msg1
 MOV AH, 09H ; DISPLAY MSG1
 INT 21H
 MOV AH, 01H ; READ CHARACTER
 INT 21H
 MOV n, AL
 CLRSCR
 MOV AL, 02H ; FOR 80 X 25 BW
 SETCURSOR 12, 39
 MOV DL, n
 AND DL, 0F0H ; display 1st digit
 MOV CL, 04H
 SHR DL, CL
 CMP DL, 09H
 JBE L1
 ADD DL, 07H
L1: ADD DL, 30H
 MOV AH, 02H
 INT 21H
 MOV DL, n
 AND DL, 0FH
 CMP DL, 09H ;display 2nd digit
 JBE L2
 ADD DL, 07H
L2: ADD DL, 30H
 MOV AH, 02H
 INT 21H
 MOV AH, 01H ;wait until any key press just like getch in C
 INT 21H
 MOV AH, 4CH
 INT 21H
CODE ENDS
END START