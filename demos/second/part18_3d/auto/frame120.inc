	.byte SET_COLOR | PINK
	.byte BOX,19,6,35,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte 8,6,19,18
	.byte 8,23,16,40
	.byte 8,19,15,22
	.byte HLIN,8,13,41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,8,12,13
	.byte BOX_ADD_LSAME,11,19 ; 4, 14
	.byte 10,24
	.byte 9,29
	.byte 8,35
	.byte 7,41
	.byte BOX,12,37,16,38
	.byte 15,34,16,36
	.byte HLIN,4,16,6
	.byte HLIN_ADD_LSAME,13 ; 4, 13, 7
	.byte PLOT,16,40
	.byte SET_COLOR | ORANGE
	.byte BOX,19,8,28,10
	.byte BOX_ADD_LSAME,27,19 ; 19, 11
	.byte BOX,26,26,35,34
	.byte BOX_ADD,25,34,41	; 35
	.byte BOX,20,6,28,7
	.byte HLIN,21,27,20
	.byte HLIN_ADD,22,26	; 21
	.byte HLIN,25,28,23
	.byte HLIN_ADD,27,30	; 24
	.byte HLIN_ADD_LSAME,33 ; 27, 33, 25
	.byte HLIN,24,26,22
	.byte SET_COLOR | GREY1
	.byte BOX,15,13,18,14
	.byte BOX_ADD_RSAME,16,18
	.byte BOX,12,37,15,38
	.byte 18,35,19,39
	.byte HLIN,16,17,28
	.byte 14,15,36
	.byte 13,15,39
	.byte HLIN_ADD,18,20	; 40
	.byte HLIN_ADD_LSAME,22 ; 18, 22, 41
	.byte HLIN,14,15,41
	.byte VLIN,29,34,16
	.byte 23,27,17
	.byte 8,10,19
	.byte 32,34,19
	.byte 36,38,12
	.byte 11,12,18
	.byte 39,40,13
	.byte 39,40,15
	.byte PLOT,18,19
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,15,7,16,12
	.byte BOX_ADD_LSAME,17,14 ; 15, 13
	.byte BOX,16,15,17,16
	.byte HLIN,14,16,6
	.byte SET_COLOR | RED
	.byte VLIN,37,38,12
	.byte PLOT,13,39
	.byte SET_COLOR | YELLOW
	.byte 15,39
	.byte END
; total size = 196
