	.byte SET_COLOR | BROWN
	.byte BOX,19,6,35,27
	.byte HLIN,19,34,28
	.byte HLIN_ADD_LSAME,33 ; 19, 33, 29
	.byte 31
	.byte 29
	.byte 27
	.byte 25
	.byte 24
	.byte 22
	.byte HLIN,20,21,36
	.byte SET_COLOR | GREEN
	.byte BOX,25,14,28,15
	.byte 23,17,29,19
	.byte 20,38,35,41
	.byte HLIN,26,27,13
	.byte 24,28,16
	.byte 34,35,30
	.byte HLIN_ADD_RSAME,32	; 32 35 31
	.byte 30	; 30 35 32
	.byte 28	; 28 35 33
	.byte 27	; 27 35 34
	.byte 25	; 25 35 35
	.byte 23	; 23 35 36
	.byte 21	; 21 35 37
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,18,28
	.byte BOX_ADD_LSAME,19,32 ; 4, 29
	.byte 18,35
	.byte 19,41
	.byte HLIN,26,30,6
	.byte HLIN_ADD_LSAME,27 ; 26, 27, 7
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,22,11
	.byte 4,13,21,14
	.byte 4,16,19,26
	.byte HLIN,4,20,12
	.byte 4,20,15
	.byte 4,15,27
	.byte HLIN_ADD_LSAME,13 ; 4, 13, 28
	.byte 10
	.byte 8
	.byte 5
	.byte PLOT,28,7
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,24,20,29,22
	.byte HLIN,27,29,17
	.byte HLIN_ADD_RSAME,26	; 26 29 18
	.byte 25	; 25 29 19
	.byte HLIN,24,27,23
	.byte HLIN_ADD_LSAME,25 ; 24, 25, 24
	.byte HLIN,18,19,26
	.byte VLIN,19,21,25
	.byte 28,15,16
	.byte PLOT,18,27
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,33,6,35,12
	.byte BOX_ADD_RSAME,34,18
	.byte VLIN,35,19,24
	.byte SET_COLOR | PINK
	.byte 22,7,12
	.byte VLIN_ADD,13,18	; 23
	.byte 21,25	; 24
	.byte 26,31	; 25
	.byte 32,33	; 26
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,21,20,22,22
	.byte 22,27,23,30
	.byte VLIN,19,29,32
	.byte 21,13,14
	.byte PLOT,21,19
	.byte SET_COLOR | ORANGE
	.byte VLIN,27,23,25
	.byte VLIN_ADD,26,31	; 28
	.byte SET_COLOR | GREY1
	.byte HLIN,24,26,6
	.byte END
; total size = 198
