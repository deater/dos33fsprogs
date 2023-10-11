	.byte SET_COLOR | ORANGE
	.byte BOX,19,7,35,41
	.byte PLOT,27,6
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,10,6,17,16
	.byte BOX_ADD_LSAME,16,20 ; 10, 17
	.byte BOX,12,21,14,23
	.byte BOX_ADD,10,16,33	; 24
	.byte BOX_ADD_LSAME,15,35 ; 10, 34
	.byte 16,37
	.byte 25,39
	.byte 15,41
	.byte HLIN,20,25,6
	.byte SET_COLOR | PINK
	.byte BOX,27,7,35,22
	.byte 19,25,26,40
	.byte HLIN,28,35,6
	.byte 27,34,23
	.byte 19,20,23
	.byte HLIN_ADD_LSAME,23 ; 19, 23, 24
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,9,14,13
	.byte BOX_ADD_LSAME,11,26 ; 4, 14
	.byte 10,39
	.byte BOX,14,38,15,41
	.byte 4,40,9,41
	.byte HLIN,14,16,37
	.byte VLIN,17,39,40
	.byte PLOT,16,36
	.byte SET_COLOR | GREY1
	.byte BOX,14,17,16,18
	.byte BOX_ADD_RSAME,15,20
	.byte BOX,18,32,19,38
	.byte HLIN,14,17,16
	.byte 15,16,24
	.byte 15,16,33
	.byte 18,20,39
	.byte HLIN_ADD_LSAME,22 ; 18, 22, 40
	.byte 24
	.byte VLIN,13,35,37
	.byte 15,34,36
	.byte VLIN_ADD,25,32	; 16
	.byte 6,15	; 17
	.byte PLOT,15,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,14,8
	.byte 13,10,14,13
	.byte BOX_ADD,14,15,18	; 14
	.byte HLIN,8,14,9
	.byte SET_COLOR | BROWN
	.byte BOX,27,7,28,15
	.byte 25,36,26,41
	.byte VLIN,26,29,35
	.byte VLIN_ADD,16,23	; 27
	.byte PLOT,26,6
	.byte 28,6
	.byte SET_COLOR | RED
	.byte VLIN,14,39,40
	.byte SET_COLOR | YELLOW
	.byte PLOT,15,40
	.byte END
; total size = 188
