	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,29,28,41
	.byte 4,6,28,17
	.byte 4,23,22,28
	.byte 4,18,21,22
	.byte SET_COLOR | BROWN
	.byte 21,6,26,8
	.byte 21,7,31,16
	.byte HLIN,21,29,17
	.byte HLIN_ADD_LSAME,27 ; 21, 27, 18
	.byte 26
	.byte 24
	.byte HLIN,22,23,21
	.byte PLOT,29,6
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,21,8
	.byte BOX_ADD_LSAME,20,14 ; 4, 9
	.byte HLIN,4,17,15
	.byte HLIN_ADD_LSAME,14 ; 4, 14, 16
	.byte 12
	.byte 9
	.byte 7
	.byte 5
	.byte SET_COLOR | GREY1
	.byte BOX,32,13,33,14
	.byte 23,29,35,33
	.byte BOX_ADD_RSAME,22,35
	.byte 21,37	; 35 36
	.byte 20,39	; 35 38
	.byte 19,41	; 35 40
	.byte HLIN,32,35,11
	.byte HLIN_ADD_LSAME,34 ; 32, 34, 12
	.byte HLIN,34,35,23
	.byte HLIN_ADD_RSAME,32	; 32 35 24
	.byte 30	; 30 35 25
	.byte 29	; 29 35 26
	.byte 27	; 27 35 27
	.byte 25	; 25 35 28
	.byte PLOT,32,15
	.byte SET_COLOR | GREEN
	.byte BOX,22,7,26,11
	.byte HLIN,23,26,6
	.byte 32,33,17
	.byte HLIN_ADD_RSAME,30	; 30 33 18
	.byte 28	; 28 33 19
	.byte HLIN,27,32,20
	.byte HLIN_ADD_RSAME,26	; 26 32 21
	.byte HLIN,24,31,22
	.byte HLIN_ADD,22,30	; 23
	.byte HLIN_ADD_LSAME,28 ; 22, 28, 24
	.byte 26
	.byte HLIN,23,24,26
	.byte PLOT,33,16
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,31,6,35,10
	.byte HLIN,32,34,11
	.byte PLOT,32,12
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,24,7,26,8
	.byte BOX_ADD_RSAME,23,11
	.byte HLIN,23,24,12
	.byte PLOT,23,13
	.byte SET_COLOR | PINK
	.byte HLIN_ADD,22,23	; 14
	.byte VLIN,22,11,13
	.byte VLIN_ADD,15,18	; 23
	.byte 19,20	; 24
	.byte VLIN,30,6,9
	.byte VLIN_ADD,10,14	; 31
	.byte SET_COLOR | ORANGE
	.byte VLIN,25,12,16
	.byte VLIN_ADD,17,19	; 26
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,21,15,18
	.byte 21,10,11
	.byte END
; total size = 204