	.byte SET_COLOR | GREY2
	.byte BOX,24,7,32,9
	.byte 25,14,32,19
	.byte BOX_ADD_RSAME,26,25
	.byte HLIN,26,30,13
	.byte 26,30,26
	.byte HLIN_ADD_LSAME,29 ; 26, 29, 27
	.byte HLIN,25,27,10
	.byte 26,27,28
	.byte PLOT,25,11
	.byte 28,12
	.byte SET_COLOR | BROWN
	.byte BOX,30,6,35,16
	.byte BOX_ADD_RSAME,32,22
	.byte 33,27	; 35 23
	.byte BOX,32,33,35,41
	.byte 34,28,35,32
	.byte SET_COLOR | GREY1
	.byte 9,12,20,17
	.byte BOX_ADD_LSAME,22,19 ; 9, 18
	.byte 20,25
	.byte 22,27
	.byte BOX,9,29,19,40
	.byte 27,36,34,38
	.byte BOX_ADD_RSAME,28,41
	.byte BOX,29,12,30,13
	.byte HLIN,9,23,6
	.byte 25,29,6
	.byte HLIN_ADD,9,22	; 7
	.byte HLIN,26,27,7
	.byte HLIN_ADD,9,20	; 8
	.byte HLIN_ADD_LSAME,19 ; 9, 19, 9
	.byte HLIN,19,21,11
	.byte 9,20,28
	.byte 31,33,33
	.byte HLIN_ADD_RSAME,30	; 30 33 34
	.byte HLIN,28,34,35
	.byte 9,18,41
	.byte 20,21,10
	.byte VLIN,16,20,31
	.byte 8,10,24
	.byte 17,19,25
	.byte PLOT,26,8
	.byte 32,22
	.byte 26,28
	.byte 33,32
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,15,9
	.byte BOX_ADD_LSAME,16,14 ; 4, 10
	.byte 17,19
	.byte 16,21
	.byte 15,23
	.byte 14,25
	.byte 13,27
	.byte 12,29
	.byte 11,31
	.byte 10,34
	.byte 9,37
	.byte 8,41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,18,26,21,27
	.byte 17,6,18,9
	.byte VLIN,6,7,20
	.byte 24,25,20
	.byte PLOT,17,10
	.byte SET_COLOR | GREEN
	.byte BOX,29,9,30,10
	.byte HLIN,25,27,6
	.byte 30,31,16
	.byte VLIN,11,15,30
	.byte 6,8,29
	.byte 17,18,31
	.byte SET_COLOR | LIGHT_BLUE
	.byte 23,28,18
	.byte 23,26,22
	.byte SET_COLOR | WHITE
	.byte BOX,21,18,22,19
	.byte VLIN,27,28,22
	.byte PLOT,22,17
	.byte SET_COLOR | RED
	.byte 22,27
	.byte SET_COLOR | ORANGE
	.byte 20,28
	.byte END
; total size = 242
