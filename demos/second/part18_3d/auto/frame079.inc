	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,8,6,28,24
	.byte BOX_ADD,11,18,35	; 25
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,22,11,26,12
	.byte BOX_ADD_RSAME,23,14
	.byte BOX,21,6,22,7
	.byte HLIN,20,22,8
	.byte HLIN_ADD_LSAME,23 ; 20, 23, 9
	.byte 26
	.byte HLIN,25,26,9
	.byte PLOT,20,11
	.byte SET_COLOR | GREY1
	.byte BOX,28,7,35,9
	.byte 21,9,23,10
	.byte 22,18,31,19
	.byte BOX_ADD,4,10,25	; 20
	.byte 18,26,27	; 26
	.byte BOX,4,26,11,30
	.byte 17,28,25,29
	.byte 4,31,12,35
	.byte 33,33,35,34
	.byte 14,34,21,35
	.byte 32,35,35,36
	.byte BOX_ADD,4,19,38	; 37
	.byte BOX,31,37,35,38
	.byte BOX_ADD,4,18,40	; 39
	.byte BOX,30,39,35,40
	.byte 34,31,35,32
	.byte HLIN,29,35,6
	.byte 27,35,10
	.byte HLIN_ADD_RSAME,26	; 26 35 11
	.byte 25	; 25 35 12
	.byte 23	; 23 35 13
	.byte 25	; 25 35 14
	.byte HLIN,24,33,15
	.byte HLIN_ADD_RSAME,23	; 23 33 16
	.byte HLIN,23,32,17
	.byte 21,30,20
	.byte HLIN_ADD_LSAME,29 ; 21, 29, 21
	.byte HLIN,20,29,22
	.byte HLIN_ADD_LSAME,28 ; 20, 28, 23
	.byte HLIN,19,28,24
	.byte HLIN_ADD_LSAME,27 ; 19, 27, 25
	.byte HLIN,16,24,30
	.byte HLIN_ADD_LSAME,23 ; 16, 23, 31
	.byte HLIN,15,23,32
	.byte HLIN_ADD_LSAME,22 ; 15, 22, 33
	.byte HLIN,4,20,36
	.byte 4,17,41
	.byte 29,35,41
	.byte VLIN,6,30,35
	.byte PLOT,21,6
	.byte 20,8
	.byte 25,9
	.byte 22,11
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,7,8
	.byte BOX_ADD_LSAME,8,13 ; 4, 9
	.byte 9,19
	.byte 10,22
	.byte BOX,5,23,10,25
	.byte BOX_ADD_LSAME,11,27 ; 5, 26
	.byte BOX,6,28,11,29
	.byte 34,6,35,14
	.byte HLIN,7,11,30
	.byte HLIN_ADD,8,12	; 31
	.byte HLIN_ADD_RSAME,9	; 9 12 32
	.byte 10	; 10 12 33
	.byte 11	; 11 12 34
	.byte VLIN,15,28,35
	.byte PLOT,12,35
	.byte SET_COLOR | RED
	.byte HLIN,23,24,13
	.byte PLOT,25,12
	.byte SET_COLOR | ORANGE
	.byte 22,12
	.byte END
; total size = 240
