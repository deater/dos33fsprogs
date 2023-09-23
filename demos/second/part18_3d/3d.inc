;
;
; optional color, x1,y1 x2,y2
;
;	HLIN	x1,x2 at y1
;	VLIN	y1,y2 at X1
;	PLOT	x1,y1
;	BOX	x1,y1 to x2,y2
;	CLEAR	-


; Optimization at frame 45:
; 4543 = original
; 4490 = move clear to common code
; 4427 = add right/left hlin_add variants


frame15:
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
	.byte	HLIN_ADD, 28, 30	; 23
	.byte	END
frame17:
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
	.byte	HLIN_ADD, 27, 31	; 24				; 58
	.byte END							; 59
frame18:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 18,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 19, 6, 35,38
	.byte	SET_COLOR | GREY1
	.byte	BOX, 27, 21, 34, 23
	.byte	BOX, 19, 39, 35, 41
	.byte	HLIN, 28, 31, 20
	.byte	HLIN, 19, 23, 37
	.byte	HLIN_ADD, 19, 28	; 38
	.byte	SET_COLOR | RED
	.byte	HLIN, 27, 34, 24
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 29, 11, 32, 18
	.byte	BOX, 29, 27, 32, 32 
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN, 27, 34, 25
	.byte	HLIN_ADD, 28, 33	; 26
	.byte END
frame19:
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
	.byte	HLIN_ADD, 13, 25	; 39
	.byte	HLIN_ADD, 13, 33	; 40
	.byte	HLIN_ADD, 13, 35	; 41
	.byte	SET_COLOR | RED
	.byte	HLIN, 29, 35, 25
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN_ADD, 28, 35	; 26
	.byte	HLIN_ADD, 29, 35	; 27
	.byte	HLIN_ADD, 30, 35	; 28
	.byte	VLIN, 21, 26, 28
	.byte END

frame20:
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
	.byte	HLIN_ADD, 4,19		; 40
	.byte	HLIN_ADD, 4,29		; 41
	.byte	SET_COLOR | RED
	.byte	HLIN, 34, 35, 26
	.byte	SET_COLOR | ORANGE
	.byte	PLOT, 33, 25
	.byte END

frame21:
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
	.byte	HLIN_ADD, 30,31		; 23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	PLOT, 31,22
	.byte	SET_COLOR | BLACK
	.byte	BOX, 31,34, 33,35
	.byte	BOX, 32,35, 35,36
	.byte	HLIN, 34,35,37
	.byte END


frame23:
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
	.byte	HLIN_ADD,11,18	; 33
	.byte	HLIN_ADD,14,21	; 34
	.byte	HLIN_ADD,17,24	; 35
	.byte	HLIN_ADD,19,34	; 36
	.byte	HLIN_ADD,22,34	; 37
	.byte	HLIN_ADD,25,32	; 38
	.byte	HLIN_ADD,28,31	; 39
	.byte	HLIN,11,13,37
	.byte	HLIN_ADD,11,16	; 38
	.byte	HLIN_ADD,11,18	; 39
	.byte	HLIN_ADD,11,21	; 40
	.byte	HLIN_ADD,11,22	; 41
	.byte	HLIN,34,35,32
	.byte	HLIN_ADD,32,35	; 33
	.byte	HLIN_ADD,31,35	; 34
	.byte	HLIN,29,35,35
	.byte	BOX,20,18,22,22
	.byte	BOX,23,20,27,21
	.byte	HLIN,20,21,17
	.byte	PLOT,26,19
	.byte	PLOT,27,23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,23,25,22
	.byte	HLIN_ADD,20,22	; 23
	.byte	HLIN_ADD,27,28	; 24
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

frame25:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,7,41
	.byte	BOX, 25,6,35,33
	.byte	BOX, 25,34,27,36
	.byte	SET_COLOR | BROWN
	.byte	BOX, 8,6,24,34
	.byte	BOX, 20,35,24,36
	.byte	VLIN,6,24,31
	.byte	VLIN,25,32,30
	.byte	SET_COLOR | GREY1
	.byte	HLIN,8,11,33
	.byte	HLIN_ADD,8,15	; 34
	.byte	HLIN_ADD,10,19	; 35
	.byte	HLIN_ADD,14,22	; 36
	.byte	HLIN_ADD,17,32	; 37
	.byte	HLIN_ADD,20,31	; 38
	.byte	HLIN_ADD,23,30	; 39
	.byte	HLIN_ADD,26,29	; 40
	.byte	HLIN,8,9,38
	.byte	HLIN_ADD,8,11	; 39
	.byte	HLIN_ADD,8,14	; 40
	.byte	HLIN_ADD,8,16	; 41
	.byte	HLIN,34,35,30		; right=35
	.byte	HLIN_ADD_RSAME,33	; 31
	.byte	HLIN_ADD_RSAME,31	; 32
	.byte	HLIN_ADD_RSAME,30	; 33
	.byte	HLIN_ADD,28,34		; 34
	.byte	HLIN_ADD,27,33		; 35
	.byte	HLIN_ADD,26,32		; 36
	.byte	PLOT,35,29
	.byte	BOX,17,18,19,21
	.byte	BOX,22,19,24,21
	.byte	BOX,23,23,24,25
	.byte	HLIN,20,21,20
	.byte	PLOT,20,22
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,18,22,19,23
	.byte	BOX,21,22,22,23
	.byte	VLIN,20,23,25
	.byte	PLOT,17,22
	.byte	PLOT,20,21
	.byte	PLOT,23,21
	.byte	HLIN,23,24,22
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,22,22
	.byte	HLIN,21,22,21
	.byte	SET_COLOR | RED
	.byte	PLOT, 25,22
	.byte	PLOT, 19,21
	.byte	HLIN, 17,18,20
	.byte END

