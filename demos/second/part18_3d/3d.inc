;
;
; optional color, x1,y1 x2,y2
;
;	HLIN	x1,x2 at y1
;	VLIN	y1,y2 at X1
;	PLOT	x1,y1
;	BOX	x1,y1 to x2,y2
;	CLEAR	-

num_scenes=10

frame15:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 35,41

;	.byte	SET_COLOR | RED
;	.byte	HLIN,0,39,2
;	.byte	SET_COLOR | DARK_BLUE
;	.byte	HLIN,0,39,3

;	.byte	SET_COLOR | RED
;	.byte	HLIN,0,39,12
;	.byte	SET_COLOR | DARK_BLUE
;	.byte	HLIN,0,39,13

;	.byte	SET_COLOR | GREEN
;	.byte	BOX,  2,2,3,3		; goes to 6 only top
;	.byte	BOX,  4,3,5,4
;	.byte	BOX,  6,4,7,5
;	.byte	BOX,  8,5,9,6

;	.byte	SET_COLOR | GREEN
;	.byte	VLIN,  2,3,2		; goes to 6 only top
;	.byte	VLIN,  3,4,4
;	.byte	VLIN,  4,5,6
;	.byte	VLIN,  5,6,8


;	.byte	SET_COLOR | GREEN
;	.byte	BOX,  2,2,10,12		; goes to 6 only top
;	.byte	BOX, 12,3,20,12
;	.byte	BOX, 22,2,30,13		; goes to 6 full
;	.byte	BOX, 32,3,39,13





	.byte	END
frame16:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 27,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 28, 6, 35,34
	.byte	SET_COLOR | GREY1
	.byte	BOX, 28, 19, 33, 21
	.byte	BOX, 28, 35, 35, 38
	.byte	HLIN, 28, 31, 18
	.byte	HLIN, 28, 30, 34
	.byte	HLIN, 33, 35, 39
	.byte	SET_COLOR | RED
	.byte	HLIN, 28, 32, 21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN, 28, 33, 22
	.byte	HLIN, 28, 30, 23
	.byte	END
frame17:
	.byte	SET_COLOR | BLACK					; 1
	.byte	CLEAR							; 2
	.byte	SET_COLOR | WHITE					; 3
	.byte	BOX, 4, 6, 23,41					; 8
	.byte	SET_COLOR | BROWN					; 9
	.byte	BOX, 24, 6, 35,36					; 14
	.byte	SET_COLOR | GREY1					; 15
	.byte	BOX, 26, 20, 32, 21					; 20
	.byte	BOX, 24, 36, 30, 40					; 25
	.byte	BOX, 29, 37, 35, 41					; 30
	.byte	HLIN, 27, 31, 19					; 34
	.byte	SET_COLOR | RED						; 35
	.byte	HLIN, 26, 32, 22					; 39
	.byte	SET_COLOR | MEDIUM_BLUE					; 40
	.byte	BOX, 33, 11, 35, 17					; 45
	.byte	BOX, 33, 25, 35, 30					; 50
	.byte	SET_COLOR | LIGHT_BLUE					; 51
	.byte	HLIN, 26, 32, 23					; 55
	.byte	HLIN, 27, 31, 24					; 59
	.byte END							; 60
frame18:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 18,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 19, 6, 35,38
	.byte	SET_COLOR | GREY1
	.byte	BOX, 27, 21, 34, 23
	.byte	BOX, 19, 39, 35, 41
	.byte	HLIN, 28, 31, 20
	.byte	HLIN, 19, 23, 37
	.byte	HLIN, 19, 28, 38
	.byte	SET_COLOR | RED
	.byte	HLIN, 27, 34, 24
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 29, 11, 32, 18
	.byte	BOX, 29, 27, 32, 32 
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN, 27, 34, 25
	.byte	HLIN, 28, 33, 26
	.byte END
frame19:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 12,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 13, 6, 35,40
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 25, 11, 28, 18
	.byte	BOX, 33, 11, 35, 18 
	.byte	BOX, 25, 26, 28, 32
	.byte	BOX, 33, 29, 35, 33 
	.byte	SET_COLOR | GREY1
	.byte	BOX, 29, 21, 35, 24
	.byte	HLIN, 29, 34, 20
	.byte	HLIN, 13, 18, 38
	.byte	HLIN, 13, 25, 39
	.byte	HLIN, 13, 33, 40
	.byte	HLIN, 13, 35, 41
	.byte	SET_COLOR | RED
	.byte	HLIN, 29, 35, 25
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN, 28, 35, 26
	.byte	HLIN, 29, 35, 27
	.byte	HLIN, 30, 35, 28
	.byte	VLIN, 21, 26, 28
	.byte END

frame20:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4, 6, 35,41
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 18, 9, 21, 17
	.byte	BOX, 26, 10, 29, 17 
	.byte	BOX, 34, 10, 35, 17
	.byte	BOX, 18, 26, 21, 33 
	.byte	BOX, 25, 26, 29, 33 
	.byte	BOX, 34, 30, 35, 34
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 31, 21, 35, 27
	.byte	HLIN, 32, 35, 20
	.byte	HLIN, 34, 35, 29
	.byte	SET_COLOR | GREY1
	.byte	BOX, 34, 22, 35, 28
	.byte	HLIN, 32, 35, 24
	.byte	HLIN, 4,6,39
	.byte	HLIN, 4,19,40
	.byte	HLIN, 4,29,41
	.byte	SET_COLOR | RED
	.byte	HLIN, 34, 35, 26
	.byte	SET_COLOR | ORANGE
	.byte	PLOT, 33, 25
	.byte END

