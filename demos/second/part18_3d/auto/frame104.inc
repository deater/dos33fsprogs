	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,27,27
	.byte BOX_ADD,6,8,38	; 28
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,8,29,35,38
	.byte BOX_ADD_RSAME,5,41
	.byte BOX,9,19,35,28
	.byte HLIN,4,14,6
	.byte 28,35,14
	.byte HLIN_ADD_RSAME,27	; 27 35 15
	.byte 22	; 22 35 16
	.byte 17	; 17 35 17
	.byte 12	; 12 35 18
	.byte HLIN,4,10,7
	.byte SET_COLOR | PINK
	.byte BOX,23,18,29,19
	.byte BOX_ADD,12,18,21	; 20
	.byte BOX,12,28,18,29
	.byte 27,26,32,33
	.byte HLIN,21,23,20
	.byte 12,14,22
	.byte 12,14,30
	.byte VLIN,6,13,28
	.byte SET_COLOR | BROWN
	.byte BOX,30,6,35,8
	.byte BOX_ADD_RSAME,31,11
	.byte 30,13	; 35 12
	.byte BOX,26,24,31,25
	.byte BOX_ADD_LSAME,32,28 ; 26, 26
	.byte BOX,23,35,24,38
	.byte 9,37,10,41
	.byte 22,27,23,29
	.byte HLIN,28,30,14
	.byte 24,29,17
	.byte 13,18,19
	.byte HLIN_ADD,12,15	; 20
	.byte HLIN,21,22,20
	.byte 27,31,23
	.byte 16,18,27
	.byte HLIN_ADD,12,17	; 28
	.byte 27,28	; 29
	.byte VLIN,20,36,10
	.byte 21,26,22
	.byte 30,34,23
	.byte 39,41,24
	.byte 18,19,21
	.byte 30,31,27
	.byte PLOT,23,18
	.byte 12,29
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,17,8,19,11
	.byte 12,9,14,12
	.byte 7,10,9,13
	.byte 22,7,23,10
	.byte HLIN,22,23,15
	.byte HLIN_ADD,18,19	; 16
	.byte 13,14	; 17
	.byte 9,10	; 18
	.byte SET_COLOR | GREY1
	.byte BOX,5,39,7,41
	.byte 5,33,6,38
	.byte HLIN,6,7,6
	.byte 4,5,27
	.byte VLIN,21,26,4
	.byte 31,32,5
	.byte SET_COLOR | GREY2
	.byte HLIN,28,29,14
	.byte VLIN,6,8,30
	.byte PLOT,4,20
	.byte END
; total size = 223
