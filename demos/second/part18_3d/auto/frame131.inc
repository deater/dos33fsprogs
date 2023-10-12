	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,13,17,19,22
	.byte BOX_ADD_LSAME,17,41 ; 13, 23
	.byte BOX,13,9,17,16
	.byte 14,6,16,8
	.byte SET_COLOR | PINK
	.byte 21,6,35,41
	.byte 4,6,12,36
	.byte SET_COLOR | GREY1
	.byte 17,22,18,36
	.byte 21,35,27,41
	.byte HLIN,17,18,9
	.byte 17,18,19
	.byte VLIN,17,37,41
	.byte VLIN_ADD,10,18	; 18
	.byte VLIN,21,18,34
	.byte SET_COLOR | BROWN
	.byte BOX,30,14,32,20
	.byte BOX_ADD,29,33,27	; 21
	.byte BOX,4,24,5,26
	.byte BOX_ADD_LSAME,6,28 ; 4, 27
	.byte BOX,28,28,33,32
	.byte 4,29,7,30
	.byte BOX_ADD_LSAME,8,32 ; 4, 31
	.byte 9,34
	.byte BOX,27,33,32,34
	.byte BOX_ADD,4,10,41	; 35
	.byte BOX,28,35,31,37
	.byte BOX_ADD_LSAME,30,40 ; 28, 38
	.byte HLIN,28,29,41
	.byte VLIN,4,22,23
	.byte 31,8,13
	.byte SET_COLOR | ORANGE
	.byte BOX,32,8,35,14
	.byte BOX_ADD_RSAME,33,23
	.byte 34,30	; 35 24
	.byte HLIN,21,35,6
	.byte HLIN_ADD_RSAME,31	; 31 35 7
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,16,19,17,21
	.byte HLIN,4,12,37
	.byte VLIN,12,12,36
	.byte VLIN_ADD,6,11	; 13
	.byte VLIN,16,17,18
	.byte PLOT,16,22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,38,12,41
	.byte SET_COLOR | YELLOW
	.byte PLOT,17,21
	.byte END
; total size = 166
