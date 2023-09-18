;
;
; optional color, x1,y1 x2,y2
;
;	HLIN	x1,x2 at y1
;	VLIN	y1,y2 at X1
;	PLOT	x1,y1
;	BOX	x1,y1 to x2,y2
;	CLEAR	-

num_scenes=5

frame15:
	.byte	SET_COLOR | BLACK
	.byte	CLEAR
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 35,41
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
	.byte	HLIN, 13, 35, 41
	.byte	SET_COLOR | RED
	.byte	HLIN, 29, 35, 25
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN, 28, 35, 26
	.byte	HLIN, 29, 35, 27
	.byte	HLIN, 30, 35, 38
	.byte	VLIN, 21, 26, 28
	.byte END
