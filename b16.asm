TITLE Project

.model small
.stack 100h
.386

loopCount = 20;

.data
buffer BYTE loopCount + 1 DUP(0)
buffer2 BYTE loopCount + 1 DUP(0)
buffer4 BYTE "Error"
Count BYTE 0
.code

main PROC
mov ax, @data
mov ds, ax

mov ecx, loopCount
call Password
call Crlf

mov ecx, SIZEOF buffer
call Error

cmp count,13
jne L2

mov cx,SIZEOF buffer
call Prime

mov cx, SIZEOF buffer2
mov dx, OFFSET buffer2
jmp L3

L2:
	mov cx, SIZEOF buffer4
	mov dx, OFFSET buffer4

L3:
	call WriteString
	call Crlf
.exit

main ENDP

Password PROC

mov esi, 0
L1:
	mov ah, 7
	int 21h
	cmp al, 0dh
	je L4

	cmp al, "-"
	je L2
	mov buffer[esi], al

	mov ah, 2
	mov dl, "*"
	int 21h
	jmp L3

L2 :
	mov ah, 2
	mov dl, "-"
	int 21h
	jmp L1

L3:
	inc esi
	loop L1

L4:
	ret
Password ENDP

Prime PROC
mov esi,0
mov ebx,0
L1:
	mov al, buffer[esi]
	cmp al, "2"
	je L2
	cmp al, "3"
	je L2
	cmp al, "5"
	je L2
	cmp al, "7"
	jne L3

L2 :
	mov [buffer2+ebx], al
	inc ebx

L3:
	inc esi
	loop L1
ret
Prime ENDP

Error PROC

mov esi, 0
mov ebx, 0
mov count,0

L1:
	mov al, buffer[esi]
	cmp al, 39h
	ja L2
	cmp al, 30h
	jb L2

	inc ebx

L2 :
	inc esi
	loop L1
	mov count,bl
ret
Error ENDP

Crlf PROC
mov ah, 2
mov dl, 0ah
int 21h

mov ah, 2
mov dl, 0dh
int 21h
ret
Crlf ENDP

WriteString PROC
mov ah, 40h
mov bx, 1
int 21h
ret
WriteString ENDP

END main