frame26:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,5,41
	.byte	BOX, 24,6,34,34
	.byte	BOX, 24,30,32,37
	.byte	SET_COLOR | BROWN
	.byte	BOX, 6,6,24,15
	.byte	BOX, 6,16,23,35
	.byte	HLIN,20,23,36
	.byte	PLOT,23,37
	.byte	VLIN,6,32,30
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,6,26,35
	.byte	SET_COLOR | GREY1
	.byte	HLIN,6,7,33
	.byte	HLIN_ADD,6,11	; 34
	.byte	HLIN_ADD,6,15	; 35
	.byte	HLIN_ADD,9,19	; 36
	.byte	HLIN_ADD,12,22	; 37
	.byte	HLIN_ADD,15,31	; 38
	.byte	HLIN_ADD,18,30	; 39
	.byte	HLIN_ADD,22,29	; 40
	.byte	HLIN_ADD,25,29	; 41
	.byte	PLOT,6,39
	.byte	HLIN_ADD,6,9	; 40
	.byte	HLIN_ADD,6,11	; 41
	.byte	PLOT,35,29
	.byte	HLIN_ADD,33,35	; 30 right=35
	.byte	HLIN_ADD_RSAME,32	; 31
	.byte	HLIN_ADD_RSAME,31	; 32
	.byte	HLIN_ADD,30,34		; 33
	.byte	HLIN_ADD,28,34		; 34
	.byte	HLIN_ADD,27,33		; 35
	.byte	HLIN_ADD,26,32		; 36
	.byte	HLIN_ADD,25,32		; 37
	.byte	BOX,14,19,17,22
	.byte	HLIN,15,16,23
	.byte	BOX,18,21,19,23
	.byte	HLIN,19,22,24
	.byte	PLOT,22,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,20,20,21,22
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,20,24,17
	.byte	HLIN,20,21,23
	.byte	HLIN_ADD,15,17	; 24
	.byte	HLIN_ADD,20,21	; 25
	.byte	HLIN,15,16,18
	.byte	VLIN,21,22,22
	.byte	SET_COLOR | GREY1
	.byte	PLOT,20,22
	.byte	PLOT,17,22
	.byte	SET_COLOR | ORANGE
	.byte	HLIN,18,19,22
	.byte	SET_COLOR | RED
	.byte	HLIN, 14,16,21
	.byte END

frame27:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 25,6,34,30
	.byte	BOX, 25,31,32,38
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,24,36
	.byte	BOX, 18,37,24,39
	.byte	VLIN,6,33,30
	.byte	SET_COLOR | WHITE
	.byte	VLIN,19,30,4
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX, 15,21,17,23
	.byte	VLIN,6,27,35
	.byte	SET_COLOR | GREY1
	.byte	PLOT,4,41
	.byte	PLOT,35,28
	.byte	PLOT,35,30
	.byte	VLIN,31,33,4
	.byte	HLIN,4,7,34
	.byte	HLIN_ADD,4,10	; 35
	.byte	HLIN_ADD,4,14	; 36
	.byte	HLIN_ADD,6,17	; 37
	.byte	HLIN_ADD,9,20	; 38
	.byte	HLIN_ADD,12,23	; 39
	.byte	HLIN_ADD,16,31	; 40
	.byte	HLIN_ADD,18,31	; 41
	.byte	HLIN,33,35,31		; right=35
	.byte	HLIN_ADD_RSAME,32	; 32
	.byte	HLIN_ADD_RSAME,31	; 33
	.byte	HLIN_ADD_RSAME,30	; 34
	.byte	HLIN_ADD,29,34	; 35
	.byte	HLIN_ADD,28,34	; 36
	.byte	HLIN_ADD,27,33	; 37
	.byte	HLIN_ADD,26,32	; 38
	.byte	HLIN_ADD,25,32	; 39
	.byte	BOX,11,19,13,23
	.byte	VLIN,20,21,10
	.byte	HLIN,15,18,25
	.byte	HLIN_ADD,16,17	; 26
	.byte	VLIN,22,25,18
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,14,15,22
	.byte	HLIN_ADD,10,12	; 23
	.byte	HLIN_ADD,10,17	; 24
	.byte	HLIN_ADD,11,12	; 25
	.byte	PLOT,16,23
	.byte	SET_COLOR | ORANGE
	.byte	HLIN,14,15,23
	.byte	SET_COLOR | RED
	.byte	HLIN, 10,12,22
	.byte END

