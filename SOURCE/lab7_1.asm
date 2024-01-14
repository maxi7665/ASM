.MODEL SMALL
.STACK 256
.DATA
	WORKTEXT DB 'Our Native Town with Happy People', 13, 10, '$'
	strlen equ ($ - WORKTEXT) - 3
.CODE

Start:
	MOV AX , @DATA ; загрузка адреса сегмента данных
	MOV DS , AX
	
	XOR AX , AX	
	LEA BX , WORKTEXT
	MOV CX , strlen
	
	LEA DX, WORKTEXT	
	MOV AH, 09h ; вывод строки на консоль
	INT 21h
	
	CYCLE:
		MOV AH , [BX] ; загрузка кода текущего символа  в AH
		
		CMP AH, 020h ; сравнение с ASCII ' ' 
		JNE SKIP ; не ' ' - пропуск
		CALL ToExclamation ; равно ' '  - замена на '!'
		SKIP:
		
		CMP AH , 41h ; сравнение с ASCII 'A'		
		JB NEXT ; меньше - следующая итерация
		
		CMP AH , 5Ah ; сравнение с ASCII 'Z'
		JA NEXT ; больше - следующая итерация
		
		CALL ToUpperCase ; подошло под оба условия - преобразование к верхнему регистру
	
	NEXT:
		INC BX ; увеличение позиции символа
		LOOP CYCLE; cx --; если cx == 0 - окончание цикла
		
		LEA DX, WORKTEXT		
		MOV AH, 09h ; вывод строки на консоль
		INT 21h
		
		MOV AX, 4C00h ; завершение программы
		INT 21h
		
	ToUpperCase PROC NEAR
			OR AH , 020h ; выставление 3-го бита кода символа
			MOV [BX] , AH ; обновление символа в строке
		RET		
	ToUpperCase ENDP
	
	ToExclamation PROC NEAR
			MOV AH, 021h ; замена на '!'
			MOV [BX], AH ; обновление символа в строке
		RET
	ToExclamation ENDP
	
END Start