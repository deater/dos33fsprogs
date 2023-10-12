	.byte SET_COLOR | PINK
	.byte BOX,4,6,11,24
	.byte SET_COLOR | BROWN
	.byte 28,6,35,20
	.byte SET_COLOR | LIGHT_BLUE
	.byte 14,16,15,17
	.byte 8,17,12,18
	.byte BOX_ADD,6,16,22	; 19
	.byte BOX,15,24,16,26
	.byte 4,25,8,26
	.byte BOX_ADD,14,16,34	; 27
	.byte BOX,8,28,9,29
	.byte 6,33,8,34
	.byte BOX_ADD_RSAME,5,36
	.byte BOX,4,37,7,38
	.byte BOX_ADD_LSAME,6,40 ; 4, 39
	.byte HLIN,11,15,7
	.byte HLIN_ADD_LSAME,14 ; 11, 14, 8
	.byte HLIN,12,14,9
	.byte HLIN_ADD_RSAME,11	; 11 14 10
	.byte HLIN,11,13,11
	.byte HLIN_ADD_LSAME,14 ; 11, 14, 12
	.byte HLIN,10,14,13
	.byte HLIN_ADD,9,15	; 14
	.byte HLIN_ADD_LSAME,11 ; 9, 11, 15
	.byte HLIN,13,15,15
	.byte HLIN_ADD,9,12	; 16
	.byte HLIN,14,16,18
	.byte 5,16,23
	.byte HLIN_ADD_LSAME,13 ; 5, 13, 24
	.byte HLIN,10,13,25
	.byte 4,9,27
	.byte 5,6,41
	.byte VLIN,6,8,18
	.byte 9,30,31
	.byte PLOT,7,32
	.byte SET_COLOR | GREY1
	.byte BOX,22,7,27,9
	.byte BOX_ADD_RSAME,21,11
	.byte BOX,19,15,30,16
	.byte 10,16,11,18
	.byte BOX_ADD_LSAME,12,26 ; 10, 19
	.byte BOX,14,20,15,21
	.byte 17,21,35,27
	.byte 5,23,6,24
	.byte 4,26,7,27
	.byte 13,29,35,33
	.byte 4,29,5,30
	.byte 15,35,35,36
	.byte 18,39,35,40
	.byte HLIN,23,27,6
	.byte 11,14,6
	.byte HLIN_ADD,13,15	; 7
	.byte HLIN_ADD_LSAME,14 ; 13, 14, 8
	.byte HLIN,20,27,12
	.byte 11,12,12
	.byte HLIN_ADD,20,28	; 13
	.byte HLIN,10,12,13
	.byte HLIN_ADD,20,29	; 14
	.byte HLIN,18,31,17
	.byte HLIN_ADD_LSAME,32 ; 18, 32, 18
	.byte 33
	.byte HLIN,17,34,20
	.byte 4,6,25
	.byte 16,35,28
	.byte 4,6,28
	.byte 14,35,34
	.byte 16,35,37
	.byte HLIN_ADD_RSAME,17	; 17 35 38
	.byte HLIN,19,35,41
	.byte VLIN,4,31,32
	.byte 11,7,8
	.byte 11,10,11
	.byte 14,9,10
	.byte 14,27,28
	.byte PLOT,12,14
	.byte 10,15
	.byte 15,24
	.byte SET_COLOR | RED
	.byte VLIN,6,22,25
	.byte VLIN_ADD,26,27	; 7
	.byte 28,29	; 8
	.byte SET_COLOR | YELLOW
	.byte HLIN,11,12,26
	.byte END
; total size = 274