frame28:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 26,6,35,25
	.byte	BOX, 25,26,35,40
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,25,25
	.byte	BOX, 5,26,24,37
	.byte	BOX, 17,38,24,40
	.byte	VLIN,6,19,32
	.byte	VLIN,20,34,31
	.byte	SET_COLOR | WHITE
	.byte	VLIN,19,30,4
	.byte	SET_COLOR | BLACK
	.byte	PLOT,35,40
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX, 7,21,8,22
	.byte	BOX, 12,22,13,24
	.byte	SET_COLOR | GREY1
	.byte	VLIN,31,34,4
	.byte	HLIN,4,7,35
	.byte	HLIN_ADD,4,10	; 36
	.byte	HLIN_ADD,4,13	; 37
	.byte	HLIN_ADD,6,16	; 38
	.byte	HLIN_ADD,8,19	; 39
	.byte	HLIN_ADD,11,22	; 40
	.byte	HLIN_ADD,13,33	; 41
	.byte	PLOT,35,31
	.byte	HLIN_ADD,34,35		; 32 right=35
	.byte	HLIN_ADD_RSAME,33	; 33
	.byte	HLIN_ADD_RSAME,31	; 34
	.byte	HLIN_ADD_RSAME,31	; 35
	.byte	HLIN_ADD_RSAME,30	; 36
	.byte	HLIN_ADD_RSAME,29	; 37
	.byte	HLIN_ADD_RSAME,28	; 38
	.byte	HLIN_ADD_RSAME,27	; 39
	.byte	HLIN_ADD,26,34	; 40
	.byte	BOX,10,23,12,25
	.byte	HLIN,7,8,20
	.byte	HLIN,7,8,24
	.byte	HLIN,12,13,26
	.byte	PLOT,9,21
	.byte	PLOT,13,27
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,7,8,25
	.byte	VLIN,22,24,9
	.byte	VLIN,23,27,14
	.byte	PLOT,13,25
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,11,24
	.byte	SET_COLOR | RED
	.byte	HLIN, 7,8,23
	.byte	PLOT,7,22
	.byte END

frame29:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 27,6,35,41
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,26,38
	.byte	BOX,17,39,26,41
	.byte	VLIN,6,22,34
	.byte	VLIN,23,34,33
	.byte	SET_COLOR | WHITE
	.byte	VLIN,18,30,4
	.byte	SET_COLOR | GREY1
	.byte	VLIN,31,34,4
	.byte	HLIN,4,5,35		; left 4
	.byte	HLIN_ADD_LSAME,8	; 36
	.byte	HLIN_ADD_LSAME,10	; 37
	.byte	HLIN_ADD_LSAME,13	; 38
	.byte	HLIN_ADD,5,16		; 39
	.byte	HLIN_ADD,8,19		; 40
	.byte	HLIN_ADD,10,21		; 41
	.byte	PLOT,35,34
	.byte	HLIN,33,35,35		; right 35
	.byte	HLIN_ADD_RSAME,33	; 36
	.byte	HLIN_ADD_RSAME,32	; 37
	.byte	HLIN_ADD_RSAME,31	; 38
	.byte	HLIN_ADD_RSAME,30	; 39
	.byte	HLIN_ADD_RSAME,28	; 40
	.byte	HLIN_ADD_RSAME,28	; 41
	.byte	BOX,6,23,8,25
	.byte	VLIN,21,27,4
	.byte	VLIN,24,25,5
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,22,23,5
	.byte	PLOT,9,23
	.byte	PLOT,8,28
	.byte	HLIN,9,10,24
	.byte	HLIN_ADD,9,10	; 25
	.byte	HLIN_ADD,6,9	; 26
	.byte	HLIN_ADD,8,10	; 27
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,6,24
	.byte	HLIN_ADD,6,7
	.byte	SET_COLOR | RED
	.byte	PLOT,10,26
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,23,24,8
	.byte END

frame30:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 28,6,35,41
	.byte	BOX, 4,17,5,31
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,28,16
	.byte	BOX, 5,17,28,18
	.byte	BOX, 6,19,27,40
	.byte	HLIN, 19,27,41
	.byte	SET_COLOR | GREY1
	.byte	BOX,4,32,5,39
	.byte	HLIN,6,7,36		; left 6
	.byte	HLIN_ADD_LSAME,9	; 37
	.byte	HLIN_ADD_LSAME,12	; 38
	.byte	HLIN_ADD_LSAME,14	; 39
	.byte	HLIN_ADD_LSAME,16	; 40
	.byte	HLIN_ADD,7,18	; 41
	.byte	PLOT,35,38
	.byte	HLIN_ADD,34,35		; 39 right 35
	.byte	HLIN_ADD_RSAME,33	; 40
	.byte	HLIN_ADD_RSAME,32	; 41
	.byte	BOX,4,25,5,27
	.byte	PLOT,5,24
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,5,28,6,29
	.byte	VLIN,24,26,6
	.byte	PLOT,4,26
	.byte	PLOT,5,25
	.byte	SET_COLOR | RED
	.byte	PLOT,6,27
	.byte END

