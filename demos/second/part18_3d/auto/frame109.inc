	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,15,33
	.byte BOX_ADD_LSAME,8,41 ; 4, 34
	.byte SET_COLOR | GREY1
	.byte BOX,15,15,16,17
	.byte BOX_ADD,13,14,20	; 18
	.byte 11,35,22	; 21
	.byte BOX,14,36,35,41
	.byte 10,38,11,41
	.byte HLIN,14,16,32
	.byte HLIN_ADD,12,35	; 33
	.byte 10,14	; 34
	.byte HLIN_ADD_LSAME,11 ; 10, 11, 35
	.byte VLIN,16,21,11
	.byte 18,20,16
	.byte PLOT,12,23
	.byte 16,23
	.byte SET_COLOR | PINK
	.byte BOX,16,6,35,16
	.byte BOX_ADD_RSAME,17,36
	.byte HLIN,18,34,37
	.byte HLIN_ADD_LSAME,32 ; 18, 32, 38
	.byte 30
	.byte 27
	.byte 23
	.byte SET_COLOR | BROWN
	.byte BOX,24,6,27,29
	.byte BOX_ADD_LSAME,26,41 ; 24, 30
	.byte HLIN,15,17,6
	.byte VLIN,7,14,15
	.byte VLIN_ADD,24,33	; 16
	.byte 34,41	; 17
	.byte PLOT,15,17
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,9,7,18
	.byte BOX_ADD_LSAME,8,21 ; 4, 19
	.byte HLIN,4,6,8
	.byte 34,35,39
	.byte HLIN_ADD_RSAME,32	; 32 35 40
	.byte 29	; 29 35 41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,19,8,28
	.byte BOX_ADD,8,9,37	; 29
	.byte BOX,9,39,10,41
	.byte VLIN,9,18,7
	.byte PLOT,9,38
	.byte SET_COLOR | ORANGE
	.byte BOX,26,6,35,7
	.byte BOX_ADD_RSAME,28,9
	.byte HLIN,28,33,10
	.byte HLIN_ADD_LSAME,29 ; 28, 29, 11
	.byte SET_COLOR | RED
	.byte PLOT,11,21
	.byte 12,22
	.byte SET_COLOR | YELLOW
	.byte 14,22
	.byte END
; total size = 163
