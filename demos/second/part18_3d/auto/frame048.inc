	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,28,27
	.byte 4,33,21,41
	.byte 4,28,20,32
	.byte SET_COLOR | BROWN
	.byte 19,8,32,23
	.byte BOX_ADD,20,31,25	; 24
	.byte HLIN,20,27,6
	.byte HLIN_ADD,21,24	; 7
	.byte HLIN,27,29,7
	.byte 20,29,26
	.byte HLIN_ADD_LSAME,28 ; 20, 28, 27
	.byte 26
	.byte 25
	.byte HLIN,21,23,30
	.byte PLOT,29,6
	.byte 21,31
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,22,7
	.byte BOX_ADD_LSAME,21,13 ; 4, 8
	.byte 26,18
	.byte 20,20
	.byte HLIN,4,19,21
	.byte HLIN_ADD_LSAME,18 ; 4, 18, 22
	.byte 15
	.byte 12
	.byte 9
	.byte 7
	.byte PLOT,27,7
	.byte 4,27
	.byte SET_COLOR | GREEN
	.byte BOX,23,12,26,13
	.byte BOX_ADD_RSAME,21,18
	.byte HLIN,24,25,11
	.byte 33,34,25
	.byte HLIN_ADD,32,35	; 26
	.byte HLIN_ADD_RSAME,30	; 30 35 27
	.byte 29	; 29 35 28
	.byte 27	; 27 35 29
	.byte 25	; 25 35 30
	.byte 24	; 24 35 31
	.byte 22	; 22 35 32
	.byte HLIN,21,34,33
	.byte HLIN_ADD_LSAME,33 ; 21, 33, 34
	.byte 31
	.byte HLIN,22,29,36
	.byte HLIN_ADD_LSAME,27 ; 22, 27, 37
	.byte 25
	.byte 24
	.byte PLOT,22,40
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,30,6,35,9
	.byte BOX_ADD_RSAME,31,15
	.byte 32,19	; 35 16
	.byte HLIN,32,34,20
	.byte PLOT,32,21
	.byte SET_COLOR | GREY1
	.byte HLIN,26,27,6
	.byte 32,34,22
	.byte HLIN_ADD_RSAME,33	; 33 34 23
	.byte HLIN,32,33,24
	.byte 33,35,39
	.byte HLIN_ADD_RSAME,31	; 31 35 40
	.byte 29	; 29 35 41
	.byte PLOT,33,21
	.byte 31,25
	.byte 35,38
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,24,16,26,17
	.byte BOX_ADD_RSAME,23,19
	.byte BOX,23,20,25,21
	.byte HLIN,25,26,15
	.byte VLIN,26,13,14
	.byte SET_COLOR | PINK
	.byte 21,13,16
	.byte VLIN_ADD,19,24	; 22
	.byte 25,30	; 23
	.byte PLOT,21,18
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,25,21,27
	.byte VLIN,20,18,20
	.byte 35,6,10
	.byte PLOT,20,28
	.byte SET_COLOR | ORANGE
	.byte VLIN,25,21,25
	.byte VLIN_ADD,26,28	; 26
	.byte END
; total size = 226
