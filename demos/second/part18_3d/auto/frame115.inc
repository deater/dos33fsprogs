	.byte SET_COLOR | BROWN
	.byte BOX,19,6,35,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,10,22,27
	.byte BOX_ADD_LSAME,18,41 ; 4, 28
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,24,8
	.byte 4,14,14,17
	.byte HLIN,4,22,9
	.byte HLIN_ADD_LSAME,21 ; 4, 21, 10
	.byte 20
	.byte 18
	.byte 17
	.byte HLIN,4,10,18
	.byte HLIN_ADD_LSAME,9 ; 4, 9, 19
	.byte 7
	.byte 6
	.byte 5
	.byte PLOT,4,23
	.byte SET_COLOR | ORANGE
	.byte BOX,24,9,29,10
	.byte 26,12,29,13
	.byte BOX_ADD_RSAME,27,15
	.byte 28,17	; 29 16
	.byte BOX,19,25,35,27
	.byte BOX_ADD_RSAME,20,30
	.byte 21,32	; 35 31
	.byte BOX,22,33,34,34
	.byte BOX_ADD,23,33,36	; 35
	.byte 24,32,38	; 37
	.byte 25,31,41	; 39
	.byte HLIN,25,29,6
	.byte HLIN_ADD_RSAME,24	; 24 29 7
	.byte 23	; 23 29 8
	.byte HLIN,25,29,11
	.byte 27,30,18
	.byte HLIN_ADD_RSAME,26	; 26 30 19
	.byte HLIN,25,31,20
	.byte HLIN_ADD,24,32	; 21
	.byte 23,33	; 22
	.byte HLIN_ADD_RSAME,22	; 22 33 23
	.byte HLIN,21,34,24
	.byte SET_COLOR | PINK
	.byte 34,35,34
	.byte HLIN_ADD_RSAME,33	; 33 35 35
	.byte 32	; 32 35 36
	.byte 31	; 31 35 37
	.byte 30	; 30 35 38
	.byte 29	; 29 35 39
	.byte 28	; 28 35 40
	.byte 27	; 27 35 41
	.byte VLIN,32,33,35
	.byte SET_COLOR | GREY1
	.byte BOX,10,13,13,14
	.byte BOX_ADD,12,16,17	; 15
	.byte BOX_ADD_RSAME,15,19
	.byte HLIN,10,11,12
	.byte 15,16,14
	.byte VLIN,13,16,10
	.byte 9,11,10
	.byte 12,13,15
	.byte 20,21,15
	.byte SET_COLOR | RED
	.byte 13,15,10
	.byte PLOT,16,19
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,15,16,18
	.byte PLOT,14,16
	.byte 16,17
	.byte SET_COLOR | YELLOW
	.byte VLIN,16,17,13
	.byte SET_COLOR | WHITE
	.byte PLOT,16,18
	.byte END
; total size = 192
