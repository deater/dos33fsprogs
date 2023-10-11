	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,8,6,28,24
	.byte BOX_ADD,11,18,35	; 25
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,21,6,22,7
	.byte 22,11,26,12
	.byte BOX_ADD_RSAME,23,14
	.byte HLIN,20,22,8
	.byte HLIN_ADD_LSAME,23 ; 20, 23, 9
	.byte HLIN,25,26,9
	.byte HLIN_ADD_RSAME,20	; 20 26 10
	.byte PLOT,20,11
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,7,8
	.byte 28,7,35,9
	.byte 4,9,8,13
	.byte BOX_ADD_LSAME,9,19 ; 4, 14
	.byte 10,25
	.byte 11,30
	.byte 12,35
	.byte HLIN,29,35,6
	.byte 27,35,10
	.byte HLIN_ADD_RSAME,26	; 26 35 11
	.byte 25	; 25 35 12
	.byte 23	; 23 35 13
	.byte 25	; 25 35 14
	.byte VLIN,35,15,28
	.byte SET_COLOR | GREY1
	.byte BOX,28,7,33,9
	.byte 21,9,23,10
	.byte 22,18,31,19
	.byte 18,26,26,27
	.byte BOX_ADD,17,25,29	; 28
	.byte BOX,4,28,5,29
	.byte 34,31,35,32
	.byte BOX_ADD_RSAME,33,34
	.byte BOX,14,34,21,35
	.byte 32,35,35,36
	.byte BOX_ADD,4,19,38	; 37
	.byte BOX,31,37,35,38
	.byte BOX_ADD,4,18,40	; 39
	.byte BOX,30,39,35,40
	.byte HLIN,29,33,6
	.byte 27,33,10
	.byte HLIN_ADD_RSAME,26	; 26 33 11
	.byte 25	; 25 33 12
	.byte 23	; 23 33 13
	.byte 25	; 25 33 14
	.byte 24	; 24 33 15
	.byte 23	; 23 33 16
	.byte HLIN,23,32,17
	.byte 21,30,20
	.byte HLIN_ADD_LSAME,29 ; 21, 29, 21
	.byte HLIN,20,29,22
	.byte HLIN_ADD_LSAME,28 ; 20, 28, 23
	.byte HLIN,19,28,24
	.byte HLIN_ADD_LSAME,27 ; 19, 27, 25
	.byte HLIN,16,24,30
	.byte 4,6,30
	.byte HLIN_ADD,16,23	; 31
	.byte HLIN,4,7,31
	.byte HLIN_ADD,15,23	; 32
	.byte HLIN,4,8,32
	.byte HLIN_ADD,15,22	; 33
	.byte HLIN,4,9,33
	.byte HLIN_ADD_LSAME,10 ; 4, 10, 34
	.byte 11
	.byte 20
	.byte HLIN,4,17,41
	.byte 29,35,41
	.byte VLIN,4,23,27
	.byte 22,11,12
	.byte 35,29,30
	.byte PLOT,21,6
	.byte 20,8
	.byte 25,9
	.byte SET_COLOR | RED
	.byte HLIN,23,24,13
	.byte PLOT,25,12
	.byte SET_COLOR | ORANGE
	.byte 22,12
	.byte END
; total size = 241
