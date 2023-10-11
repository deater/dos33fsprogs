	.byte SET_COLOR | BROWN
	.byte BOX,19,6,34,32
	.byte BOX_ADD,26,33,35	; 33
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,24,19,25,20
	.byte BOX_ADD_LSAME,33,22 ; 24, 21
	.byte BOX,31,23,33,25
	.byte 24,23,25,24
	.byte HLIN,31,33,20
	.byte PLOT,32,19
	.byte SET_COLOR | GREY1
	.byte BOX,4,6,18,19
	.byte BOX_ADD_LSAME,19,31 ; 4, 20
	.byte BOX,27,21,31,22
	.byte 34,26,35,35
	.byte 4,33,17,35
	.byte HLIN,24,25,18
	.byte 27,33,23
	.byte 4,23,32
	.byte HLIN_ADD,21,25	; 33
	.byte 24,29	; 34
	.byte 26,32	; 35
	.byte 4,19	; 36
	.byte HLIN,28,35,36
	.byte HLIN_ADD,4,22	; 37
	.byte HLIN,31,35,37
	.byte HLIN_ADD,4,24	; 38
	.byte HLIN,33,35,38
	.byte HLIN_ADD,4,26	; 39
	.byte HLIN_ADD_LSAME,28 ; 4, 28, 40
	.byte 30
	.byte VLIN,24,19,23
	.byte 35,6,25
	.byte PLOT,24,17
	.byte 31,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,7,6,9,15
	.byte 6,26,9,34
	.byte SET_COLOR | RED
	.byte HLIN,32,33,23
	.byte PLOT,24,21
	.byte SET_COLOR | ORANGE
	.byte HLIN_ADD,28,29	; 22
	.byte END
; total size = 135
