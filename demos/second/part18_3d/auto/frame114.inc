	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,12,23,41
	.byte SET_COLOR | BROWN
	.byte 24,6,35,21
	.byte BOX_ADD_RSAME,18,29
	.byte 19,41	; 35 30
	.byte SET_COLOR | ORANGE
	.byte BOX,24,6,28,9
	.byte 26,11,28,12
	.byte BOX_ADD_RSAME,27,14
	.byte BOX,20,25,35,26
	.byte BOX_ADD,21,33,29	; 27
	.byte BOX,23,31,31,33
	.byte HLIN,25,28,10
	.byte 27,29,16
	.byte HLIN_ADD,25,30	; 17
	.byte 24,31	; 18
	.byte HLIN_ADD_RSAME,22	; 22 31 19
	.byte HLIN,21,32,20
	.byte HLIN_ADD,19,33	; 21
	.byte 18,34	; 22
	.byte HLIN_ADD_RSAME,19	; 19 34 23
	.byte HLIN,19,35,24
	.byte 22,31,30
	.byte 24,30,34
	.byte PLOT,28,15
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,8,23,11
	.byte 4,39,5,41
	.byte HLIN,4,26,6
	.byte HLIN_ADD_LSAME,24 ; 4, 24, 7
	.byte HLIN,4,22,12
	.byte HLIN_ADD_LSAME,21 ; 4, 21, 13
	.byte 19
	.byte 17
	.byte 15
	.byte 14
	.byte 12
	.byte 10
	.byte 8
	.byte 7
	.byte 5
	.byte VLIN,32,38,4
	.byte SET_COLOR | PINK
	.byte BOX,24,35,34,41
	.byte HLIN,34,35,27
	.byte HLIN_ADD_RSAME,33	; 33 35 28
	.byte HLIN,32,34,29
	.byte HLIN_ADD_RSAME,30	; 30 34 30
	.byte 29	; 29 34 31
	.byte 28	; 28 34 32
	.byte 26	; 26 34 33
	.byte 25	; 25 34 34
	.byte PLOT,35,26
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,10,16,9
	.byte HLIN_ADD_LSAME,17 ; 10, 17, 10
	.byte HLIN,13,17,11
	.byte HLIN_ADD_RSAME,14	; 14 17 12
	.byte VLIN,6,11,11
	.byte 13,15,16
	.byte SET_COLOR | GREY1
	.byte BOX,12,9,14,10
	.byte HLIN,13,15,11
	.byte HLIN_ADD,14,16	; 12
	.byte VLIN,8,10,16
	.byte PLOT,13,8
	.byte SET_COLOR | RED
	.byte VLIN,6,8,10
	.byte VLIN_ADD,9,10	; 11
	.byte PLOT,17,13
	.byte 16,14
	.byte SET_COLOR | YELLOW
	.byte HLIN,13,14,11
	.byte PLOT,14,12
	.byte END
; total size = 203
