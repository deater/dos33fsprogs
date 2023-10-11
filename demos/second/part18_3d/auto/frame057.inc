	.byte SET_COLOR | BROWN
	.byte BOX,12,17,35,41
	.byte 15,11,35,15
	.byte 16,7,35,10
	.byte HLIN,17,35,6
	.byte 18,35,16
	.byte SET_COLOR | GREEN
	.byte BOX,4,19,16,27
	.byte 33,19,35,35
	.byte 4,28,17,33
	.byte 19,32,25,33
	.byte 14,35,25,36
	.byte 4,36,11,38
	.byte 13,37,25,38
	.byte BOX_ADD_RSAME,4,40
	.byte HLIN,4,25,34
	.byte HLIN_ADD_LSAME,12 ; 4, 12, 35
	.byte HLIN,4,26,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,18,6,22,9
	.byte 8,6,9,12
	.byte 31,6,32,9
	.byte BOX_ADD,18,23,13	; 10
	.byte BOX,28,10,29,13
	.byte 8,16,14,17
	.byte 19,16,23,19
	.byte 33,16,34,19
	.byte 8,18,16,27
	.byte 19,20,24,28
	.byte 29,20,30,23
	.byte 8,28,17,29
	.byte BOX_ADD_RSAME,9,34
	.byte BOX,20,30,25,31
	.byte 30,30,31,34
	.byte 21,32,25,37
	.byte 8,36,11,41
	.byte 19,39,25,40
	.byte HLIN,8,10,13
	.byte HLIN_ADD,13,23	; 14
	.byte HLIN,8,11,14
	.byte HLIN_ADD_LSAME,23 ; 8, 23, 15
	.byte HLIN,20,24,29
	.byte 8,12,35
	.byte 20,25,38
	.byte 18,26,41
	.byte 31,32,41
	.byte PLOT,29,9
	.byte 31,10
	.byte 28,14
	.byte 34,15
	.byte 30,19
	.byte 33,20
	.byte 31,35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,7,15
	.byte BOX_ADD_LSAME,8,25 ; 4, 16
	.byte BOX,12,28,17,34
	.byte BOX_ADD,14,16,36	; 35
	.byte HLIN,6,8,26
	.byte HLIN_ADD_RSAME,7	; 7 8 27
	.byte VLIN,8,28,29
	.byte PLOT,4,26
	.byte SET_COLOR | PINK
	.byte BOX,11,18,16,25
	.byte BOX_ADD_RSAME,12,27
	.byte BOX,12,28,17,32
	.byte HLIN,12,14,33
	.byte HLIN_ADD_LSAME,13 ; 12, 13, 34
	.byte PLOT,12,35
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,8,35,9,36
	.byte 21,36,22,37
	.byte 8,37,10,38
	.byte 34,37,35,39
	.byte BOX_ADD,6,10,41	; 40
	.byte HLIN,34,35,35
	.byte HLIN_ADD_RSAME,33	; 33 35 36
	.byte HLIN,20,22,38
	.byte HLIN_ADD,7,10	; 39
	.byte HLIN,19,22,39
	.byte HLIN_ADD_LSAME,21 ; 19, 21, 40
	.byte HLIN,18,21,41
	.byte VLIN,9,33,34
	.byte 21,34,35
	.byte 35,40,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,15,12,16,13
	.byte 11,15,14,17
	.byte BOX_ADD,12,13,19	; 18
	.byte HLIN,13,17,14
	.byte HLIN_ADD_RSAME,11	; 11 17 15
	.byte PLOT,17,16
	.byte SET_COLOR | GREY1
	.byte HLIN,13,14,14
	.byte HLIN_ADD,11,15	; 15
	.byte 12,14	; 16
	.byte VLIN,11,14,15
	.byte PLOT,14,17
	.byte SET_COLOR | RED
	.byte HLIN,15,16,13
	.byte PLOT,17,14
	.byte 11,15
	.byte SET_COLOR | ORANGE
	.byte 13,14
	.byte END
; total size = 346
