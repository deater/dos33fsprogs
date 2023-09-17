;
;
; optional color, x1,y1 x2,y2
;
;	HLIN	x1,x2 at y1
;	VLIN	y1,y2 at X1
;	PLOT	x1,y1
;	BOX	x1,y1 to x2,y2
;	CLEAR	-

num_scenes=2

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


