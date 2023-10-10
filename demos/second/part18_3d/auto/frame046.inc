	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,28,26
	.byte BOX_ADD_LSAME,21,41 ; 4, 27
	.byte SET_COLOR | GREY1
	.byte BOX,21,40,35,41
	.byte 22,33,35,39
	.byte HLIN,33,35,27
	.byte HLIN_ADD_RSAME,31	; 31 35 28
	.byte 29	; 29 35 29
	.byte 27	; 27 35 30
	.byte 26	; 26 35 31
	.byte 24	; 24 35 32
	.byte HLIN,26,27,6
	.byte PLOT,35,26
	.byte SET_COLOR | BROWN
	.byte BOX,20,8,30,20
	.byte BOX_ADD,21,28,24	; 21
	.byte BOX,22,6,25,7
	.byte HLIN,27,28,7
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,21,8
	.byte BOX_ADD_LSAME,20,12 ; 4, 9
	.byte 19,16
	.byte HLIN,4,17,17
	.byte HLIN_ADD_LSAME,13 ; 4, 13, 18
	.byte 11
	.byte 8
	.byte 5
	.byte SET_COLOR | GREEN
	.byte BOX,21,10,25,14
	.byte 31,7,32,19
	.byte HLIN,22,24,8
	.byte HLIN_ADD_LSAME,25 ; 22, 25, 9
	.byte HLIN,29,32,20
	.byte HLIN_ADD_RSAME,27	; 27 32 21
	.byte 25	; 25 32 22
	.byte 24	; 24 32 23
	.byte 22	; 22 32 24
	.byte HLIN,21,31,25
	.byte HLIN_ADD_LSAME,29 ; 21, 29, 26
	.byte HLIN,22,27,27
	.byte HLIN_ADD_LSAME,26 ; 22, 26, 28
	.byte 24
	.byte HLIN,23,24,7
	.byte PLOT,22,30
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,29,6,34,10
	.byte BOX_ADD_RSAME,30,14
	.byte BOX,31,15,33,16
	.byte BOX_ADD_LSAME,32,18 ; 31, 17
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,22,11,25,14
	.byte HLIN,23,25,10
	.byte 23,24,15
	.byte PLOT,24,9
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,34,6,35,11
	.byte VLIN,12,13,35
	.byte SET_COLOR | PINK
	.byte 13,19,21
	.byte 20,24,22
	.byte SET_COLOR | ORANGE
	.byte 15,19,24
	.byte 20,22,25
	.byte END
; total size = 178
