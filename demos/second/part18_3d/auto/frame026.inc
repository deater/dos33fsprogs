	.byte SET_COLOR | WHITE
	.byte BOX,4,6,34,34
	.byte 4,36,5,41
	.byte HLIN,4,26,35
	.byte HLIN_ADD,9,25	; 36
	.byte 12,24	; 37
	.byte SET_COLOR | BROWN
	.byte BOX,6,6,24,15
	.byte BOX_ADD_LSAME,23,35 ; 6, 16
	.byte BOX,20,36,23,37
	.byte VLIN,6,32,30
	.byte SET_COLOR | GREY1
	.byte BOX,14,21,22,22
	.byte 14,19,17,21
	.byte HLIN,15,22,23
	.byte HLIN_ADD_RSAME,19	; 19 22 24
	.byte HLIN,33,35,30
	.byte HLIN_ADD_RSAME,32	; 32 35 31
	.byte 31	; 31 35 32
	.byte HLIN,30,34,33
	.byte HLIN_ADD_RSAME,28	; 28 34 34
	.byte HLIN,6,11,34
	.byte HLIN_ADD_LSAME,15 ; 6, 15, 35
	.byte HLIN,27,33,35
	.byte HLIN_ADD,9,19	; 36
	.byte HLIN,26,32,36
	.byte HLIN_ADD,12,22	; 37
	.byte HLIN,25,32,37
	.byte HLIN_ADD,15,31	; 38
	.byte 18,30	; 39
	.byte 22,29	; 40
	.byte HLIN,6,9,40
	.byte HLIN_ADD_LSAME,11 ; 6, 11, 41
	.byte HLIN,25,29,41
	.byte 6,7,33
	.byte PLOT,35,27
	.byte 35,29
	.byte 6,39
	.byte SET_COLOR | DARK_BLUE
	.byte HLIN,20,21,20
	.byte HLIN_ADD_LSAME,22 ; 20, 22, 21
	.byte HLIN,21,22,22
	.byte VLIN,6,26,35
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,15,16,18
	.byte 15,17,21
	.byte 20,21,23
	.byte HLIN_ADD,15,17	; 24
	.byte 20,21	; 25
	.byte VLIN,21,22,22
	.byte PLOT,17,20
	.byte 17,23
	.byte SET_COLOR | GREY2
	.byte HLIN,6,9,41
	.byte PLOT,19,39
	.byte 6,40
	.byte SET_COLOR | RED
	.byte HLIN,14,16,21
	.byte SET_COLOR | ORANGE
	.byte HLIN_ADD,18,19	; 22
	.byte END
; total size = 177
