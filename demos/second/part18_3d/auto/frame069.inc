	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,19
	.byte BOX_ADD_RSAME,19,21
	.byte 28,41	; 35 22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,19,6,27,18
	.byte 4,6,9,20
	.byte 20,19,23,20
	.byte SET_COLOR | GREY1
	.byte 11,14,16,18
	.byte 22,31,31,32
	.byte 24,34,31,35
	.byte 27,38,31,39
	.byte HLIN,11,15,6
	.byte 26,27,18
	.byte HLIN_ADD,11,17	; 19
	.byte HLIN,24,27,19
	.byte HLIN_ADD_RSAME,21	; 21 27 20
	.byte HLIN,14,18,20
	.byte HLIN_ADD,15,27	; 21
	.byte HLIN_ADD_LSAME,25 ; 15, 25, 22
	.byte HLIN,16,21,23
	.byte HLIN_ADD,17,18	; 24
	.byte 25,27	; 25
	.byte HLIN_ADD_RSAME,22	; 22 27 26
	.byte HLIN,19,28,27
	.byte HLIN_ADD,20,29	; 28
	.byte HLIN_ADD_LSAME,30 ; 20, 30, 29
	.byte HLIN,21,31,30
	.byte 23,31,33
	.byte 25,31,36
	.byte HLIN_ADD_RSAME,26	; 26 31 37
	.byte HLIN,28,32,40
	.byte HLIN_ADD_LSAME,33 ; 28, 33, 41
	.byte SET_COLOR | GREEN
	.byte BOX,4,10,9,11
	.byte BOX_ADD_LSAME,10,13 ; 4, 12
	.byte 11,15
	.byte 12,23
	.byte 14,27
	.byte 16,41
	.byte PLOT,8,9
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,16,32,18,38
	.byte BOX_ADD_RSAME,15,41
	.byte HLIN,10,12,22
	.byte HLIN_ADD,9,13	; 23
	.byte 8,12	; 24
	.byte 7,11	; 25
	.byte 6,9	; 26
	.byte HLIN_ADD_LSAME,8 ; 6, 8, 27
	.byte HLIN,5,6,28
	.byte 16,17,31
	.byte PLOT,12,21
	.byte 5,29
	.byte 17,30
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,12,7,16,14
	.byte HLIN,14,15,6
	.byte SET_COLOR | PINK
	.byte BOX,8,6,9,8
	.byte VLIN,9,9,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,12,7,13,8
	.byte VLIN,12,6,7
	.byte PLOT,13,9
	.byte SET_COLOR | RED
	.byte 12,7
	.byte 13,8
	.byte END
; total size = 202
