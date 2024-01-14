ASSUME CS:Code, DS:Data, SS:Ourstack ;Назначить сегментные ;регистры
Data SEGMENT ;Открыть сегмент данных
    A DB 32 ;Инициализировать
    B DB 0Fh ;переменные A, B, C, D, X
    C DB 80
    D DB 2
    X DW ?
Data ENDS ;Закрыть сегмент данных

Ourstack SEGMENT Stack ;Открыть сегмент стека
    DB 100h DUP (?) ;Отвести под стек 256 байт
Ourstack ENDS ;Закрыть сегмент стека

Code SEGMENT   ;Открыть сегмент кодов
    Start: mov AX, Data ;Инициализировать
    mov DS, AX ;сегментный регистр DS
    xor AX, AX ;Очистить регистр AX
	
	mov AL, B 
	inc AL ; B + 1
	
	mul A ; A *(B + 1)
	
	div C ; (A * (B + 1)) / C
	
	sub AL, D; (A * (B + 1)) / C - D
	
	mov AH, 0 ; очистка остатка от деления
	mov X, AX; результат в переменную X 
	
    mov AX, 4C00h ;Завершить программу
    int 21h ;с помощью DOS
Code ENDS ;Закрыть сегмент кодов
END Start ;Конец исходного модуля
