	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,15
	.byte BOX_ADD_RSAME,18,20
	.byte 31,31	; 35 21
	.byte SET_COLOR | GREEN
	.byte BOX,4,11,10,12
	.byte BOX_ADD_LSAME,17,15 ; 4, 13
	.byte 11,18
	.byte 12,32
	.byte BOX,4,34,15,35
	.byte BOX_ADD_LSAME,16,38 ; 4, 36
	.byte 17,40
	.byte BOX,7,9,8,10
	.byte HLIN,4,18,41
	.byte SET_COLOR | GREY1
	.byte BOX,20,6,30,18
	.byte 12,6,16,7
	.byte 11,13,17,15
	.byte 15,19,30,20
	.byte 23,32,35,33
	.byte 25,35,35,36
	.byte 27,38,35,39
	.byte BOX_ADD_RSAME,28,41
	.byte BOX,13,16,17,17
	.byte HLIN,14,18,18
	.byte 16,28,21
	.byte HLIN_ADD_LSAME,25 ; 16, 25, 22
	.byte HLIN,17,22,23
	.byte 28,30,25
	.byte HLIN_ADD_RSAME,25	; 25 30 26
	.byte 23	; 23 30 27
	.byte HLIN,20,31,28
	.byte HLIN_ADD,21,32	; 29
	.byte HLIN_ADD_LSAME,33 ; 21, 33, 30
	.byte HLIN,22,34,31
	.byte 24,35,34
	.byte 26,35,37
	.byte 18,19,24
	.byte PLOT,10,11
	.byte 11,12
	.byte 30,24
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,30,15
	.byte 4,6,9,8
	.byte HLIN,4,7,9
	.byte HLIN_ADD_LSAME,6 ; 4, 6, 10
	.byte HLIN,20,28,16
	.byte HLIN_ADD_LSAME,26 ; 20, 26, 17
	.byte 24
	.byte 22
	.byte PLOT,4,11
	.byte 20,20
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,4,34,13,37
	.byte BOX_ADD_LSAME,12,41 ; 4, 38
	.byte BOX,10,26,13,27
	.byte HLIN,9,13,28
	.byte HLIN_ADD_RSAME,8	; 8 13 29
	.byte HLIN,8,14,30
	.byte HLIN_ADD_RSAME,6	; 6 14 31
	.byte 5	; 5 14 32
	.byte 4	; 4 14 33
	.byte HLIN,12,13,25
	.byte VLIN,15,16,11
	.byte 23,24,13
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,13,8,16,12
	.byte HLIN,12,16,7
	.byte 12,14,6
	.byte PLOT,16,6
	.byte SET_COLOR | PINK
	.byte BOX,8,6,9,8
	.byte PLOT,9,9
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,15,7,17,8
	.byte PLOT,15,9
	.byte SET_COLOR | RED
	.byte 15,8
	.byte 17,8
	.byte 16,9
	.byte SET_COLOR | GREY2
	.byte 10,10
	.byte 35,32
	.byte SET_COLOR | ORANGE
	.byte 14,6
	.byte END
; total size = 247
