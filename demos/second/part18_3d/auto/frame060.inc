	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,8,7,35,40
	.byte HLIN,17,35,6
	.byte 13,21,41
	.byte 8,10,6
	.byte PLOT,10,41
	.byte SET_COLOR | BROWN
	.byte BOX,17,6,18,12
	.byte 25,7,33,9
	.byte 25,11,29,13
	.byte 13,13,19,41
	.byte 26,14,29,17
	.byte BOX_ADD_LSAME,33,29 ; 26, 18
	.byte BOX,13,29,20,41
	.byte 27,30,33,38
	.byte 32,10,33,16
	.byte HLIN,25,34,6
	.byte 25,30,10
	.byte 26,33,39
	.byte HLIN_ADD,24,34	; 40
	.byte 27,33	; 41
	.byte HLIN,31,33,17
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,7,12
	.byte 4,14,17,17
	.byte BOX_ADD_LSAME,8,35 ; 4, 18
	.byte 17,37
	.byte 9,41
	.byte BOX,15,24,17,27
	.byte HLIN,4,8,13
	.byte SET_COLOR | GREEN
	.byte BOX,33,16,35,17
	.byte 31,19,35,37
	.byte 10,31,19,32
	.byte BOX_ADD_LSAME,20,34 ; 10, 33
	.byte 19,37
	.byte BOX,11,38,19,40
	.byte 30,38,35,41
	.byte 34,14,35,15
	.byte HLIN,32,35,18
	.byte 16,18,27
	.byte HLIN_ADD_RSAME,15	; 15 18 28
	.byte HLIN,12,19,29
	.byte HLIN_ADD_RSAME,11	; 11 19 30
	.byte HLIN,17,18,26
	.byte PLOT,35,13
	.byte 17,25
	.byte 11,41
	.byte SET_COLOR | PINK
	.byte BOX,11,12,17,17
	.byte BOX_ADD_RSAME,12,23
	.byte BOX,11,7,16,11
	.byte HLIN,12,13,24
	.byte VLIN,25,28,12
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,16,33,20,34
	.byte BOX_ADD,15,19,36	; 35
	.byte BOX_ADD_RSAME,14,38
	.byte 12,40	; 19 39
	.byte BOX,18,29,19,31
	.byte HLIN,14,20,41
	.byte 17,19,32
	.byte PLOT,18,28
	.byte SET_COLOR | GREY1
	.byte BOX,8,14,13,15
	.byte 12,13,13,15
	.byte HLIN,9,13,16
	.byte 22,25,41
	.byte 24,26,40
	.byte VLIN,13,14,8
	.byte PLOT,26,39
	.byte 20,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,9,16,10,17
	.byte HLIN,12,13,15
	.byte PLOT,9,15
	.byte 13,16
	.byte SET_COLOR | RED
	.byte HLIN,12,13,14
	.byte PLOT,8,14
	.byte SET_COLOR | ORANGE
	.byte 10,14
	.byte 13,41
	.byte END
; total size = 270
