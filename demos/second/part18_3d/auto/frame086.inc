	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,15,41
	.byte SET_COLOR | GREY1
	.byte 14,6,35,9
	.byte 15,12,35,14
	.byte 23,18,35,21
	.byte 25,27,35,32
	.byte 15,30,19,31
	.byte BOX_ADD,14,18,33	; 32
	.byte BOX,26,33,35,37
	.byte 12,35,18,36
	.byte BOX_ADD_RSAME,11,38
	.byte BOX,27,38,35,41
	.byte 9,40,18,41
	.byte 16,20,19,29
	.byte HLIN,20,35,15
	.byte 15,18,15
	.byte HLIN_ADD_LSAME,35 ; 15, 35, 16
	.byte 21
	.byte 17
	.byte HLIN,24,35,22
	.byte HLIN_ADD_LSAME,27 ; 24, 27, 23
	.byte HLIN,27,29,25
	.byte HLIN_ADD,24,35	; 26
	.byte HLIN,13,18,34
	.byte 10,18,39
	.byte HLIN_ADD,20,22	; 40
	.byte HLIN,18,19,19
	.byte SET_COLOR | GREEN
	.byte BOX,24,6,35,15
	.byte BOX_ADD_RSAME,25,18
	.byte BOX,30,20,35,27
	.byte BOX_ADD_RSAME,31,30
	.byte 32,32	; 35 31
	.byte 33,34	; 35 33
	.byte 34,36	; 35 35
	.byte HLIN,29,35,19
	.byte VLIN,37,39,35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,26,6,28,11
	.byte 34,6,35,11
	.byte 22,6,23,7
	.byte BOX_ADD_RSAME,14,9
	.byte 15,11	; 23 10
	.byte BOX,27,12,28,18
	.byte 15,12,16,17
	.byte 22,14,24,15
	.byte 22,12,23,13
	.byte HLIN,18,20,7
	.byte VLIN,12,34,35
	.byte 10,16,18
	.byte 10,16,20
	.byte 6,7,14
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,17,10,21,11
	.byte HLIN,20,22,41
	.byte VLIN,8,9,17
	.byte 8,9,21
	.byte PLOT,19,9
	.byte SET_COLOR | RED
	.byte 17,11
	.byte 21,11
	.byte SET_COLOR | ORANGE
	.byte 19,10
	.byte SET_COLOR | YELLOW
	.byte 19,11
	.byte END
; total size = 210
