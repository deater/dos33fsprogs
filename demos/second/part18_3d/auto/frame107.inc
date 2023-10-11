	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,35,23
	.byte 6,26,35,27
	.byte 6,40,35,41
	.byte 6,37,34,39
	.byte 6,33,33,36
	.byte 6,30,32,32
	.byte 7,28,31,29
	.byte 34,28,35,32
	.byte HLIN,12,35,25
	.byte 16,35,24
	.byte SET_COLOR | BROWN
	.byte BOX,9,6,27,21
	.byte 13,26,14,27
	.byte 21,33,26,34
	.byte HLIN,9,25,22
	.byte 21,24,24
	.byte HLIN_ADD_RSAME,18	; 18 24 25
	.byte HLIN,9,14,27
	.byte 25,26,31
	.byte 13,16,35
	.byte HLIN_ADD,11,17	; 36
	.byte VLIN,9,28,38
	.byte 16,25,34
	.byte VLIN_ADD,37,41	; 17
	.byte VLIN,25,26,30
	.byte VLIN_ADD,35,36	; 26
	.byte 37,41	; 27
	.byte PLOT,26,32
	.byte SET_COLOR | PINK
	.byte BOX,9,6,20,22
	.byte 24,6,33,9
	.byte BOX_ADD_RSAME,23,15
	.byte BOX,23,16,32,21
	.byte BOX_ADD_RSAME,31,24
	.byte HLIN,23,25,22
	.byte HLIN_ADD,9,19	; 23
	.byte HLIN,21,23,25
	.byte HLIN_ADD,18,21	; 26
	.byte 12,14	; 27
	.byte 9,12	; 28
	.byte HLIN,23,25,34
	.byte HLIN_ADD,21,22	; 35
	.byte HLIN,11,15,37
	.byte VLIN,32,25,27
	.byte PLOT,15,36
	.byte 9,38
	.byte 11,38
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,8,14,23
	.byte BOX_ADD_LSAME,7,25 ; 4, 24
	.byte 6,30
	.byte 5,41
	.byte HLIN,7,14,6
	.byte HLIN_ADD_RSAME,6	; 6 14 7
	.byte SET_COLOR | GREY1
	.byte BOX,6,7,8,9
	.byte BOX_ADD_RSAME,7,17
	.byte BOX,8,19,10,21
	.byte 12,19,13,21
	.byte BOX_ADD,8,15,23	; 22
	.byte BOX_ADD_LSAME,9,25 ; 8, 24
	.byte HLIN,7,9,18
	.byte VLIN,33,26,29
	.byte VLIN_ADD,30,32	; 34
	.byte 33,36	; 35
	.byte PLOT,7,6
	.byte SET_COLOR | LIGHT_BLUE
	.byte VLIN,10,19,22
	.byte VLIN_ADD,23,25	; 11
	.byte VLIN,14,17,18
	.byte VLIN_ADD,19,24	; 15
	.byte SET_COLOR | RED
	.byte PLOT,11,24
	.byte SET_COLOR | YELLOW
	.byte 13,23
	.byte END
; total size = 243