frame31:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,30,39
	.byte	BOX, 16,40,30,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 31,6,35,41
	.byte	BOX, 4,17,6,18
	.byte	BOX, 4,19,7,22
	.byte	SET_COLOR | GREY1
	.byte	BOX,4,23,7,39
	.byte	BOX,4,37,10,39
	.byte	HLIN,8,10,37
	.byte	HLIN_ADD,8,12	; 38
	.byte	HLIN_ADD,8,14	; 39
	.byte	HLIN_ADD,5,15	; 40
	.byte	HLIN_ADD,7,17	; 41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,25,26,4
	.byte	SET_COLOR | RED
	.byte	PLOT,4,27
	.byte	SET_COLOR | WHITE
	.byte	VLIN,28,29,4
	.byte END

frame32:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,33,39
	.byte	BOX, 16,40,33,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 34,6,35,41
	.byte	BOX, 6,16,8,17
	.byte	BOX, 5,18,9,19
	.byte	BOX, 4,20,9,21
	.byte	PLOT,5,17
	.byte	SET_COLOR | GREY1
	.byte	BOX,4,22,9,39
	.byte	BOX,4,22,9,39
	.byte	PLOT,10,37
	.byte	HLIN_ADD,10,12
	.byte	HLIN_ADD,10,14
	.byte	HLIN_ADD,6,15
	.byte	HLIN_ADD,7,16
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,25,29,4
	.byte	SET_COLOR | RED
	.byte	PLOT,4,28
	.byte END

frame33:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,32
	.byte	BOX, 13,33,35,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 8,16,11,18
	.byte	HLIN,8,12,19
	.byte	BOX, 7,20,12,21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,7,22,12,33
	.byte	BOX,4,26,5,27
	.byte	PLOT,4,30
	.byte	SET_COLOR | GREY1
	.byte	PLOT,4,31
	.byte	HLIN,4,5,32
	.byte	HLIN_ADD,4,6	; 33
	.byte	HLIN,9,12,33
	.byte	BOX,4,34,12,37
	.byte	HLIN,5,14,38
	.byte	HLIN_ADD,6,15	; 39
	.byte	HLIN_ADD,7,17	; 40
	.byte	HLIN_ADD,8,17	; 41
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,5,6
	.byte	VLIN,11,16,5
	.byte	VLIN,22,25,5
	.byte	SET_COLOR | RED
	.byte	HLIN,4,5,28
	.byte	SET_COLOR | WHITE
	.byte	HLIN,4,5,29
	.byte END

frame34:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,31
	.byte	BOX, 16,32,35,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 11,16,14,19
	.byte	BOX, 10,20,15,21
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,7,6
	.byte	VLIN,11,16,8
	.byte	VLIN,22,25,8
	.byte	VLIN,6,7,5
	.byte	VLIN,12,16,6
	.byte	VLIN,21,25,6
	.byte	VLIN,13,16,4
	.byte	VLIN,21,22,4
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,10,22,15,32
	.byte	VLIN,39,41,4
	.byte	BOX,5,26,7,29
	.byte	PLOT,4,23
	.byte	HLIN_ADD,4,5	; 24
	.byte	HLIN_ADD,4,5	; 25
	.byte	HLIN_ADD,5,8	; 26
	.byte	SET_COLOR | GREY1
	.byte	VLIN,28,29,4
	.byte	HLIN,4,7,30
	.byte	HLIN_ADD,4,8		; 31
	.byte	HLIN_ADD,4,9		; 32
	.byte	HLIN_ADD,4,15		; 33 right 15
	.byte	HLIN_ADD_RSAME,5	; 34
	.byte	HLIN_ADD_RSAME,5	; 35
	.byte	HLIN_ADD_RSAME,6	; 36
	.byte	HLIN_ADD_RSAME,6	; 37
	.byte	HLIN_ADD_RSAME,7	; 38
	.byte	HLIN_ADD,7,16		; 39
	.byte	HLIN_ADD,8,17		; 40
	.byte	HLIN_ADD,9,18		; 41
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,25,27,4
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,4,26
	.byte	SET_COLOR | RED
	.byte	HLIN,6,8,27
	.byte	SET_COLOR | WHITE
	.byte	HLIN,6,8,28
	.byte END

