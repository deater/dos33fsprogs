	.byte SET_COLOR | PINK
	.byte BOX,16,21,25,41
	.byte 17,16,25,20
	.byte 18,12,24,14
	.byte 19,6,23,10
	.byte HLIN,18,25,15
	.byte 18,23,11
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,33,7,35,9
	.byte BOX_ADD_RSAME,32,12
	.byte 31,16	; 35 13
	.byte 30,19	; 35 17
	.byte 29,22	; 35 20
	.byte 28,25	; 35 23
	.byte 27,28	; 35 26
	.byte 26,41	; 35 29
	.byte PLOT,34,6
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,11,8,16
	.byte BOX_ADD_LSAME,7,34 ; 4, 17
	.byte 16,37
	.byte BOX,9,35,16,39
	.byte 4,38,7,39
	.byte HLIN,4,7,10
	.byte 4,12,40
	.byte HLIN_ADD_LSAME,15 ; 4, 15, 41
	.byte VLIN,35,6,7
	.byte PLOT,5,9
	.byte SET_COLOR | GREY1
	.byte BOX,5,31,7,34
	.byte 13,33,15,34
	.byte BOX_ADD_RSAME,5,37
	.byte 10,39	; 15 38
	.byte HLIN,13,14,32
	.byte 9,11,34
	.byte 9,15,38
	.byte VLIN,13,30,31
	.byte SET_COLOR | WHITE
	.byte BOX,6,26,7,33
	.byte 5,37,7,41
	.byte VLIN,4,6,9
	.byte 7,17,25
	.byte VLIN_ADD,11,16	; 8
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,12,36,13,37
	.byte 5,37,7,38
	.byte BOX_ADD_RSAME,6,40
	.byte BOX,15,39,16,40
	.byte HLIN,15,16,37
	.byte HLIN_ADD_RSAME,10	; 10 16 38
	.byte HLIN,10,13,39
	.byte VLIN,6,29,33
	.byte VLIN_ADD,34,36	; 7
	.byte VLIN,16,29,36
	.byte PLOT,12,35
	.byte 7,41
	.byte SET_COLOR | BROWN
	.byte VLIN,16,21,35
	.byte SET_COLOR | RED
	.byte 5,35,36
	.byte VLIN_ADD,37,38	; 6
	.byte VLIN,16,39,40
	.byte PLOT,15,41
	.byte SET_COLOR | YELLOW
	.byte HLIN,10,12,39
	.byte 10,11,38
	.byte END
; total size = 206
