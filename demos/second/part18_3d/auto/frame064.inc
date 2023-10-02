	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,9,18,20,30
	.byte 9,39,19,41
	.byte 9,31,19,32
	.byte BOX_ADD_LSAME,18,38 ; 9, 33
	.byte SET_COLOR | BROWN
	.byte BOX,12,6,35,17
	.byte BOX_ADD_RSAME,18,19
	.byte 19,23	; 35 20
	.byte 27,39	; 35 24
	.byte 33,41	; 35 40
	.byte SET_COLOR | GREEN
	.byte BOX,4,16,17,17
	.byte BOX_ADD_LSAME,16,22 ; 4, 18
	.byte 15,24
	.byte 14,27
	.byte BOX,4,29,12,30
	.byte 4,32,10,33
	.byte 4,37,9,41
	.byte HLIN,14,17,15
	.byte 4,13,28
	.byte 4,11,31
	.byte 16,20,41
	.byte 7,9,36
	.byte VLIN,39,40,19
	.byte PLOT,8,34
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,26,28
	.byte 7,7,12,12
	.byte 33,12,35,15
	.byte 7,13,11,15
	.byte 34,28,35,35
	.byte 34,16,35,19
	.byte HLIN,7,17,6
	.byte 7,9,16
	.byte HLIN_ADD_LSAME,8 ; 7, 8, 17
	.byte PLOT,7,18
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,14,6,17,14
	.byte 4,6,6,26
	.byte 4,31,6,32
	.byte 4,27,5,30
	.byte HLIN,4,7,33
	.byte 14,15,15
	.byte VLIN,15,16,17
	.byte PLOT,14,16
	.byte SET_COLOR | GREY1
	.byte HLIN,24,26,27
	.byte HLIN_ADD_RSAME,21	; 21 26 28
	.byte HLIN,21,24,29
	.byte 24,26,31
	.byte HLIN_ADD,21,28	; 32
	.byte HLIN_ADD_LSAME,29 ; 21, 29, 33
	.byte HLIN,6,7,33
	.byte HLIN_ADD,22,29	; 34
	.byte HLIN_ADD_RSAME,23	; 23 29 35
	.byte 24	; 24 29 36
	.byte 25	; 25 29 37
	.byte 26	; 26 29 38
	.byte HLIN,27,31,39
	.byte HLIN_ADD,28,32	; 40
	.byte 29,33	; 41
	.byte HLIN,4,5,34
	.byte PLOT,26,26
	.byte SET_COLOR | PINK
	.byte BOX,11,7,12,12
	.byte HLIN,10,17,6
	.byte VLIN,13,15,11
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,8,8,12,9
	.byte 11,9,12,10
	.byte HLIN,8,10,7
	.byte PLOT,8,6
	.byte SET_COLOR | GREY2
	.byte BOX,9,8,10,9
	.byte SET_COLOR | RED
	.byte HLIN,11,12,9
	.byte SET_COLOR | ORANGE
	.byte PLOT,9,8
	.byte END
; total size = 245