frame35:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 7,6,18,33
	.byte	BOX, 19,6,35,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 14,16,17,19
	.byte	BOX, 14,20,18,21
	.byte	HLIN, 15,16,15
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,12,6
	.byte	VLIN,10,15,12
	.byte	VLIN,21,25,12
	.byte	VLIN,6,7,10
	.byte	VLIN,11,16,10
	.byte	VLIN,21,23,10
	.byte	VLIN,6,8,8
	.byte	VLIN,12,17,8
	.byte	VLIN,12,17,8
	.byte	PLOT,8,21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,4,39,5,41
	.byte	BOX,6,22,8,26
	.byte	HLIN,9,11,25
	.byte	HLIN_ADD,9,12	; 26
	.byte	HLIN,9,10,28
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,4,6,6,23
	.byte	HLIN,7,8,24
	.byte	PLOT,8,27
	.byte	SET_COLOR | GREY1
	.byte	BOX,14,22,18,33
	.byte	BOX,4,25,5,26
	.byte	HLIN,4,7,27
	.byte	HLIN_ADD,5,8	; 28
	.byte	HLIN_ADD,5,10	; 29
	.byte	HLIN_ADD,6,10	; 30
	.byte	HLIN_ADD,6,11	; 31
	.byte	HLIN_ADD,7,12	; 32
	.byte	HLIN_ADD,7,12	; 33
	.byte	HLIN_ADD,8,18		; 34 rsame 18
	.byte	HLIN_ADD_RSAME,8	; 35
	.byte	HLIN_ADD_RSAME,8	; 36
	.byte	HLIN_ADD_RSAME,9	; 37
	.byte	HLIN_ADD_RSAME,9	; 38
	.byte	HLIN_ADD_RSAME,10	; 39
	.byte	HLIN_ADD,10,19		; 40
	.byte	HLIN_ADD,11,20		; 41
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,25,26,8
	.byte	SET_COLOR | RED
	.byte	HLIN,9,12,27
	.byte	SET_COLOR | WHITE
	.byte	HLIN,9,10,24
	.byte	HLIN,11,12,28
	.byte END

frame36:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 10,6,35,32
	.byte	BOX, 21,33,35,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 16,18,20,20
	.byte	BOX, 17,15,19,17
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,11,7
	.byte	HLIN,11,12,6
	.byte	VLIN,10,15,14
	.byte	VLIN,21,23,14
	.byte	PLOT,12,11
	.byte	BOX,11,12,12,16
	.byte	HLIN,11,12,21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,4,6,6,22
	.byte	BOX,16,21,20,32
	.byte	HLIN,16,18,33
	.byte	HLIN,5,6,26
	.byte	HLIN,5,6,40
	.byte	HLIN_ADD,4,6	; 41
	.byte	BOX,10,23,13,25
	.byte	PLOT,14,24
	.byte	BOX,12,27,13,28
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,7,6,9,23
	.byte	HLIN,11,12,24
	.byte	PLOT,12,26
	.byte	SET_COLOR | GREY1
	.byte	PLOT,6,23
	.byte	HLIN,7,9,25
	.byte	HLIN_ADD,7,10	; 26
	.byte	BOX,8,27,11,29
	.byte	BOX,9,30,13,32
	.byte	BOX,10,33,15,36
	.byte	BOX,11,37,20,39
	.byte	BOX,12,40,21,41
	.byte	BOX,16,34,20,36	
	.byte	HLIN,19,20,33
	.byte	BOX,13,25,16,26
	.byte	HLIN,11,12,22
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,12,25
	.byte	SET_COLOR | RED
	.byte	HLIN,13,16,27
	.byte	SET_COLOR | WHITE
	.byte	HLIN,14,15,28
	.byte END

frame37:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 12,6,35,32
	.byte	BOX, 23,33,35,41
	.byte	SET_COLOR | WHITE
	.byte	BOX, 19,14,21,17
	.byte	HLIN,18,21,18
	.byte	BOX, 18,19,22,20
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	HLIN,13,14,6
	.byte	PLOT,14,11
	.byte	BOX,13,12,14,15
	.byte	HLIN,14,16,21
	.byte	VLIN,9,14,16
	.byte	SET_COLOR | GREY1
	.byte	BOX,18,21,22,32
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,4,6,8,22
	.byte	HLIN,7,8,25
	.byte	HLIN,18,22,33
	.byte	BOX,14,22,17,25
	.byte	PLOT,18,23
	.byte	HLIN,19,20,25
	.byte	HLIN,17,19,27
	.byte	HLIN_ADD,18,19	; 28
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,9,6,11,23
	.byte	HLIN,15,16,23
	.byte	HLIN_ADD,17,19
	.byte	PLOT,17,25
	.byte	SET_COLOR | GREY1
	.byte	PLOT,9,23
	.byte	PLOT,15,21
	.byte	PLOT,17,33
	.byte	HLIN,4,6,23
	.byte	BOX,4,25,5,27
	.byte	BOX,4,29,5,30
	.byte	VLIN,31,37,4
	.byte	BOX,9,25,12,26
	.byte	BOX,10,27,13,30
	.byte	BOX,11,30,15,34
	.byte	BOX,12,32,16,38
	.byte	BOX,13,34,22,41
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,24,25,16
	.byte	SET_COLOR | RED
	.byte	HLIN,17,19,26
	.byte	SET_COLOR | WHITE
	.byte	VLIN,26,27,20
	.byte END

