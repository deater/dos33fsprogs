	.byte SET_COLOR | GREY2
	.byte BOX,8,30,34,34
	.byte HLIN,12,32,35
	.byte HLIN_ADD,15,31	; 36
	.byte HLIN_ADD_RSAME,18	; 18 31 37
	.byte HLIN,20,30,38
	.byte HLIN_ADD,23,29	; 39
	.byte HLIN_ADD_RSAME,26	; 26 29 40
	.byte SET_COLOR | BROWN
	.byte BOX,8,6,31,31
	.byte 12,33,24,34
	.byte HLIN,8,30,32
	.byte 20,24,35
	.byte HLIN_ADD_RSAME,23	; 23 24 36
	.byte SET_COLOR | GREY1
	.byte BOX,17,20,30,22
	.byte 21,22,30,23
	.byte 31,25,35,29
	.byte 17,18,19,19
	.byte HLIN,22,30,19
	.byte 23,30,24
	.byte 10,11,33
	.byte HLIN_ADD_LSAME,15 ; 10, 15, 34
	.byte 11
	.byte HLIN,8,11,39
	.byte HLIN_ADD_LSAME,14 ; 8, 14, 40
	.byte 16
	.byte HLIN,8,9,38
	.byte VLIN,30,33,35
	.byte 36,37,32
	.byte PLOT,8,34
	.byte 34,34
	.byte 33,35
	.byte 14,36
	.byte 17,37
	.byte 31,38
	.byte 30,39
	.byte SET_COLOR | WHITE
	.byte BOX,25,6,30,21
	.byte 4,6,7,41
	.byte 25,23,30,24
	.byte BOX_ADD_LSAME,29,33 ; 25, 25
	.byte BOX,31,25,35,28
	.byte 32,6,35,24
	.byte HLIN,21,30,22
	.byte 31,34,29
	.byte HLIN_ADD_LSAME,33 ; 31, 33, 30
	.byte 32
	.byte HLIN,25,27,34
	.byte HLIN_ADD_LSAME,26 ; 25, 26, 35
	.byte PLOT,25,36
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,19,23,21
	.byte HLIN_ADD,21,25	; 22
	.byte HLIN,17,19,22
	.byte HLIN_ADD_RSAME,18	; 18 19 23
	.byte HLIN,21,22,23
	.byte VLIN,20,23,25
	.byte SET_COLOR | RED
	.byte HLIN,17,18,20
	.byte PLOT,19,21
	.byte 25,22
	.byte SET_COLOR | ORANGE
	.byte HLIN,21,22,21
	.byte PLOT,22,22
	.byte END
; total size = 193
