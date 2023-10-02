	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,7,29,19
	.byte 4,30,22,41
	.byte 4,20,21,29
	.byte SET_COLOR | WHITE
	.byte 4,6,22,16
	.byte HLIN,4,18,17
	.byte HLIN_ADD_LSAME,15 ; 4, 15, 18
	.byte 13
	.byte 11
	.byte 8
	.byte 6
	.byte SET_COLOR | BROWN
	.byte BOX,23,7,28,10
	.byte 30,7,35,9
	.byte 30,11,35,13
	.byte BOX_ADD_RSAME,22,18
	.byte BOX,23,30,35,31
	.byte BOX_ADD_RSAME,22,41
	.byte BOX,32,25,35,26
	.byte HLIN,23,35,6
	.byte 22,35,10
	.byte 25,28,13
	.byte 22,30,19
	.byte 32,35,19
	.byte HLIN_ADD,22,28	; 20
	.byte HLIN,31,35,20
	.byte HLIN_ADD_RSAME,29	; 29 35 21
	.byte HLIN,22,25,21
	.byte HLIN_ADD,26,35	; 22
	.byte HLIN_ADD_RSAME,24	; 24 35 23
	.byte 22	; 22 35 24
	.byte HLIN,31,35,27
	.byte HLIN_ADD_RSAME,28	; 28 35 28
	.byte 25	; 25 35 29
	.byte HLIN,22,23,22
	.byte SET_COLOR | GREY1
	.byte BOX,26,7,28,8
	.byte 23,30,32,31
	.byte BOX_ADD_RSAME,22,33
	.byte 21,35	; 32 34
	.byte BOX,19,37,33,38
	.byte 17,40,33,41
	.byte 22,11,23,13
	.byte HLIN,23,28,9
	.byte HLIN_ADD,22,30	; 10
	.byte 25,28	; 11
	.byte HLIN,22,24,14
	.byte 28,32,28
	.byte HLIN_ADD_RSAME,25	; 25 32 29
	.byte HLIN,20,33,36
	.byte 18,33,39
	.byte 31,32,27
	.byte PLOT,28,12
	.byte SET_COLOR | GREEN
	.byte HLIN,26,31,22
	.byte HLIN_ADD_RSAME,24	; 24 31 23
	.byte 22	; 22 31 24
	.byte HLIN,22,30,25
	.byte HLIN_ADD_LSAME,28 ; 22, 28, 26
	.byte 25
	.byte HLIN,29,31,21
	.byte PLOT,31,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,25,16,26,18
	.byte 22,17,23,19
	.byte HLIN,24,26,9
	.byte HLIN_ADD_LSAME,25 ; 24, 25, 10
	.byte PLOT,26,15
	.byte 22,20
	.byte SET_COLOR | LIGHT_GREEN
	.byte HLIN,26,29,6
	.byte HLIN_ADD_LSAME,27 ; 26, 27, 7
	.byte HLIN,21,22,14
	.byte VLIN,13,16,27
	.byte 8,9,26
	.byte 15,16,21
	.byte PLOT,21,13
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,6,16,30
	.byte 17,18,31
	.byte SET_COLOR | ORANGE
	.byte HLIN,27,28,15
	.byte 28,29,19
	.byte VLIN,17,22,21
	.byte 16,18,29
	.byte 13,14,28
	.byte SET_COLOR | GREY2
	.byte HLIN,16,25,41
	.byte PLOT,32,32
	.byte 27,41
	.byte 33,41
	.byte SET_COLOR | PINK
	.byte VLIN,15,18,27
	.byte 19,20,28
	.byte PLOT,26,6
	.byte SET_COLOR | RED
	.byte HLIN,22,23,12
	.byte PLOT,29,10
	.byte SET_COLOR | YELLOW
	.byte HLIN_ADD,26,27	; 11
	.byte PLOT,26,12
	.byte END
; total size = 296