frame38:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 12,6,35,41
	.byte	SET_COLOR | WHITE
	.byte	HLIN,21,22,12
	.byte	BOX, 19,13,22,17
	.byte	BOX, 19,18,23,20
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 4,6,8,22
	.byte	HLIN,7,8,25
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,9,6,11,23
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,10,15,14
	.byte	VLIN,9,14,15
	.byte	VLIN,8,14,16
	.byte	VLIN,20,24,14
	.byte	VLIN,20,25,15
	.byte	VLIN,21,26,16
	.byte	SET_COLOR | GREY1
	.byte	BOX,19,21,23,33
	.byte	BOX,12,35,23,41
	.byte	BOX,11,32,16,36
	.byte	PLOT,17,34
	.byte	BOX,10,30,15,31
	.byte	BOX,10,27,13,29
	.byte	PLOT,14,29
	.byte	BOX,9,25,12,26
	.byte	BOX,4,25,5,27
	.byte	VLIN,29,32,4
	.byte	HLIN,4,6,23
	.byte	PLOT,9,23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,18,19,21		; right 21
	.byte	HLIN_ADD_RSAME,17	; 22
	.byte	HLIN_ADD_RSAME,17	; 23
	.byte	HLIN_ADD,17,18		; 24
	.byte	PLOT,22,25
	.byte	PLOT,20,26
	.byte	HLIN_ADD,20,22	; 27
	.byte	PLOT,21,28
	.byte	HLIN,19,23,34
	.byte	SET_COLOR | DARK_BLUE
	.byte	HLIN,18,19,23
	.byte	PLOT,22,24
	.byte	PLOT,21,25
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,19,24
	.byte	SET_COLOR | RED
	.byte	PLOT,20,25
	.byte	HLIN_ADD,21,22	; 26
	.byte END

frame39:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 9,6,35,35
	.byte	BOX, 24,36,35,41
	.byte	SET_COLOR | WHITE
	.byte	HLIN,20,21,10
	.byte	HLIN_ADD,18,21	; 11
	.byte	BOX,18,12,22,14
	.byte	HLIN,17,22,15
	.byte	BOX,17,16,23,20
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 4,6,5,23
	.byte	BOX, 4,26,5,27
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,6,6,8,24
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,10,15,11
	.byte	VLIN,20,25,11
	.byte	VLIN,8,14,13
	.byte	VLIN,21,27,13
	.byte	VLIN,6,13,15
	.byte	VLIN,21,28,15
	.byte	SET_COLOR | GREY1
	.byte	BOX,17,21,23,35
	.byte	BOX,10,36,23,41
	.byte	HLIN,5,6,24
	.byte	HLIN_ADD,6,7	; 25
	.byte	HLIN_ADD,8,9	; 26
	.byte	HLIN_ADD,6,10	; 27
	.byte	HLIN_ADD,6,11	; 28
	.byte	HLIN_ADD,6,11	; 29
	.byte	HLIN_ADD,7,12	; 30
	.byte	HLIN_ADD,7,12	; 31
	.byte	HLIN_ADD,7,13	; 32
	.byte	HLIN_ADD,8,14	; 33
	.byte	HLIN_ADD,8,14	; 34
	.byte	HLIN_ADD,8,15	; 35
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,17,23,36
	.byte	HLIN,21,22,20
	.byte	HLIN_ADD,20,23	; 21
	.byte	HLIN,20,23,24
	.byte	VLIN,21,24,20
	.byte	VLIN,24,26,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,21,22,23,23
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,23,24,22
	.byte END

frame40:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,41
	.byte	SET_COLOR | WHITE
	.byte	HLIN,19,20,8		; right 20
	.byte	HLIN_ADD_RSAME,17	; 9
	.byte	HLIN_ADD_RSAME,16	; 10
	.byte	HLIN_ADD_RSAME,15	; 11
	.byte	HLIN_ADD,15,21		; 12 right 21
	.byte	HLIN_ADD_RSAME,15	; 13
	.byte	HLIN_ADD_RSAME,15	; 13
	.byte	HLIN_ADD_RSAME,14	; 14
	.byte	BOX,14,15,22,20
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 21,19,22,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	PLOT,22,18
	.byte	VLIN,19,21,21
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,11,16,6
	.byte	VLIN,22,27,7
	.byte	VLIN,7,14,8
	.byte	VLIN,22,28,9
	.byte	VLIN,22,29,11
	.byte	BOX,10,6,11,13
	.byte	PLOT,10,14
	.byte	SET_COLOR | GREY1
	.byte	BOX,14,21,20,23
	.byte	BOX,14,24,22,27
	.byte	BOX,14,28,23,41
	.byte	PLOT,4,30
	.byte	HLIN_ADD,4,5		; 31 left 4
	.byte	HLIN_ADD_LSAME,6	; 32
	.byte	HLIN_ADD_LSAME,7	; 33
	.byte	HLIN_ADD_LSAME,8	; 34
	.byte	HLIN_ADD_LSAME,9	; 35
	.byte	HLIN_ADD_LSAME,10	; 36
	.byte	HLIN_ADD_LSAME,11	; 37
	.byte	HLIN_ADD_LSAME,12	; 38
	.byte	HLIN_ADD_LSAME,12	; 39
	.byte	BOX,4,40,13,41
	.byte	SET_COLOR | RED
	.byte	PLOT,22,21
	.byte END

