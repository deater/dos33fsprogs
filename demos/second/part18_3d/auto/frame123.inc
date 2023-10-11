	.byte SET_COLOR | ORANGE
	.byte BOX,19,6,35,41
	.byte SET_COLOR | DARK_BLUE
	.byte 4,6,12,41
	.byte SET_COLOR | PINK
	.byte 26,8,35,11
	.byte BOX_ADD_RSAME,27,18
	.byte 28,21	; 35 19
	.byte BOX,20,29,28,36
	.byte BOX_ADD_LSAME,29,41 ; 20, 37
	.byte HLIN,26,35,6
	.byte HLIN_ADD_RSAME,20	; 20 35 7
	.byte HLIN,28,33,22
	.byte HLIN_ADD_LSAME,31 ; 28, 31, 23
	.byte HLIN,22,27,27
	.byte HLIN_ADD_RSAME,20	; 20 27 28
	.byte PLOT,35,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,16,6,23,9
	.byte 4,9,14,17
	.byte 17,12,18,16
	.byte 12,18,14,22
	.byte 13,35,17,37
	.byte 13,37,16,38
	.byte HLIN,8,13,7
	.byte HLIN_ADD_RSAME,6	; 6 13 8
	.byte HLIN,17,21,10
	.byte HLIN_ADD_LSAME,20 ; 17, 20, 11
	.byte HLIN,4,9,18
	.byte HLIN_ADD_LSAME,7 ; 4, 7, 19
	.byte HLIN,13,19,34
	.byte PLOT,4,20
	.byte SET_COLOR | GREY1
	.byte BOX,13,9,14,16
	.byte 17,15,18,16
	.byte 17,21,18,23
	.byte 13,23,14,24
	.byte BOX_ADD,18,19,34	; 25
	.byte BOX,13,29,15,32
	.byte BOX_ADD_LSAME,16,34 ; 13, 33
	.byte BOX,19,37,20,39
	.byte 13,39,16,41
	.byte 19,40,25,41
	.byte HLIN,16,17,9
	.byte VLIN,13,6,16
	.byte VLIN_ADD,17,22	; 14
	.byte VLIN,16,6,8
	.byte 16,37,38
	.byte VLIN_ADD,10,14	; 17
	.byte VLIN,19,35,36
	.byte PLOT,17,17
	.byte 18,24
	.byte 16,35
	.byte SET_COLOR | BROWN
	.byte BOX,26,8,30,11
	.byte BOX_ADD,27,29,17	; 12
	.byte BOX,27,30,28,34
	.byte BOX_ADD_RSAME,26,36
	.byte BOX,26,37,29,41
	.byte HLIN,26,30,6
	.byte HLIN_ADD_RSAME,24	; 24 30 7
	.byte HLIN,27,28,18
	.byte VLIN,28,19,22
	.byte PLOT,24,6
	.byte 24,8
	.byte 28,29
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,11,6,12,8
	.byte BOX_ADD,12,13,12	; 9
	.byte BOX,12,24,13,26
	.byte 13,28,14,33
	.byte 13,35,14,38
	.byte BOX_ADD_LSAME,15,41 ; 13, 39
	.byte HLIN,13,15,34
	.byte VLIN,12,18,23
	.byte VLIN_ADD,13,16	; 13
	.byte PLOT,13,27
	.byte SET_COLOR | RED
	.byte 15,37
	.byte SET_COLOR | YELLOW
	.byte 16,37
	.byte END
; total size = 267
