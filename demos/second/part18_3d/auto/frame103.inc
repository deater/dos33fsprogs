	.byte SET_COLOR | DARK_BLUE
	.byte BOX,5,6,35,21
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX_ADD_RSAME,4,32
	.byte 7,37	; 35 33
	.byte 8,41	; 35 38
	.byte BOX,4,6,5,9
	.byte HLIN,27,35,17
	.byte HLIN_ADD_RSAME,22	; 22 35 18
	.byte 17	; 17 35 19
	.byte 13	; 13 35 20
	.byte 8	; 8 35 21
	.byte HLIN,32,35,16
	.byte VLIN,38,41,4
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,30,21,32,25
	.byte 22,23,25,27
	.byte 14,24,17,28
	.byte 29,30,31,34
	.byte 22,32,24,35
	.byte 15,33,18,37
	.byte BOX_ADD,28,30,41	; 38
	.byte BOX,33,38,35,40
	.byte 22,40,24,41
	.byte HLIN,23,25,22
	.byte 34,35,37
	.byte HLIN_ADD,15,16	; 38
	.byte HLIN,17,19,41
	.byte 23,24,39
	.byte VLIN,29,32,35
	.byte SET_COLOR | BROWN
	.byte BOX,20,6,21,15
	.byte 7,6,8,12
	.byte 23,12,32,13
	.byte 6,13,7,17
	.byte HLIN,25,32,11
	.byte 30,31,10
	.byte SET_COLOR | GREY1
	.byte BOX,4,25,5,30
	.byte BOX_ADD_LSAME,6,32 ; 4, 31
	.byte BOX,5,38,6,41
	.byte VLIN,14,24,4
	.byte PLOT,4,10
	.byte SET_COLOR | PINK
	.byte HLIN,30,32,12
	.byte HLIN_ADD_RSAME,26	; 26 32 13
	.byte HLIN,23,30,14
	.byte HLIN_ADD_LSAME,26 ; 23, 26, 15
	.byte HLIN,20,21,15
	.byte 6,7,18
	.byte END
; total size = 163
