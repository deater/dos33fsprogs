	.byte SET_COLOR | WHITE
	.byte BOX,4,6,35,33
	.byte 4,35,7,40
	.byte HLIN,4,27,34
	.byte HLIN_ADD,10,26	; 35
	.byte HLIN,4,16,41
	.byte 14,25,36
	.byte SET_COLOR | BROWN
	.byte BOX,8,6,24,19
	.byte BOX_ADD_LSAME,25,23 ; 8, 20
	.byte 24,34
	.byte BOX,20,35,24,36
	.byte HLIN,30,31,32
	.byte VLIN,30,25,31
	.byte VLIN_ADD,6,24	; 31
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,17,20,25,22
	.byte HLIN,21,25,23
	.byte 18,19,23
	.byte SET_COLOR | GREY1
	.byte BOX,17,18,19,19
	.byte 23,23,24,24
	.byte HLIN,22,24,19
	.byte HLIN_ADD_RSAME,17	; 17 24 20
	.byte HLIN,17,19,21
	.byte 34,35,30
	.byte HLIN_ADD_RSAME,33	; 33 35 31
	.byte 31	; 31 35 32
	.byte 30	; 30 35 33
	.byte HLIN,8,11,33
	.byte HLIN_ADD_LSAME,15 ; 8, 15, 34
	.byte HLIN,28,34,34
	.byte HLIN_ADD,10,19	; 35
	.byte HLIN,27,33,35
	.byte HLIN_ADD,14,22	; 36
	.byte HLIN,26,32,36
	.byte HLIN_ADD_RSAME,17	; 17 32 37
	.byte HLIN,20,31,38
	.byte 8,9,38
	.byte HLIN_ADD,23,30	; 39
	.byte HLIN,8,11,39
	.byte HLIN_ADD_LSAME,14 ; 8, 14, 40
	.byte HLIN,26,29,40
	.byte HLIN_ADD,8,16	; 41
	.byte PLOT,24,21
	.byte 20,22
	.byte 35,29
	.byte SET_COLOR | RED
	.byte HLIN,17,18,20
	.byte PLOT,19,21
	.byte 25,22
	.byte SET_COLOR | ORANGE
	.byte HLIN,21,22,21
	.byte PLOT,22,22
	.byte END
; total size = 166