frame41:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,41
	.byte	SET_COLOR | GREY1
	.byte	BOX,7,21,21,37
	.byte	BOX,8,34,22,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,13,16,6
	.byte	HLIN_ADD,12,17	; 7
	.byte	HLIN_ADD,11,17	; 8
	.byte	HLIN_ADD,10,18	; 9
	.byte	HLIN_ADD,9,18	; 10
	.byte	BOX,8,11,19,12
	.byte	BOX,8,13,20,14
	.byte	BOX,8,15,21,16
	.byte	BOX,7,17,20,20
	.byte	HLIN,7,16,21
	.byte	HLIN_ADD,7,12	; 22
	.byte	HLIN_ADD,7,9	; 23
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,17,23,21
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,30,35,4
	.byte END

frame42:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,22,24
	.byte	SET_COLOR | BROWN
	.byte	HLIN,4,6,6
	.byte	PLOT,4,7
	.byte	HLIN,20,35,6
	.byte	BOX,21,7,35,8
	.byte	BOX,22,9,35,12
	.byte	BOX,23,13,35,24
	.byte	BOX,24,25,35,34
	.byte	BOX,25,35,35,41
	.byte	SET_COLOR | GREY1
	.byte	PLOT,21,14
	.byte	BOX,20,15,21,18
	.byte	BOX,21,16,22,20
	.byte	BOX,16,35,24,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	PLOT,20,19
	.byte	HLIN_ADD,17,20		; 20
	.byte	HLIN_ADD,14,22		; 21 right 22
	.byte	HLIN_ADD_RSAME,11	; 22
	.byte	HLIN_ADD_RSAME,8	; 23
	.byte	HLIN_ADD_RSAME,6	; 24
	.byte	BOX,4,25,23,34
	.byte	HLIN,4,22,35		; left 4
	.byte	HLIN_ADD_LSAME,20	; 36
	.byte	HLIN_ADD_LSAME,19	; 37
	.byte	HLIN_ADD_LSAME,18	; 38
	.byte	HLIN_ADD_LSAME,17	; 39
	.byte	HLIN_ADD_LSAME,16	; 40
	.byte	HLIN_ADD_LSAME,15	; 41
	.byte	SET_COLOR | RED
	.byte	PLOT,21,18
	.byte	HLIN,20,21,17
	.byte END

frame43:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,22,22
	.byte	SET_COLOR | BROWN
	.byte	BOX,23,6,35,18
	.byte	BOX,32,19,35,26
	.byte	BOX,33,27,35,35
	.byte	BOX,34,36,35,41
	.byte	SET_COLOR | GREY1
	.byte	HLIN,31,32,27
	.byte	HLIN_ADD,28,32		; 28	right 32
	.byte	HLIN_ADD_RSAME,25	; 29
	.byte	BOX,21,30,32,35
	.byte	BOX,16,36,33,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,19,20,17		; right 20
	.byte	HLIN_ADD_RSAME,16	; 18
	.byte	HLIN_ADD_RSAME,14	; 19
	.byte	HLIN_ADD_RSAME,12	; 20
	.byte	HLIN_ADD_RSAME,9	; 21
	.byte	HLIN_ADD_RSAME,7	; 22
	.byte	BOX,4,23,21,33
	.byte	VLIN,30,31,22
	.byte	HLIN,4,21,32		; left 4
	.byte	HLIN_ADD_LSAME,21	; 33
	.byte	HLIN_ADD_LSAME,20	; 34
	.byte	HLIN_ADD_LSAME,20	; 35
	.byte	HLIN_ADD_LSAME,19	; 36
	.byte	HLIN_ADD_LSAME,18	; 37
	.byte	HLIN_ADD_LSAME,18	; 38
	.byte	HLIN_ADD_LSAME,17	; 39
	.byte	HLIN_ADD_LSAME,16	; 40
	.byte	HLIN_ADD_LSAME,15	; 41
	.byte	SET_COLOR | GREEN
	.byte	PLOT,31,20
	.byte	HLIN_ADD,29,31	; 21
	.byte	HLIN_ADD,26,31	; 22
	.byte	HLIN_ADD,24,31	; 23
	.byte	HLIN_ADD,22,31	; 24
	.byte	HLIN_ADD,22,30	; 25
	.byte	HLIN_ADD,22,28	; 26
	.byte	HLIN_ADD,22,25	; 27
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,6,16,30
	.byte	VLIN,17,18,31
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,13,15,28
	.byte	VLIN,16,19,29
	.byte	VLIN,17,22,21
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX,24,9,25,10
	.byte	BOX,22,17,23,20
	.byte	BOX,25,15,26,18
	.byte	SET_COLOR | PINK
	.byte	PLOT,26,6
	.byte	VLIN,15,18,27
	.byte	VLIN,19,20,28
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	VLIN,13,16,21
	.byte	VLIN,13,14,27
	.byte	VLIN,7,9,26
	.byte	PLOT,27,7
	.byte	PLOT,22,14
	.byte	HLIN,27,29,6
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,7,13,29
	.byte	PLOT,26,15
	.byte	PLOT,24,11
	.byte	HLIN_ADD,24,27	; 12
	.byte	PLOT,24,13
	.byte	SET_COLOR | YELLOW
	.byte	HLIN,26,27,11
	.byte	PLOT,26,12
	.byte	SET_COLOR | GREY1
	.byte	PLOT,23,9
	.byte	BOX,22,10,23,13
	.byte	HLIN,23,24,14
	.byte	PLOT,25,11
	.byte	VLIN,7,12,28
	.byte	VLIN,8,10,27
	.byte	PLOT,26,10
	.byte	SET_COLOR | RED
	.byte	PLOT,29,10
	.byte	HLIN,22,23,12
	.byte	SET_COLOR | BROWN
	.byte	BOX,22,15,23,16
	.byte	HLIN,24,27,19
	.byte	HLIN_ADD,23,27	; 20
	.byte	HLIN_ADD,22,25	; 21
	.byte	HLIN_ADD,22,23	; 22
	.byte END

