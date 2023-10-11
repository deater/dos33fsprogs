	.byte SET_COLOR | ORANGE
	.byte BOX,20,6,35,41
	.byte SET_COLOR | BROWN
	.byte 29,6,35,20
	.byte 20,12,22,13
	.byte BOX_ADD_LSAME,23,15 ; 20, 14
	.byte BOX,20,17,25,18
	.byte BOX_ADD_LSAME,26,22 ; 20, 19
	.byte 25,24
	.byte 24,26
	.byte BOX,34,25,35,26
	.byte BOX_ADD,20,23,28	; 27
	.byte BOX_ADD_LSAME,22,30 ; 20, 29
	.byte 21,32
	.byte BOX,20,38,21,39
	.byte HLIN,20,21,11
	.byte 20,24,16
	.byte 30,35,21
	.byte HLIN_ADD_RSAME,31	; 31 35 22
	.byte 32	; 32 35 23
	.byte 33	; 33 35 24
	.byte HLIN,20,22,40
	.byte HLIN_ADD_LSAME,23 ; 20, 23, 41
	.byte PLOT,35,27
	.byte 20,37
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,20,34
	.byte BOX_ADD_LSAME,18,40 ; 4, 35
	.byte HLIN,4,15,41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,8,15,9
	.byte 4,11,13,12
	.byte 4,14,11,15
	.byte 4,17,9,18
	.byte 4,20,7,21
	.byte BOX_ADD_LSAME,6,23 ; 4, 22
	.byte HLIN,4,17,6
	.byte HLIN_ADD_LSAME,16 ; 4, 16, 7
	.byte HLIN,4,14,10
	.byte 4,12,13
	.byte 4,10,16
	.byte 4,8,19
	.byte 4,5,24
	.byte VLIN,25,26,4
	.byte SET_COLOR | GREY1
	.byte BOX,9,23,10,25
	.byte 9,27,15,28
	.byte 18,37,19,38
	.byte BOX_ADD,17,18,40	; 39
	.byte HLIN,9,12,26
	.byte 12,15,29
	.byte HLIN_ADD_LSAME,14 ; 12, 14, 30
	.byte HLIN,16,17,41
	.byte VLIN,28,30,10
	.byte 21,22,10
	.byte 23,26,14
	.byte 35,36,19
	.byte VLIN_ADD,33,34	; 20
	.byte PLOT,12,25
	.byte 14,31
	.byte SET_COLOR | RED
	.byte VLIN,25,27,9
	.byte PLOT,10,28
	.byte SET_COLOR | PINK
	.byte VLIN,39,41,35
	.byte SET_COLOR | YELLOW
	.byte HLIN,12,13,30
	.byte SET_COLOR | MEDIUM_BLUE
	.byte PLOT,21,6
	.byte END
; total size = 213
