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
	
	CYCLE:
		MOV AH , [BX] ; загрузка кода текущего символа  в AH
		
		CMP AH , 61h ; сравнение с ASCII 'a'		
		JB NEXT ; меньше - следующая итерация
		
		CMP AH , 7Ah ; сравнение с ASCII 'z'
		JA NEXT ; больше - следующая итерация
		
		CALL ToUpperCase ; подошло под оба условия - преобразование к верхнему регистру
	
	NEXT:
		INC BX ; увеличение позиции символа
		LOOP CYCLE; cx --; если cx == 0 - окончание цикла
		
		LEA DX, WORKTEXT
		
		MOV AH , 09h ; вывод строки на консоль
		INT 21h
		
		MOV AX, 4C00h ; завершение программы
		INT 21h
		
	ToUpperCase PROC NEAR
			AND AH , 0DFh ; обнуление 3-го бита кода символа
			MOV [ BX ] , AH ; обновление символа в строке
		RET		
	ToUpperCase ENDP
	
END Start