frame44:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,21,21
	.byte	SET_COLOR | BROWN
	.byte	BOX,22,6,31,11
	.byte	BOX,20,11,32,15
	.byte	HLIN,20,31,16
	.byte	HLIN_ADD,20,29	; 17
	.byte	HLIN_ADD,21,27	; 18	set left 21
	.byte	HLIN_ADD_LSAME,26	; 19
	.byte	HLIN_ADD_LSAME,24	; 20
	.byte	HLIN_ADD_LSAME,22	; 21
	.byte	SET_COLOR | GREY1
	.byte	BOX,33,12,34,14
	.byte	BOX,25,6,27,7
	.byte	PLOT,28,6
	.byte	HLIN,34,35,23		; set right 35
	.byte	HLIN_ADD_RSAME,32	; 24
	.byte	HLIN_ADD_RSAME,30	; 25
	.byte	HLIN_ADD_RSAME,28	; 26
	.byte	HLIN_ADD_RSAME,26	; 27
	.byte	HLIN_ADD_RSAME,24	; 28
	.byte	BOX,17,29,35,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,30,31,6
	.byte	BOX,25,8,27,9
	.byte	HLIN,18,19,15
	.byte	HLIN_ADD,16,19		; 16	set right 19
	.byte	HLIN_ADD_RSAME,14	; 17
	.byte	HLIN_ADD,12,20		; 18	set right 20
	.byte	HLIN_ADD_RSAME,9	; 19
	.byte	HLIN_ADD_RSAME,7	; 20
	.byte	HLIN_ADD_RSAME,5	; 21
	.byte	BOX,4,22,21,28
	.byte	HLIN,4h,22,29	; Set left 4
	.byte	HLIN_ADD_LSAME,22	; 30
	.byte	HLIN_ADD_LSAME,22	; 31
	.byte	HLIN_ADD_LSAME,21	; 32
	.byte	HLIN_ADD_LSAME,21	; 33
	.byte	HLIN_ADD_LSAME,20	; 34
	.byte	HLIN_ADD_LSAME,20	; 35
	.byte	HLIN_ADD_LSAME,19	; 36
	.byte	HLIN_ADD_LSAME,19	; 37
	.byte	HLIN_ADD_LSAME,18	; 38
	.byte	HLIN_ADD_LSAME,17	; 39
	.byte	HLIN_ADD_LSAME,17	; 40
	.byte	HLIN_ADD_LSAME,16	; 41
	.byte	SET_COLOR | GREEN
	.byte	BOX,22,23,24,26
	.byte	BOX,24,22,26,25
	.byte	BOX,25,21,27,24
	.byte	BOX,27,20,29,23
	.byte	BOX,28,19,31,22
	.byte	BOX,30,18,33,21
	.byte	BOX,33,16,34,17
	.byte	PLOT,32,17
	.byte	PLOT,23,8
	.byte	VLIN,6,12,24
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,32,6,35,11
	.byte	HLIN,32,33,12
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,12,14,26
	.byte	VLIN,15,18,27
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,9,11,21
	.byte	VLIN,8,10,22
	.byte	VLIN,15,18,22
	.byte	VLIN,14,17,23
	.byte	SET_COLOR | PINK
	.byte	VLIN,6,7,23
	.byte	VLIN,13,14,24
	.byte	VLIN,15,19,25
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	BOX,25,10,27,11
	.byte	PLOT,25,12
	.byte	SET_COLOR | YELLOW
	.byte	PLOT,29,6
	.byte	SET_COLOR | RED
	.byte	HLIN,25,26,6
	.byte END


num_scenes=30
