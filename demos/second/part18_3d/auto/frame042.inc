	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte 4,25,23,41
	.byte 6,19,22,24
	.byte SET_COLOR | WHITE
	.byte 4,13,22,18
	.byte 4,9,21,12
	.byte HLIN,7,19,6
	.byte HLIN_ADD,5,20	; 7
	.byte HLIN_ADD_RSAME,4	; 4 20 8
	.byte HLIN,4,19,19
	.byte HLIN_ADD_LSAME,16 ; 4, 16, 20
	.byte 13
	.byte 10
	.byte 7
	.byte 5
	.byte SET_COLOR | GREY1
	.byte BOX,20,16,22,18
	.byte BOX_ADD_RSAME,21,20
	.byte HLIN,20,21,15
	.byte 21,24,36
	.byte HLIN_ADD_RSAME,20	; 20 24 37
	.byte 19	; 19 24 38
	.byte 18	; 18 24 39
	.byte 17	; 17 24 40
	.byte 16	; 16 24 41
	.byte HLIN,23,24,35
	.byte PLOT,21,14
	.byte SET_COLOR | RED
	.byte HLIN,20,21,17
	.byte PLOT,21,18
	.byte END
; total size = 81
