	.byte SET_COLOR | BROWN
	.byte BOX,14,10,35,41
	.byte 21,6,35,9
	.byte SET_COLOR | GREEN
	.byte 12,26,15,27
	.byte BOX_ADD,4,21,41	; 28
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,16,29,22,31
	.byte 14,33,19,34
	.byte 22,34,23,37
	.byte BOX_ADD_RSAME,21,39
	.byte HLIN,15,22,32
	.byte 14,18,35
	.byte HLIN_ADD_RSAME,13	; 13 18 36
	.byte 12	; 12 18 37
	.byte 11	; 11 18 38
	.byte 10	; 10 18 39
	.byte HLIN,9,17,40
	.byte 20,23,40
	.byte HLIN_ADD,8,17	; 41
	.byte HLIN,19,23,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,33,6,35,7
	.byte 6,6,7,16
	.byte 15,9,21,16
	.byte 29,9,30,12
	.byte 16,17,21,19
	.byte 6,17,8,21
	.byte 31,19,32,23
	.byte 17,20,21,23
	.byte 6,22,13,25
	.byte 28,22,29,25
	.byte 17,24,22,29
	.byte BOX_ADD_RSAME,18,32
	.byte BOX,32,30,33,34
	.byte 29,32,30,36
	.byte HLIN,15,16,8
	.byte 34,35,8
	.byte 6,12,26
	.byte HLIN_ADD_LSAME,11 ; 6, 11, 27
	.byte 10
	.byte 9
	.byte 8
	.byte HLIN,33,35,41
	.byte VLIN,7,31,32
	.byte 19,33,34
	.byte 23,34,35
	.byte 23,40,41
	.byte 26,6,7
	.byte VLIN_ADD,12,17	; 27
	.byte VLIN,35,15,20
	.byte PLOT,30,8
	.byte 29,13
	.byte 32,18
	.byte 28,26
	.byte 33,29
	.byte 22,33
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,5,14
	.byte BOX_ADD_LSAME,6,33 ; 4, 15
	.byte HLIN,4,5,34
	.byte PLOT,4,35
	.byte SET_COLOR | PINK
	.byte BOX,9,22,13,25
	.byte HLIN,11,13,21
	.byte 9,12,26
	.byte HLIN_ADD_LSAME,11 ; 9, 11, 27
	.byte 10
	.byte PLOT,9,29
	.byte SET_COLOR | GREY1
	.byte BOX,15,11,21,13
	.byte 15,11,16,16
	.byte HLIN,19,21,9
	.byte HLIN_ADD_RSAME,17	; 17 21 10
	.byte VLIN,15,9,16
	.byte VLIN_ADD,16,17	; 16
	.byte VLIN,21,14,15
	.byte PLOT,18,14
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,20,9,21,12
	.byte 15,11,16,14
	.byte HLIN,15,16,16
	.byte VLIN,20,7,9
	.byte PLOT,21,13
	.byte 15,15
	.byte SET_COLOR | RED
	.byte VLIN,15,11,12
	.byte PLOT,20,9
	.byte 21,10
	.byte SET_COLOR | ORANGE
	.byte 18,10
	.byte END
; total size = 277
