.MODEL SMALL
.STACK 256
.DATA
	МУТЕХТ DB 'Our Native Тоwп ,11th Нарру Реорlе', 13, 10, 'S'
	strlen = ( $ - МУТЕХТ) - 3
. CODE
Start:
	MOV АХ , @DATA
	MOV DS , АХ
	
	XOR АХ , АХ
	LEA ВХ , МУТЕХТ
	MOV СХ , strlen
	
	CorrectHandler:
		MOV АН , [ВХ] ; загрузка кода текущего символа  в AH
		
		СМР АН , 6lh ; сравнение с ASCII 'a'		
		JB MoveCaretCounter ; меньше - следующая итерация
		
		СМР АН , 7Ah ; сравнение с ASCII 'z'
		JA MoveCaretCounter ; больше - следующая итерация
		
		CALL ToUpperCase ; подошло под оба условия - преобразование к верхнему регистру
	
	MoveCaretCounter:
		INC ВХ
		LOOP CorrectHandler
		
		LEA DX, МУТЕХТ
		
		MOV АН , 09h
		INT 21h
		
		MOV АХ , 4C00h
		INT 21h
		
	ToUpperCase PROC NEAR
			AND АН , 0DFh
			MOV [ ВХ ] , АН
		RET
ToUpperCase ENDP
END Start