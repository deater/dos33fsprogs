	.byte SET_COLOR | GREEN
	.byte BOX,24,6,33,17
	.byte BOX_ADD_RSAME,29,30
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,14,6,23,12
	.byte 32,6,35,15
	.byte 26,6,27,18
	.byte 33,16,35,25
	.byte BOX_ADD_RSAME,34,30
	.byte HLIN,15,18,13
	.byte 20,22,13
	.byte HLIN_ADD,15,21	; 14
	.byte HLIN_ADD_LSAME,19 ; 15, 19, 15
	.byte HLIN,15,20,18
	.byte HLIN_ADD_LSAME,22 ; 15, 22, 19
	.byte HLIN,26,35,31
	.byte 15,17,16
	.byte PLOT,20,17
	.byte SET_COLOR | GREY1
	.byte BOX,23,15,28,16
	.byte 9,21,19,30
	.byte 24,23,29,24
	.byte 25,27,31,28
	.byte 9,31,22,34
	.byte 26,32,35,33
	.byte BOX_ADD_RSAME,27,38
	.byte BOX,9,35,19,41
	.byte 25,25,30,26
	.byte HLIN,16,17,7
	.byte HLIN_ADD,20,21	; 8
	.byte HLIN,19,21,14
	.byte HLIN_ADD,18,19	; 15
	.byte HLIN,22,28,17
	.byte HLIN_ADD_LSAME,27 ; 22, 27, 18
	.byte HLIN,16,18,18
	.byte HLIN_ADD_LSAME,17 ; 16, 17, 19
	.byte HLIN,24,25,19
	.byte HLIN_ADD,9,20	; 20
	.byte 26,28	; 21
	.byte HLIN_ADD_RSAME,25	; 25 28 22
	.byte HLIN,25,32,29
	.byte HLIN_ADD_RSAME,26	; 26 32 30
	.byte HLIN,26,33,31
	.byte 28,33,39
	.byte HLIN_ADD_LSAME,31 ; 28, 31, 40
	.byte 29
	.byte VLIN,8,14,17
	.byte 9,13,21
	.byte 9,12,19
	.byte 6,7,20
	.byte PLOT,16,6
	.byte 23,14
	.byte 27,14
	.byte 17,16
	.byte 28,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,13,9
	.byte BOX_ADD_LSAME,14,16 ; 4, 10
	.byte 15,23
	.byte 16,25
	.byte 15,27
	.byte 14,29
	.byte 13,31
	.byte 12,33
	.byte 11,35
	.byte 10,37
	.byte 9,40
	.byte HLIN,4,8,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,20,31,22,33
	.byte HLIN,18,19,17
	.byte 21,22,19
	.byte VLIN,17,19,22
	.byte 15,16,19
	.byte PLOT,18,18
	.byte 18,20
	.byte SET_COLOR | WHITE
	.byte HLIN,20,22,34
	.byte PLOT,22,33
	.byte SET_COLOR | RED
	.byte 22,19
	.byte SET_COLOR | ORANGE
	.byte 20,20
	.byte END
; total size = 244
