	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,19,31
	.byte BOX_ADD_LSAME,17,37 ; 4, 32
	.byte 15,41
	.byte SET_COLOR | ORANGE
	.byte BOX,20,6,35,41
	.byte SET_COLOR | DARK_BLUE
	.byte 4,7,14,8
	.byte BOX_ADD_LSAME,13,11 ; 4, 9
	.byte 12,13
	.byte 11,15
	.byte 10,17
	.byte 9,19
	.byte 8,22
	.byte 7,24
	.byte 6,26
	.byte BOX,10,32,14,33
	.byte 4,27,5,28
	.byte HLIN,4,15,6
	.byte VLIN,29,30,4
	.byte SET_COLOR | PINK
	.byte BOX,28,15,35,20
	.byte 29,6,35,14
	.byte HLIN,29,35,21
	.byte HLIN_ADD_RSAME,30	; 30 35 22
	.byte 31	; 31 35 23
	.byte 32	; 32 35 24
	.byte 33	; 33 35 25
	.byte 34	; 34 35 26
	.byte HLIN,21,22,41
	.byte VLIN,39,41,35
	.byte PLOT,35,27
	.byte 21,40
	.byte SET_COLOR | BROWN
	.byte BOX,20,14,21,15
	.byte 20,18,24,19
	.byte 20,21,26,23
	.byte BOX_ADD_LSAME,25,26 ; 20, 24
	.byte 24,29
	.byte 23,32
	.byte 22,35
	.byte 21,37
	.byte HLIN,20,23,17
	.byte 20,25,20
	.byte 20,22,16
	.byte PLOT,20,13
	.byte SET_COLOR | GREY1
	.byte BOX,17,33,18,34
	.byte 19,39,20,41
	.byte 16,36,17,37
	.byte HLIN,12,14,31
	.byte 18,19,31
	.byte HLIN_ADD,10,15	; 32
	.byte HLIN_ADD_LSAME,13 ; 10, 13, 33
	.byte HLIN,11,13,34
	.byte 15,16,39
	.byte VLIN,29,33,10
	.byte 28,30,19
	.byte 33,35,15
	.byte 34,36,11
	.byte 29,30,14
	.byte 37,38,20
	.byte 40,41,15
	.byte PLOT,12,30
	.byte 18,32
	.byte 17,35
	.byte 16,38
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,19,6,20,8
	.byte VLIN,9,16,19
	.byte SET_COLOR | RED
	.byte 32,33,10
	.byte 34,35,11
	.byte SET_COLOR | YELLOW
	.byte PLOT,13,34
	.byte END
; total size = 213
