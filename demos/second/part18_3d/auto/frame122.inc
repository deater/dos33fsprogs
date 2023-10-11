	.byte SET_COLOR | ORANGE
	.byte BOX,19,6,35,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte 4,6,15,22
	.byte 18,6,24,7
	.byte 12,23,13,24
	.byte 12,26,15,29
	.byte BOX_ADD,4,16,34	; 30
	.byte BOX_ADD_LSAME,17,40 ; 4, 35
	.byte HLIN,18,22,8
	.byte HLIN_ADD_LSAME,20 ; 18, 20, 9
	.byte HLIN,12,14,25
	.byte 4,16,41
	.byte SET_COLOR | PINK
	.byte BOX,27,6,35,21
	.byte 19,26,26,27
	.byte BOX_ADD_LSAME,27,39 ; 19, 28
	.byte HLIN,27,34,22
	.byte HLIN_ADD,28,31	; 23
	.byte HLIN,19,24,25
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,15,11,41
	.byte 15,36,17,40
	.byte HLIN,7,11,14
	.byte PLOT,17,35
	.byte SET_COLOR | GREY1
	.byte BOX,18,26,19,34
	.byte 15,30,16,34
	.byte 19,37,20,39
	.byte BOX_ADD_LSAME,24,41 ; 19, 40
	.byte HLIN,13,15,21
	.byte HLIN_ADD_RSAME,14	; 14 15 22
	.byte VLIN,15,6,20
	.byte 15,26,29
	.byte VLIN_ADD,39,41	; 16
	.byte VLIN,16,35,36
	.byte 18,6,15
	.byte 18,20,25
	.byte VLIN_ADD,35,36	; 19
	.byte SET_COLOR | BROWN
	.byte BOX,27,6,29,10
	.byte BOX_ADD_LSAME,28,17 ; 27, 11
	.byte BOX,26,32,27,37
	.byte BOX_ADD_RSAME,25,41
	.byte VLIN,27,18,22
	.byte 27,28,31
	.byte PLOT,25,6
	.byte SET_COLOR | RED
	.byte VLIN,15,38,39
	.byte SET_COLOR | YELLOW
	.byte PLOT,16,39
	.byte END
; total size = 167
