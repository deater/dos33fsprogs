	.byte SET_COLOR | BROWN
	.byte BOX,6,6,30,35
	.byte BOX_ADD,20,23,37	; 36
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,31,6,35,26
	.byte 20,20,21,22
	.byte SET_COLOR | GREY1
	.byte 31,29,35,32
	.byte BOX_ADD,24,34,34	; 33
	.byte BOX,24,36,32,37
	.byte 14,19,17,21
	.byte HLIN,14,19,21
	.byte HLIN_ADD_LSAME,20 ; 14, 20, 22
	.byte HLIN,15,22,23
	.byte HLIN_ADD_RSAME,19	; 19 22 24
	.byte HLIN,31,35,27
	.byte 6,11,34
	.byte HLIN_ADD_LSAME,15 ; 6, 15, 35
	.byte HLIN,24,33,35
	.byte HLIN_ADD,9,19	; 36
	.byte 12,22	; 37
	.byte 15,31	; 38
	.byte 18,30	; 39
	.byte 22,29	; 40
	.byte HLIN,6,9,40
	.byte HLIN_ADD_LSAME,11 ; 6, 11, 41
	.byte HLIN,25,29,41
	.byte 6,7,33
	.byte PLOT,6,39
	.byte SET_COLOR | WHITE
	.byte BOX,25,6,29,15
	.byte 31,6,34,29
	.byte 24,16,29,33
	.byte 4,6,5,41
	.byte HLIN,31,32,30
	.byte 24,27,34
	.byte HLIN_ADD_LSAME,26 ; 24, 26, 35
	.byte 25
	.byte PLOT,31,31
	.byte 24,37
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,15,16,18
	.byte 15,17,21
	.byte 20,21,23
	.byte HLIN_ADD,15,17	; 24
	.byte 20,21	; 25
	.byte VLIN,21,22,22
	.byte PLOT,17,20
	.byte 17,23
	.byte SET_COLOR | RED
	.byte HLIN,14,16,21
	.byte SET_COLOR | ORANGE
	.byte HLIN_ADD,18,19	; 22
	.byte END
; total size = 158
