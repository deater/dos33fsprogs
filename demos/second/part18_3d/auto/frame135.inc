	.byte SET_COLOR | PINK
	.byte BOX,4,6,14,10
	.byte BOX_ADD_LSAME,9,17 ; 4, 11
	.byte VLIN,4,18,19
	.byte SET_COLOR | GREY1
	.byte BOX,24,6,26,7
	.byte BOX_ADD_RSAME,23,9
	.byte BOX,20,12,26,13
	.byte 18,15,26,16
	.byte 12,16,14,19
	.byte 16,17,26,19
	.byte BOX_ADD_RSAME,10,22
	.byte BOX,16,24,26,25
	.byte BOX_ADD_RSAME,17,28
	.byte 18,30	; 26 29
	.byte BOX,4,31,11,34
	.byte 19,31,26,33
	.byte BOX_ADD_RSAME,20,35
	.byte BOX,4,35,12,37
	.byte 21,36,26,38
	.byte 4,38,13,40
	.byte 22,39,26,40
	.byte HLIN,15,17,6
	.byte HLIN_ADD,14,16	; 7
	.byte 13,15	; 8
	.byte 12,14	; 9
	.byte 22,26	; 10
	.byte HLIN,11,14,10
	.byte HLIN_ADD,21,26	; 11
	.byte HLIN,10,13,11
	.byte HLIN_ADD_LSAME,12 ; 10, 12, 12
	.byte HLIN,9,12,13
	.byte HLIN_ADD,19,26	; 14
	.byte HLIN,8,11,14
	.byte HLIN_ADD_LSAME,10 ; 8, 10, 15
	.byte HLIN,7,10,16
	.byte HLIN_ADD_RSAME,6	; 6 10 17
	.byte HLIN,5,8,18
	.byte HLIN_ADD_LSAME,7 ; 5, 7, 19
	.byte HLIN,4,7,20
	.byte HLIN_ADD_LSAME,6 ; 4, 6, 21
	.byte 5
	.byte HLIN,13,26,23
	.byte 9,10,29
	.byte HLIN_ADD_RSAME,8	; 8 10 30
	.byte HLIN,4,14,41
	.byte 23,26,41
	.byte VLIN,13,14,15
	.byte PLOT,4,23
	.byte SET_COLOR | BROWN
	.byte BOX,27,6,35,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,26,6,28
	.byte BOX_ADD_LSAME,5,30 ; 4, 29
	.byte 6,32
	.byte 7,35
	.byte 8,38
	.byte 9,41
	.byte PLOT,4,25
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,10,20,11,21
	.byte 15,20,16,21
	.byte HLIN,15,16,14
	.byte 10,14,22
	.byte VLIN,10,13,19
	.byte VLIN_ADD,11,12	; 11
	.byte VLIN,11,23,24
	.byte 15,11,13
	.byte VLIN_ADD,15,19	; 16
	.byte VLIN,16,22,24
	.byte SET_COLOR | WHITE
	.byte HLIN,7,8,24
	.byte HLIN_ADD_RSAME,6	; 6 8 25
	.byte HLIN,5,7,26
	.byte HLIN_ADD_RSAME,6	; 6 7 27
	.byte PLOT,8,23
	.byte 6,28
	.byte SET_COLOR | YELLOW
	.byte HLIN,13,14,23
	.byte END
; total size = 249
