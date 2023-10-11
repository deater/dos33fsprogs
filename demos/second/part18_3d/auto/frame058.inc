	.byte SET_COLOR | BROWN
	.byte BOX,13,15,35,41
	.byte 16,6,35,7
	.byte BOX_ADD_RSAME,17,14
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,8,6,10,14
	.byte 19,7,23,14
	.byte 28,7,29,10
	.byte 33,14,34,17
	.byte 8,15,16,21
	.byte 19,15,24,20
	.byte 29,17,30,21
	.byte 20,21,24,25
	.byte 8,22,17,30
	.byte 20,26,25,29
	.byte 30,28,34,30
	.byte BOX_ADD_RSAME,31,33
	.byte BOX,15,32,25,33
	.byte 8,32,12,33
	.byte BOX_ADD_LSAME,25,37 ; 8, 34
	.byte 26,41
	.byte BOX,31,40,34,41
	.byte HLIN,18,23,6
	.byte 32,33,6
	.byte 19,25,30
	.byte HLIN_ADD_RSAME,8	; 8 25 31
	.byte PLOT,29,6
	.byte 32,7
	.byte 28,11
	.byte 34,13
	.byte 29,22
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,7,13
	.byte BOX_ADD_LSAME,8,30 ; 4, 14
	.byte BOX,12,22,17,31
	.byte 4,31,9,41
	.byte 15,32,16,33
	.byte SET_COLOR | GREEN
	.byte 34,17,35,18
	.byte 32,20,35,35
	.byte 17,32,20,33
	.byte 12,35,21,38
	.byte BOX_ADD,11,20,41	; 39
	.byte HLIN,33,35,19
	.byte 18,19,31
	.byte 13,20,34
	.byte VLIN,35,15,16
	.byte PLOT,19,30
	.byte SET_COLOR | PINK
	.byte BOX,11,15,16,20
	.byte 12,22,17,29
	.byte HLIN,14,16,14
	.byte 12,16,21
	.byte 12,16,30
	.byte HLIN_ADD_LSAME,13 ; 12, 13, 31
	.byte VLIN,12,32,35
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,4,34,5,38
	.byte 20,35,21,36
	.byte 32,36,35,39
	.byte 4,39,6,41
	.byte 17,40,20,41
	.byte 33,40,35,41
	.byte HLIN,19,21,37
	.byte HLIN_ADD_RSAME,18	; 18 21 38
	.byte HLIN,18,20,39
	.byte VLIN,4,31,33
	.byte 20,33,34
	.byte PLOT,35,35
	.byte SET_COLOR | GREY1
	.byte BOX,10,15,15,17
	.byte HLIN,14,15,14
	.byte VLIN,14,13,14
	.byte PLOT,10,14
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN_ADD,14,15	; 15
	.byte HLIN,10,11,17
	.byte HLIN_ADD_LSAME,12 ; 10, 12, 18
	.byte HLIN,11,12,19
	.byte VLIN,15,16,18
	.byte PLOT,10,16
	.byte SET_COLOR | RED
	.byte 14,14
	.byte 10,15
	.byte 15,15
	.byte SET_COLOR | ORANGE
	.byte 12,15
	.byte END
; total size = 285
