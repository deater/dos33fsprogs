	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,29,31,41
	.byte 4,6,31,16
	.byte BOX_ADD_LSAME,21,28 ; 4, 17
	.byte SET_COLOR | GREY1
	.byte BOX,27,10,34,14
	.byte 23,29,35,31
	.byte BOX_ADD_RSAME,22,33
	.byte 21,35	; 35 34
	.byte 20,37	; 35 36
	.byte BOX,18,39,35,40
	.byte HLIN,27,29,6
	.byte HLIN_ADD,17,35	; 7
	.byte HLIN,34,35,23
	.byte HLIN_ADD_RSAME,32	; 32 35 24
	.byte 30	; 30 35 25
	.byte 28	; 28 35 26
	.byte 26	; 26 35 27
	.byte 24	; 24 35 28
	.byte HLIN,19,35,38
	.byte 17,35,41
	.byte SET_COLOR | BROWN
	.byte BOX,21,7,24,9
	.byte 28,7,31,9
	.byte BOX_ADD,20,32,15	; 10
	.byte HLIN,21,26,6
	.byte 20,31,16
	.byte HLIN_ADD_LSAME,29 ; 20, 29, 17
	.byte HLIN,21,27,18
	.byte HLIN_ADD_LSAME,26 ; 21, 26, 19
	.byte 24
	.byte 22
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,21,11
	.byte BOX_ADD_LSAME,19,14 ; 4, 12
	.byte HLIN,4,17,15
	.byte HLIN_ADD_LSAME,15 ; 4, 15, 16
	.byte 13
	.byte 11
	.byte 8
	.byte 6
	.byte PLOT,4,21
	.byte SET_COLOR | GREEN
	.byte BOX,24,10,27,11
	.byte HLIN,23,26,6
	.byte 22,24,8
	.byte 24,26,12
	.byte 33,34,16
	.byte HLIN_ADD_RSAME,32	; 32 34 17
	.byte HLIN,30,33,18
	.byte HLIN_ADD_RSAME,28	; 28 33 19
	.byte 27	; 27 33 20
	.byte 25	; 25 33 21
	.byte HLIN,24,31,22
	.byte HLIN_ADD,22,29	; 23
	.byte HLIN_ADD_LSAME,27 ; 22, 27, 24
	.byte 26
	.byte 24
	.byte PLOT,24,7
	.byte 24,9
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,32,6,35,11
	.byte HLIN,32,33,12
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,21,9,22,10
	.byte 22,15,23,17
	.byte PLOT,22,8
	.byte 21,11
	.byte 23,14
	.byte 22,18
	.byte SET_COLOR | PINK
	.byte VLIN,23,6,7
	.byte VLIN_ADD,13,14	; 24
	.byte 15,19	; 25
	.byte SET_COLOR | ORANGE
	.byte 12,14	; 26
	.byte 15,18	; 27
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,25,10,27,11
	.byte PLOT,25,12
	.byte SET_COLOR | RED
	.byte HLIN,25,26,6
	.byte SET_COLOR | YELLOW
	.byte PLOT,29,6
	.byte END
; total size = 220