frame21:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4, 6, 35, 41
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 7,  7, 11, 16
	.byte	BOX, 16, 8, 20, 16
	.byte	BOX, 25, 9, 28, 17
	.byte	BOX, 33, 9, 35, 17 
	.byte	BOX, 7, 25, 11, 34
	.byte	BOX, 16,26, 20, 34
	.byte	BOX, 25,26, 28, 34
	.byte	BOX, 33,28, 35, 33
	.byte	SET_COLOR | GREY1
	.byte	BOX, 32,20,35,21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 31, 22, 35,26
	.byte	HLIN, 33, 35, 21
	.byte	HLIN, 32, 35, 27
	.byte	SET_COLOR | GREY1
	.byte	BOX, 33,23,35,24
	.byte	SET_COLOR | ORANGE
	.byte	VLIN, 24,26,35
	.byte END

frame22:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | GREY1
	.byte	BOX, 4,6,31,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 32, 6, 35, 32
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 4,  6,  5, 14
	.byte	BOX, 12, 7, 15, 15
	.byte	BOX, 20, 8, 23, 16
	.byte	BOX, 4, 25,  5, 35 
	.byte	BOX, 11,25, 15, 34
	.byte	BOX, 20,25, 22, 33
	.byte	SET_COLOR | GREY1
	.byte	BOX, 32,22,35,25
	.byte	BOX, 32,32,33,41
	.byte	BOX, 34,33,35,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 30,20,33,21
	.byte	HLIN, 30,31,19
	.byte	BOX, 30,24,31,26
	.byte	PLOT, 32,25
	.byte	SET_COLOR | ORANGE
	.byte	HLIN, 33,34,24
	.byte	PLOT, 33,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN, 19,26,29
	.byte	HLIN, 30,32,22
	.byte	HLIN, 30,31,23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	PLOT, 31,22
	.byte	SET_COLOR | BLACK
	.byte	BOX, 31,34, 33,35
	.byte	BOX, 32,35, 35,36
	.byte	HLIN, 34,35,37
	.byte END


frame23:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | GREY1
	.byte	BOX, 4,6,18,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 19, 6, 34, 35
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 7, 6, 9, 15
	.byte	BOX, 6,26, 9, 34
	.byte	SET_COLOR | GREY1
	.byte	VLIN, 20,41,19
	.byte	BOX, 20,32,23,41
	.byte	BOX, 24,33,25,41
	.byte	BOX, 26,34,29,41
	.byte	BOX, 30,35,32,41
	.byte	BOX, 33,36,35,41
	.byte	VLIN, 26,35,34
	.byte	VLIN, 6,35,35
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 24,19,25,24
	.byte	VLIN, 21,22,26
	.byte	BOX, 31,20,33,25
	.byte	PLOT, 32,19
	.byte	SET_COLOR | GREY1
	.byte	VLIN, 17,23,24
	.byte	BOX, 27,21, 31,23
	.byte	PLOT, 24,17
	.byte	PLOT, 31,20
	.byte	SET_COLOR | ORANGE
	.byte	HLIN, 28,29,22
	.byte	SET_COLOR | RED
	.byte	PLOT, 24,21
	.byte	HLIN, 32,33,23
	.byte	SET_COLOR | BLACK
	.byte	BOX, 18,33,20,35
	.byte	BOX, 20,34,22,36
	.byte	BOX, 23,35,25,37
	.byte	BOX, 25,36,27,38
	.byte	BOX, 27,37,30,39
	.byte	BOX, 29,38,32,40
	.byte	BOX, 31,39,35,41
	.byte END

frame24:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,10,41
	.byte	BOX, 28,6,35,24
	.byte	BOX, 27,25,35,35
	.byte	SET_COLOR | BROWN
	.byte	BOX, 11,6,27,18
	.byte	BOX, 11,19,26,31
	.byte	BOX, 15,32,26,34
	.byte	HLIN,25,26,35
	.byte	VLIN,6,15,34
	.byte	VLIN,16,32,33
	.byte	SET_COLOR | GREY1
	.byte	HLIN,11,14,32
	.byte	HLIN,11,18,33
	.byte	HLIN,14,21,34
	.byte	HLIN,17,24,35
	.byte	HLIN,19,34,36
	.byte	HLIN,22,34,37
	.byte	HLIN,25,32,38
	.byte	HLIN,28,31,39
	.byte	HLIN,11,13,37
	.byte	HLIN,11,16,38
	.byte	HLIN,11,18,39
	.byte	HLIN,11,21,40
	.byte	HLIN,11,22,41
	.byte	HLIN,29,35,35
	.byte	HLIN,31,35,34
	.byte	HLIN,32,35,33
	.byte	HLIN,34,35,32
	.byte	BOX,20,18,22,22
	.byte	BOX,23,20,27,21
	.byte	HLIN,20,21,17
	.byte	PLOT,26,19
	.byte	PLOT,27,23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,20,22,23
	.byte	HLIN,23,25,22
	.byte	HLIN,27,28,24
	.byte	VLIN,19,21,22
	.byte	VLIN,20,23,28
	.byte	PLOT,27,19
	.byte	PLOT,26,23
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,24,21
	.byte	SET_COLOR | RED
	.byte	PLOT, 28,22
	.byte	HLIN, 20,21,20
	.byte	SET_COLOR | DARK_BLUE
	.byte	HLIN,26,27,22
	.byte END





